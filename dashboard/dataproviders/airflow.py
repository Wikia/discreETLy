from dashboard.utils import clean_dag_id

from dashboard.models import DagRun, TaskInstance


class AirflowDBDataProvider:

    def __init__(self, config, logger, client):
        self.logger = logger
        self.config = config
        self.client = client

    def get_dag_state(self, dag_id, execution_date):
        result = self.client.query(
            f"select state from dag_run where dag_id = '{dag_id}' and execution_date = '{execution_date}'")
        return result[0]['state']

    def get_history(self, days):
        SQL = f'''
        SELECT dag_id, date, state FROM (
            SELECT
                @row_number:=CASE
                    WHEN @dag_id_current = clean_dag_id
                      THEN
                          @row_number + 1
                      ELSE
                           1
                    END AS rownum,
                @dag_id_current:=clean_dag_id clean_dag_id,
                dag_id,
                execution_date as date,
                state
            FROM (
                SELECT *,
                    CASE
                        WHEN substring_index(reverse(dag_id), "v_", 1) rlike '[0-9]+\.[0-9]'
                        THEN substring(dag_id, 1, length(dag_id) -1 - locate("v_", reverse(dag_id)))
                        ELSE dag_id
                    END as clean_dag_id from dag_run) dag_run, (SELECT @dag_id_current:='',@row_number:=0) as t
            ORDER BY clean_dag_id, execution_date DESC
        ) dr WHERE rownum <= {days}'''
        data = self.client.query(SQL)

        dag_names = set(map(lambda row: clean_dag_id(row['dag_id']), data))

        return {dag_name: reversed([DagRun(**row) for row in data if clean_dag_id(row['dag_id']) == dag_name])
                for dag_name in dag_names}

    def get_last_successful_tasks(self):
        last_successful_task_end_date = '''
        SELECT dag_id, task_id, max(end_date) as end_date
        FROM task_instance
        WHERE state = "success" AND end_date is not null
        GROUP BY dag_id, task_id
        '''

        data = self.client.query(last_successful_task_end_date)
        result = {}

        for row in data:
            row['dag_name'] = clean_dag_id(row['dag_id'])
            key = row['dag_name'] + row['task_id']
            if key in result and result[key].end_date > row['end_date']:
                continue # duplicate with dag old version
            result[key] = TaskInstance(**row)

        return list(result.values())

    def get_newest_task_instances(self):
        newest_task_instances_sql = '''
        SELECT
            dr.dag_id,
            dr.execution_date,
            dr_latest.state as dag_state,
            ti.task_id,
            ti.state as task_state,
            ti.duration,
            ti.start_date,
            ti.end_date
        FROM (
            SELECT dag_id,
                MAX(execution_date) as execution_date
            FROM dag_run
                GROUP BY dag_id) dr
        JOIN dag_run dr_latest ON dr.dag_id = dr_latest.dag_id AND dr.execution_date = dr_latest.execution_date
        JOIN task_instance ti ON dr.dag_id = ti.dag_id AND dr.execution_date = ti.execution_date
        JOIN dag ON dag.dag_id = dr.dag_id AND is_active = 1 AND is_paused = 0'''.replace("\n", "")

        data = self.client.query(newest_task_instances_sql)
        result = {}

        for row in data:
            row['dag_name'] = clean_dag_id(row['dag_id'])
            key = row['dag_name'] + row['task_id']
            if key in result and row['end_date'] and result[key].end_date > row['end_date']:
                continue # duplicate with dag old version
            
            if row['dag_name'] in self.config.get('TECHNICAL_ETLS', set()):
                continue # task instance from the technical ETL
                
            result[key] = TaskInstance(**row)

        return list(result.values())

    def get_dag_tasks(self, dag_id, execution_date):
        data = self.client.query(
            f"""SELECT dag_id, execution_date, task_id, start_date, end_date, duration, state as task_state 
            FROM task_instance WHERE dag_id='{dag_id}' AND execution_date='{execution_date}'""".replace("\n", ""))
        return [TaskInstance(**row) for row in data]


    def get_dags_status(self):
        '''
        For each non-technical DAG returns the name and the state of last run
        :return:
        '''

        latest_dags_status_sql = '''
        SELECT
           dag_run.dag_id,
           dag_run.state
        FROM dag_run
        INNER JOIN (SELECT
                        dag_id,
                        MAX(execution_date) AS date
                    FROM dag_run
                    GROUP BY dag_id) mx
            ON
            dag_run.dag_id = mx.dag_id
            AND dag_run.execution_date = mx.date
        JOIN dag ON dag.dag_id = dag_run.dag_id AND is_active = 1 AND is_paused = 0'''.replace("\n", "")
        return [{
            'name': clean_dag_id(dag['dag_id']),
            'state': dag['state']}
            for dag in self.client.query(latest_dags_status_sql)
            if clean_dag_id(dag['dag_id']) not in self.config.get('TECHNICAL_ETLS', set())]
