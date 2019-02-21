from datetime import datetime, timedelta
from typing import List
import functools

from boto3.dynamodb.conditions import Attr

from .athena_query_model import AthenaQuery, TIMESTAMP_FORMAT


class QueryDao:
    """ This class is responsible for querying dynamoDB """

    def __init__(self, config, dynamodb):
        self.config = config
        self.dynamodb = dynamodb
        self.queries_table = self.dynamodb.Table(self.config['QUERIES_TABLE'])

    def get_finished_queries_for_days_back(self, days: int) -> List[AthenaQuery]:
        """
        This gets queries made from days: int back to today of status succeeded
        :parameter days: int number of days to go back
        :return: list of AthenaQueries containing the request made in the timespan
        """
        _timestamp_30_days_back_py = datetime.now() - timedelta(days=days)
        timestamp_30_days_back_str = datetime.strftime(_timestamp_30_days_back_py, TIMESTAMP_FORMAT)

        scan_finished_queries_for_days_function_call = functools.partial(self.queries_table.scan,
                                                                         Attr('query_state').eq('SUCCEEDED') &
                                                                         Attr('start_timestamp').gte(timestamp_30_days_back_str))
        response = scan_finished_queries_for_days_function_call()
        data = response['Items']

        # check for paginated results
        while response.get('LastEvaluatedKey'):
            response = scan_finished_queries_for_days_function_call(
                ExclusiveStartKey=response['LastEvaluatedKey'])
            data.extend(response['Items'])

        return [AthenaQuery(**item) for item in data]
