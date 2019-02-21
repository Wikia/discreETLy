from datetime import datetime, timedelta

from boto3.dynamodb.conditions import Key, Attr

from.athena_query_model import AthenaQuery, TIMESTAMP_FORMAT, QueryState


class QueryDao:

    def __init__(self, config, dynamodb):
        self.config = config
        self.dynamodb = dynamodb

    def get_running_queries(self):
        _timestamp_30_days_back_py = datetime.now() - timedelta(days=30)
        timestamp_30_days_back_str = datetime.strftime(_timestamp_30_days_back_py,
                                                       TIMESTAMP_FORMAT)
        date_30_days_back_str = datetime.strftime(_timestamp_30_days_back_py, '%Y-%m-%d')

        response = self.dynamodb.Table(self.config['QUERIES_TABLE']).scan(
            # KeyConditionExpression=Key('start_date').(date_30_days_back_str) & Key('start_timestamp').gte(timestamp_30_days_back_str),
            FilterExpression=Attr('query_state').eq('SUCCEEDED') & Attr('start_date').gte(date_30_days_back_str)
        )
        return [AthenaQuery(**item) for item in response.get('Items', [])]

