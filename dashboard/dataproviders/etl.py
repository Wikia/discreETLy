import datetime
from dashboard.models import EtlWithProgress


class EtlDataProvider:

    def __init__(self, config,  extra_etls, airflow_data_provider, tables_data_provider):
        self.config = config
        self.extra_etls = extra_etls
        self.airflow_data_provider = airflow_data_provider
        self.tables_data_provider = tables_data_provider

    def _get_etl_with_progress(self, dag_id, tasks):
        tasks = [task for task in tasks if task.dag_name == dag_id]
        completed_tasks = set([task.task_id for task in tasks if task.is_done()])
        tables = [table for table in self.tables_data_provider.get_tables() if table.dag_id == dag_id] if self.tables_data_provider else None

        if tasks[0].dag_state == 'running':
            try:
                duration = datetime.datetime.now() \
                            - min(filter(None, map(lambda t: t.start_date, tasks)))
            except ValueError as _:
                duration = datetime.timedelta(0)
        else:
            try:
                duration = max(filter(None, map(lambda t: t.end_date, tasks))) \
                            - min(filter(None, map(lambda t: t.start_date, tasks)))
            except ValueError as _:
                duration = datetime.timedelta(0)

        return EtlWithProgress(
                name= dag_id,
                schedule=tasks[0].execution_date,
                state=tasks[0].dag_state,
                tasks_completed=len(completed_tasks),
                tasks_total=len(tasks),
                tables_completed=sum([1 for table in tables if table.task_id in completed_tasks]) if tables else None,
                tables_total=len(tables) if tables else None,
                duration_seconds=duration.total_seconds(),
                dag_id=tasks[0].dag_id,
                last_execution_date=tasks[0].execution_date
            )

    def etl_with_progress(self):
        tasks_newest_instance = self.airflow_data_provider.get_newest_task_instances()
        dags = set([task.dag_name for task in tasks_newest_instance]) - set(self.config.get('TECHNICAL_ETLS', set()))

        return [self._get_etl_with_progress(dag, tasks_newest_instance) for dag in dags]
