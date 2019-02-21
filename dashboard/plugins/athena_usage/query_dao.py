from datetime import datetime, timedelta
from typing import List
import functools
from collections import namedtuple

from boto3.dynamodb.conditions import Attr

from .athena_query_model import AthenaQuery, DATE_FORMAT, TIMESTAMP_FORMAT


class QueryDao:
    """ This class is responsible for querying dynamoDB """

    def __init__(self, config, dynamodb, logger):
        self.config = config
        self.dynamodb = dynamodb
        self.queries_table = self.dynamodb.Table(self.config['QUERIES_TABLE'])
        self.logger = logger

    def get_finished_queries_for_days_back(self, timespan_days: int) -> List[AthenaQuery]:
        """
        This gets queries made from days: int back to today
        :parameter timespan_days: int number of days to go back
        :return: list of AthenaQueries containing the request made in that timespan
        """
        # prepare a list of str dates of days going from now to number timespan_days: int back

        days_back_dates_str = [datetime.strftime(datetime.now() - timedelta(days=days_back), DATE_FORMAT) for days_back in range(0, timespan_days + 1)]
        # prepare a batch request body
        prepared_days_request_items = {
                           f"{self.config['QUERIES_TABLE']}": {
                               'Keys': [{'start_date': date_timestamp_pair.date, 'start_timestamp': date_timestamp_pair.db_timestamp} for date_timestamp_pair in dates_timestamps_pairs_for_days_back]}
                       }

        # Attr('query_state').eq('SUCCEEDED')
        batch_get_finished_queries_for_days_function_call = functools.partial(self.dynamodb.batch_get_item,
                                                                              RequestItems=prepared_days_request_items)

        response = batch_get_finished_queries_for_days_function_call()
        data = response['Responses']
        self.logger.debug(response['Responses'])

        # check for paginated results
        while response.get('UnprocessedKeys'):
            response = batch_get_finished_queries_for_days_function_call(
                ExclusiveStartKey=response['UnprocessedKeys'])
            data.extend(response['Responses'])

        return [AthenaQuery(**item) for item in data]
