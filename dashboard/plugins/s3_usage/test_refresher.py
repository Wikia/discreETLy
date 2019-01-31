import logging
from .refresher import S3StatsRefreshTask, STATS_DB_PATH
from .statsdb import S3StatsDB
from moto import mock_s3
import os
import boto3
import pytest

@pytest.yield_fixture(scope="function")
def fixtures(request):
    mock_s3().start()
    task = S3StatsRefreshTask(
        logger=logging,
        buckets_regexp="^my-bucket$",
        aws_access_key_id='',
        aws_secret_access_key='',
        ttl=60
    )
    yield task, boto3.client("s3")

    if os.path.exists(STATS_DB_PATH):
        os.unlink(STATS_DB_PATH)
    mock_s3().stop()

def test_no_matching_bucket_and_no_failure(fixtures):
    # given no buckets
    task = fixtures[0]
    
    # when
    task.run()

    # then
    assert len(task.list_buckets()) == 0
    assert len(S3StatsDB(logging).query("")) == 0

def test_one_empty_bucket_case(fixtures):
    # given
    task = fixtures[0]
    s3client = fixtures[1]
    s3client.create_bucket(Bucket='my-bucket')

    # when
    task.run()

    # then
    stats = S3StatsDB(logging).query("")[0]
    assert stats['size'] == 0
    assert stats['files'] == 0


def test_files_in_bucket_root(fixtures):
    # given
    task = fixtures[0]
    s3client = fixtures[1]
    s3client.create_bucket(Bucket='my-bucket')
    s3client.put_object(Body='hello', Bucket='my-bucket', Key='hello')
    s3client.put_object(Body='world', Bucket='my-bucket', Key='world')

    # when
    task.run()

    # then
    global_stats = S3StatsDB(logging).query("")[0]
    assert global_stats['size'] == len('hello') + len('world')
    assert global_stats['files'] == 2
    root_stats = S3StatsDB(logging).query("/my-bucket", depth=1)[0]
    assert root_stats['size'] == len('hello') + len('world')
    assert root_stats['files'] == 2

def test_files_and_directories(fixtures):
    # given
    task = fixtures[0]
    s3client = fixtures[1]
    s3client.create_bucket(Bucket='my-bucket')
    s3client.put_object(Body='hello', Bucket='my-bucket', Key='greeting/hello')
    s3client.put_object(Body='world', Bucket='my-bucket', Key='greeting/world')
    s3client.put_object(Body='see_greeting!', Bucket='my-bucket', Key='clue')

    # when
    task.run()

    # then
    root_stats = S3StatsDB(logging).query("/my-bucket", depth=1)[0]
    assert root_stats['size'] == len('hello') + len('world') + len('see_greeting!')
    assert root_stats['files'] == 3

    greeting_stats = S3StatsDB(logging).query("/my-bucket/greeting", depth=2)[0]
    assert greeting_stats['size'] == len('hello') + len('world')
    assert greeting_stats['files'] == 2

def test_different_storage_classes(fixtures):
    # given
    task = fixtures[0]
    s3client = fixtures[1]
    s3client.create_bucket(Bucket='my-bucket')
    s3client.put_object(Body='test', Bucket='my-bucket', Key='standard', StorageClass='STANDARD')
    s3client.put_object(Body='test', Bucket='my-bucket', Key='ia', StorageClass='STANDARD_IA')
    # can't test GLACIER (https://stackoverflow.com/a/41841229/7098262)

    # when
    task.run()

    # then
    global_stats = S3StatsDB(logging).query("")[0]
    assert global_stats['size'] == 2 * len('test')
    assert global_stats['size_standard'] == len('test')
    assert global_stats['size_ia'] == len('test')
    assert global_stats['files'] == 2