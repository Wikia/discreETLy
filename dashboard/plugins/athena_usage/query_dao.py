from datetime import datetime, timedelta
from typing import List

from boto3.dynamodb.conditions import Attr

from .athena_query_model import AthenaQuery, TIMESTAMP_FORMAT


class QueryDao:

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

        response = self.dynamodb.Table(self.config['QUERIES_TABLE']).scan(
            FilterExpression=Attr('query_state').eq('SUCCEEDED') &
                             Attr('start_timestamp').gte(timestamp_30_days_back_str))

        return [AthenaQuery(**item) for item in response.get('Items', [])]
