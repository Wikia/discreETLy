import os
import logging

from dashboard.tests.mocks.database import SqliteService
from dashboard.dataproviders.airflow import AirflowDBDataProvider

logger = logging.Logger('Airflow.Test')

config = {
    'TECHNICAL_ETLS': set(['recover_partitions', 'jwplayer_import', 'operative_ftp_feed_2_s3', 'heartbeat'])
}

client = SqliteService()
SqliteService.migrate(
    client.conn, 
    'airflow.sql'
    )

airflow = AirflowDBDataProvider(config, logger, client)

def test_dag_state():
    assert airflow.get_dag_state('operative_data_import_v2.0', '2018-11-08 10:00:00.000') == 'success'
    assert airflow.get_dag_state('clickstream_view_special_v2.2', '2018-11-12 02:15:00.000') == 'failure'

def test_get_history():
    sample_dag = next(airflow.get_history(1)['clickstream_view_special'])
    assert sample_dag.dag_id == 'clickstream_view_special_v2.2'
    assert sample_dag.date == '2018-11-12 02:15:00.000'
    assert sample_dag.state == 'failure'

def test_get_dag_tasks_success():
    assert airflow.get_dag_tasks('clickstream_view_special_v2.2', '2018-11-12 02:15:00.000')[0].dag_id == 'clickstream_view_special_v2.2'

def test_get_dag_tasks_failure_wrong_date():
    assert airflow.get_dag_tasks('clickstream_view_special_v2.2', '2018-11-17 02:15:00.000') == []
