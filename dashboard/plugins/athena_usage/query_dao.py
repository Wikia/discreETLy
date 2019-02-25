from calendar import timegm
from datetime import datetime, timedelta
import time
from typing import Set
import functools
from math import ceil

from boto3.dynamodb.types import TypeDeserializer

from .athena_query_model import AthenaQuery, DATE_FORMAT, Timespan, \
    TIMESTAMP_FORMAT


class QueryDao:
    """ This class is responsible for querying dynamoDB """

    def __init__(self, config, dynamodb, logger):
        self._config = config
        self._dynamodb = dynamodb
        self.logger = logger
        self._query_cache: Set[AthenaQuery] = None
        self._last_cached_time = None

    @property
    def queries_last_30_days(self) -> Set[AthenaQuery]:
        """
        This returns last 30 days of queries made, without making additional
        requests if not needed.

        :return: set of AthenaQueries containing the request made in the last 30 days
        """
        # TODO: this makes
        # if no previous queries are cached
        if self._query_cache is None:
            self._query_cache = self._get_finished_queries_for_days_back(30)
            self._last_cached_time = time.time()
        else:
            # just need to get missing queries from _last_cached_time to now
            _time_passed_since_cached = self._last_cached_time - time.time()
            # convert time passed to days: int with rounding up to not miss a day to query
            days_passed_since_cached = ceil(_time_passed_since_cached / Timespan.DAY.value)

            new_queries = self._get_finished_queries_for_days_back(days_passed_since_cached)

            self._query_cache.update(new_queries)
            self._last_cached_time = time.time()

            # remove unnecessary, old queries from cache
            self._remove_unnecessary_cached_queries()

        return self._query_cache

    def _remove_unnecessary_cached_queries(self):
        """
        Removes cached queries older than a month from memory
        in order to prevent cache swelling up in size
        """
        self._query_cache = set(filter(lambda x: time.time() - timegm(time.strptime(x.start_timestamp, TIMESTAMP_FORMAT)) < Timespan.MONTH.value,
                                   self._query_cache))

    def _get_finished_queries_for_days_back(self, timespan_days: int) -> Set[AthenaQuery]:
        """
        This gets queries made from days: int back to today
        :parameter timespan_days: int number of days to go back
        :return: Set of AthenaQueries containing the request made in that timespan
        """

        # prepare a list of str dates of days going from now to number timespan_days: int back
        days_back_dates_str = [datetime.strftime(datetime.now() - timedelta(days=days_back), DATE_FORMAT) for days_back in range(timespan_days + 1)]

        self.logger.debug(f"athena_usage starting querying {self._config['QUERIES_TABLE']} table "
                          f"for {timespan_days+1} days")
        self.logger.debug(f"athena_usage: querying for list of days: {days_back_dates_str}")

        # TODO: this map function call can be threaded for speed improvements
        results: Set[AthenaQuery] = set().union(*map(self._query_specific_date, days_back_dates_str))

        self.logger.debug(f"athena_usage finished querying {self._config['QUERIES_TABLE']} table "
                          f"for {timespan_days+1} days")
        return results

    def _query_specific_date(self, date) -> Set[AthenaQuery]:
        """
        Private method to query for all queries
        made on a particular date with data_scanned > 0

        :param date: str date of DATE_FORMAT
        :return: Set of AthenaQuery, results of this operation
        """
        # low level client type query is used instead of resource
        # due to higher level resource query not allowing to filter
        # data_scanned > 0

        # start_timestamp is additionally queried for 'true' 24h days calculation
        # instead of a 'day' being 24h +- 11.59h
        query_finished_queries_for_days_function_call = functools.partial(
            self._dynamodb.query,
            TableName=self._config['QUERIES_TABLE'],
            ProjectionExpression='data_scanned, executing_user, start_timestamp',
            KeyConditionExpression='start_date = :date',
            ExpressionAttributeValues={':date': {'S': f'{date}'},
                                       ':num': {'N': '0'}},
            FilterExpression='#ds > :num',
            ExpressionAttributeNames={'#ds': 'data_scanned'}
        )

        response = query_finished_queries_for_days_function_call()
        data = response['Items']

        # check for paginated results
        while response.get('LastEvaluatedKey'):
            response = query_finished_queries_for_days_function_call(
                ExclusiveStartKey=response['LastEvaluatedKey'])
            data.extend(response['Items'])

        # data that comes is a list in elements of format:
        # 'start_timestamp': {'S': '2019-01-23 18:47:04'}, ..
        # so it needs to be deserialized while taking into account _dynamodb's ('S'..) types

        python_data = [{field_name: TypeDeserializer().deserialize(type_value_dict)
                       for field_name, type_value_dict in data_entry.items()}
                       for data_entry in data]

        return set(AthenaQuery(start_date=date, **item) for item in python_data)

