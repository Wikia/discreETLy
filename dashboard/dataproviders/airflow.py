from functools import reduce
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
            SELECT dag_id, execution_date as date, state, ROW_NUMBER() OVER (PARTITION BY dag_id ORDER BY execution_date DESC) AS age
            FROM dag_run
        ) t WHERE age <= {days}
        '''
        data = self.client.query(SQL)

        dag_names = set(map(lambda row: clean_dag_id(row['dag_id']), data))

        return {dag_name: reversed([DagRun(**row) for row in data if clean_dag_id(row['dag_id']) == dag_name])
                for dag_name in dag_names}

    def get_last_successful_tasks(self):
        last_successful_task_end_date = '''
        SELECT dag_id, task_id, max(end_date) as end_date
        FROM task_instance
        WHERE state = "success"
        GROUP BY dag_id, task_id
        '''

        data = self.client.query(last_successful_task_end_date)
        result = {}

        for row in data:
            row['dag_name'] = clean_dag_id(row['dag_id'])
            key = row['dag_name'] + row['task_id']
            if key in result and row['end_date'] and result[key].end_date > row['end_date']:
                continue # duplicate with dag old version
            result[key] = TaskInstance(**row)

        return list(result.values())

    def get_newest_task_instances(self):
        newest_task_instances_sql = '''
        SELECT dr.dag_id, dr.execution_date, dag_state, task_id, ti.state AS task_state, duration, start_date, end_date FROM (
            SELECT dag_run.dag_id, execution_date, state AS dag_state, ROW_NUMBER() OVER (PARTITION BY dag_run.dag_id ORDER BY execution_date DESC) AS age 
            FROM dag_run
            JOIN dag ON dag.dag_id = dag_run.dag_id AND is_active = 1 AND is_paused = 0) dr 
        JOIN task_instance ti ON ti.dag_id = dr.dag_id AND ti.execution_date = dr.execution_date
        WHERE dr.age = 1'''.replace("\n", "")

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
        SELECT * FROM (
            SELECT dag.dag_id, state, ROW_NUMBER() OVER (PARTITION BY dag.dag_id ORDER BY execution_date DESC) AS age 
            FROM dag_run
            JOIN dag ON dag.dag_id = dag_run.dag_id AND is_active = 1 AND is_paused = 0) dr 
        WHERE age = 1'''.replace("\n", "")
        return [{
            'name': clean_dag_id(dag['dag_id']),
            'state': dag['state']}
            for dag in self.client.query(latest_dags_status_sql)
            if clean_dag_id(dag['dag_id']) not in self.config.get('TECHNICAL_ETLS', set())]