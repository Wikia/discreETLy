from dashboard.plugins.s3_usage.statsdb import S3Stats
from dashboard.tests.mocks.database import SqliteService
from dashboard.plugins.s3_usage.refresher import STATS_DB_PATH
import pytest
import logging

@pytest.fixture(scope='session')
def s3stats(request):
    sqlite = SqliteService(STATS_DB_PATH)
    SqliteService.migrate(sqlite.conn, 'dashboard/plugins/s3_usage/tests/s3stats.sql')
    return S3Stats(logging)

def test_list_buckets(s3stats):
    # when
    stats = s3stats.get_jstree_buckets(order='size_desc')

    # then
    assert stats['text'] == 'All buckets  (5 files, 5.0MiB)'
    assert len(stats['children']) == 2
    assert stats['children'][0]['text'] == 'discreetly-bucket1 (3 files, 3.0MiB)'
    assert stats['children'][0]['children'] == True
    assert stats['children'][1]['text'] == 'discreetly-bucket2 (2 files, 2.0MiB)'
    assert stats['children'][1]['children'] == True

def test_list_buckets_change_order(s3stats):
    # when
    stats = s3stats.get_jstree_buckets(order='alphabetically')

    # then
    assert stats['text'] == 'All buckets  (5 files, 5.0MiB)'
    assert len(stats['children']) == 2
    assert stats['children'][0]['text'] == 'discreetly-bucket1 (3 files, 3.0MiB)'
    assert stats['children'][0]['children'] == True
    assert stats['children'][1]['text'] == 'discreetly-bucket2 (2 files, 2.0MiB)'
    assert stats['children'][1]['children'] == True

def test_list_directories_leafs(s3stats):
    # when
    stats = s3stats.get_jstree_directories(base='/discreetly-bucket2', order='size_desc')

    # then
    assert len(stats) == 2
    assert stats[0]['text'] == 'dir1 (1 files, 1.0MiB)'
    assert stats[0]['children'] == False
    assert stats[1]['text'] == 'dir2 (1 files, 1.0MiB)'
    assert stats[1]['children'] == False

def test_list_directories_non_leafs(s3stats):
    # when
    stats = s3stats.get_jstree_directories(base='/discreetly-bucket1/table', order='size_desc')

    # then
    assert len(stats) == 1
    assert stats[0]['text'] == 'year=2019 (3 files, 3.0MiB)'
    assert stats[0]['children'] == True

def test_sunburst_data_on_root(s3stats):
    # when
    stats = s3stats.get_vega_sunburst(base='', size=3)

    # then
    expected_response = [
        {'id': 1, 'size': 0, 'name': '', 'size_fmt': '5.0MiB'}, 
        {'id': 2, 'size': 0, 'name': 'discreetly-bucket1', 'size_fmt': '3.0MiB', 'parent': 1}, 
        {'id': 3, 'size': 0, 'name': 'table', 'size_fmt': '3.0MiB', 'parent': 2}, 
        {'id': 4, 'size': 3145728, 'name': 'year=2019', 'size_fmt': '3.0MiB', 'parent': 3}, 
        {'id': 5, 'size': 0, 'name': 'discreetly-bucket2', 'size_fmt': '2.0MiB', 'parent': 1}, 
        {'id': 6, 'size': 1048576, 'name': 'dir1', 'size_fmt': '1.0MiB', 'parent': 5}, 
        {'id': 7, 'size': 1048576, 'name': 'dir2', 'size_fmt': '1.0MiB', 'parent': 5}
    ]
    assert stats == expected_response

def test_sunburst_data_on_non_root(s3stats):
    # when
    stats = s3stats.get_vega_sunburst(base='/discreetly-bucket1/table/year=2019', size=3)

    # then
    expected_response = [
        {'id': 1, 'size': 0, 'name': 'year=2019', 'size_fmt': '3.0MiB'}, 
        {'id': 2, 'size': 0, 'name': 'month=01', 'size_fmt': '3.0MiB', 'parent': 1}, 
        {'id': 3, 'size': 1048576, 'name': 'day=01', 'size_fmt': '1.0MiB', 'parent': 2}, 
        {'id': 4, 'size': 1048576, 'name': 'day=02', 'size_fmt': '1.0MiB', 'parent': 2}, 
        {'id': 5, 'size': 1048576, 'name': 'day=03', 'size_fmt': '1.0MiB', 'parent': 2}]
    assert stats == expected_response