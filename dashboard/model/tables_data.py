import csv
from concurrent.futures import ThreadPoolExecutor

from dashboard.models import Period, Table
from dashboard.utils import clean_dag_id, handle_resource, simple_state
from dataclasses import dataclass


@dataclass
class TableSize:
    name: str
    size: int


@dataclass
class GraphVertex:
    id: str
    name: str
    state: str = 'unknown'
    tooltip: str = ''
    parent: str = None

    def get_graph_color(self):
        map = {
            'success': 1,
            'running': 2,
            'failed': 3
        }
        if self.state in map:
            return map[self.state]
        return 0  # unknown

@dataclass
class DagTableProgress:
    dag_name: str
    tables_done: int
    tables_all: int


HISTOGRAM_DAYS_NUM = 7
DETAILED_CHART_DAYS_NUM = 30


class TableDataProvider:


    @staticmethod
    def _format_table_id(table):
        id = table['db'] + '.' + table['name']
        if 'period' in table:
            id += '.' + table['period']['name']
        return id

    @staticmethod
    def _process_input_tables(tables):
        output_tables = {}
        for table in tables:
            table['id'] = TableDataProvider._format_table_id(table)
            if 'period' in table:
                table['period'] = Period(**table['period'])
            output_tables[table['id']] = Table(**table)
        return output_tables

    def __init__(self, airflow, influx, prometheus, tables, logger, config):
        self.airflow = airflow
        self.influx = influx
        self.prometheus = prometheus
        self.tables = TableDataProvider._process_input_tables(tables)
        self.logger = logger
        self.influx_client_executor = ThreadPoolExecutor(max_workers=4) if self.influx else None
        self.config = config

    def get_tables(self):
        return list(self.tables.values())

    def history(self, table):
        return self.__get_detailed_view_data(self.tables[table], DETAILED_CHART_DAYS_NUM)

    def get_tables_by_dag(self, dag_name):
        return [table for table in self.tables.values() if table.dag_id == dag_name]

    def get_tables_graph(self, dag_id, execution_date):
        name_without_version = clean_dag_id(dag_id)
        dag_tables = self.get_tables_by_dag(name_without_version)
        dag_progess = {d.task_id: d for d in self.airflow.get_dag_tasks(dag_id, execution_date)}

        # root node - dag name
        yield GraphVertex(id='main', name=name_without_version,
                          state=self.airflow.get_dag_state(dag_id, execution_date))

        # tables
        for table in dag_tables:
            yield GraphVertex(
                id=table.id,
                name=table.name + (' ({})'.format(table.period.name) if table.period else ''),
                state=dag_progess[table.task_id].task_state,
                tooltip='Finished at: {}, duration: {}'.format(
                    dag_progess[table.task_id].end_date,
                    dag_progess[table.task_id].duration
                ),
                parent=table.get_parent()
            )

    @handle_resource('influx')
    def __get_detailed_view_data(self, table, days):
        influx_points = self.influx.get_influx_stats(table, days)
        return [(x['time'][:days], x['records']) for x in influx_points if x['records'] is not None]

    def __get_period_mapping(self):
        return {table.period.id: table.period.name for table in self.get_tables()
                if table.is_rollup()}

    @handle_resource('prometheus', {})
    def get_alerts(self):
        return self.prometheus.alerts()

    @handle_resource('prometheus')
    def active_alerts_for_table(self, db, table, alerts):
        return [{'name': alert['name'], 'link': self.prometheus.alert_link(alert['name'])}
                for alert in alerts if alert['db_table'] == f'{db}_{table}']

    def list_unordered(self, gather_counts):
        # Get data for all rows in one query to avoid multiple db lookups
        newest_task_instances = self.airflow.get_newest_task_instances()
        last_updates = self.airflow.get_last_successful_tasks()

        if gather_counts:
            emr_stats = self.influx.get_influx_data(days=HISTOGRAM_DAYS_NUM, period_mapping=self.__get_period_mapping()) if self.influx else {}
            alerts = self.get_alerts()
        else:
            emr_stats = {}
            alerts = {}

        for table in self.tables.values():
            table_id_underscore = table.id.replace('.', '_')
            if not table.streaming:
                # lookup the current row
                last_task_data = next((x for x in newest_task_instances if x.dag_name == table.dag_id
                                  and x.task_id == table.task_id), None)
                if last_task_data is None:
                    self.logger.warn(f'Missing task_instances entry for table {table}')
                    continue

                last_update = next((x.end_date for x in last_updates if x.dag_name == table.dag_id
                                  and x.task_id == table.task_id), None)

                state = simple_state(last_task_data.task_state)
                duration = last_task_data.duration
            else:
                duration = None
                # Todo edge cases in names
                table_stats = emr_stats.get(table_id_underscore)
                if table_stats:
                    last_update = table_stats[-1][0]
                    state = 'success'
                else:
                    last_update = None
                    state = 'success'

            row_counts = None
            if gather_counts and emr_stats and table_id_underscore in emr_stats:
                row_counts = sorted(
                    emr_stats[table_id_underscore][-HISTOGRAM_DAYS_NUM:], reverse=True, key=lambda tup: [0])

            yield {'id': table.id,
                   'name': table.name,
                   'dag_id': table.dag_id,
                   'task_id': table.task_id,
                   'glue': table.glue,
                   'last_update': last_update,
                   'counts': row_counts,
                   'load_duration_seconds': duration,
                   'active_alerts': self.active_alerts_for_table(table.db, table.name, alerts),
                   'link_descriptions': self.config['COLUMN_DESCRIPTION_ACTIVE'],
                   'state': state}

    def list(self, gather_counts=True):
        return sorted(self.list_unordered(gather_counts), key=lambda t: (t['state'], not t['active_alerts'], t['id']))

    def get_tables_with_size(self):
        with open('/app/config/sizes_static.csv') as csvfile:
            for row in csv.reader(csvfile):
                yield TableSize(row[0], int(row[2]))
