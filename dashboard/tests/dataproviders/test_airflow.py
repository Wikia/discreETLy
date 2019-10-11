import logging

from dashboard.tests.mocks.database import MysqlService
from dashboard.dataproviders.airflow import AirflowDBDataProvider
from datetime import datetime

logger = logging.Logger('Airflow.Test')

config = {
    'TECHNICAL_ETLS': set(['recover_partitions', 'jwplayer_import', 'operative_ftp_feed_2_s3', 'heartbeat'])
}

client = MysqlService()
client.migrate('dashboard/tests/mocks/airflow.sql')

airflow = AirflowDBDataProvider(config, logger, client)

def test_dag_state():
    assert airflow.get_dag_state('operative_data_import_v2.0', '2018-11-08 10:00:00.000') == 'success'
    assert airflow.get_dag_state('clickstream_view_special_v2.2', '2018-11-12 02:15:00.000') == 'failure'

def test_get_history():
    sample_dag = next(airflow.get_history(1)['clickstream_view_special'])
    assert sample_dag.dag_id == 'clickstream_view_special_v2.2'
    assert sample_dag.date == datetime(2018, 11, 12, 2, 15)
    assert sample_dag.state == 'failure'

def test_should_retrieve_only_the_recent_version():
    results = list(airflow.get_history(1)['multiple_versions'])
    assert len(results) == 1

    returned_object = results[0]
    assert returned_object.dag_id == 'multiple_versions_v2.3'
    assert returned_object.date == datetime(2018, 11, 12, 2, 15)
    assert returned_object.state == 'failure'

def test_get_dag_tasks_success():
    assert airflow.get_dag_tasks('clickstream_view_special_v2.2', '2018-11-12 02:15:00.000')[0].dag_id == 'clickstream_view_special_v2.2'

def test_get_dag_tasks_failure_wrong_date():
    assert airflow.get_dag_tasks('clickstream_view_special_v2.2', '2018-11-17 02:15:00.000') == []

def test_technical_dag_is_hidden():
    status = airflow.get_dags_status()
    assert 'heartbeat' not in [dag['name'] for dag in status]
    task_instances = set([task.dag_name for task in airflow.get_newest_task_instances()])
    assert 'heartbeat' not in task_instances

def test_paused_dag_is_hidden():
    status = airflow.get_dags_status()
    assert 'paused_dag' not in [dag['name'] for dag in status]
    task_instances = set([task.dag_name for task in airflow.get_newest_task_instances()])
    assert 'paused_dag' not in task_instances

def test_inactive_dag_is_hidden():
    status = airflow.get_dags_status()
    assert 'inactive_dag' not in [dag['name'] for dag in status]
    task_instances = set([task.dag_name for task in airflow.get_newest_task_instances()])
    assert 'inactive_dag' not in task_instances

def test_get_last_success_for_manually_marked_task():
    tasks = airflow.get_last_successful_tasks()
    succeeded_tasks_ids = [task.task_id for task in tasks]
    assert 'task_marked_manually' not in succeeded_tasks_ids
