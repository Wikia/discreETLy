import json
from dataclasses import dataclass
from collections import defaultdict
from dashboard.utils.vis import tree_diagram


class ReportsDataProvider:

    def __init__(self, airflow, reports):

        self.__airflow = airflow
        self.__reports = reports
        self.COLORS = {
            "success": 1,
            "pending": 2,
            "failure": 3
        }

    @property
    def reports(self):

        statuses = self.__fetch_status(self.__reports)

        output_reports = []

        for report in self.__reports:

            id_mapping = {table['id']: index+2
                        for index, table in enumerate(report['definition']['tables'])}

            tables = [{'id': id_mapping[table['id']],
                    'tid': table['tid'],
                    'name': table['name'],
                    'parent': id_mapping.get(table.get('parent', None)),
                    'success': self.COLORS.get(statuses[table['id']], "black")
                    }
                    for table in report['definition']['tables']]

            parent_updated = [{**table, **{'parent': 1}}
                    if table['parent'] is None else table
                    for table in tables]

            output_reports.append({
                'id': report['id'],
                'name': report['definition']['name'],
                'data': json.dumps(
                        tree_diagram([{'id': 1, 'tid': None, 'name': report['definition']['name'], 'success': 0}] + parent_updated, provide_links=True)
                    )
                })

        return output_reports

    def __fetch_status(self, reports):
        grouped = defaultdict(list)

        for report in reports:
            for table in report['definition']['tables']:
                grouped[table['dag']].append(table['id'])

        return {status['task_id']: status['state'] for status in self.__airflow.get_report_table_state(grouped)}
