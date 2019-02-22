import operator
from datetime import datetime, timedelta
from typing import List
import functools

from boto3.dynamodb.types import TypeDeserializer

from .athena_query_model import AthenaQuery, DATE_FORMAT

class QueryDao:
    """ This class is responsible for querying dynamoDB """

    def __init__(self, config, dynamodb, logger):
        self.config = config
        self.dynamodb = dynamodb
        # self.queries_table = self.dynamodb.Table(self.config['QUERIES_TABLE'])
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
        # prepared_days_request_items = {
        #                    f"{self.config['QUERIES_TABLE']}": {
        #                        'Keys': [{'start_date': date_timestamp_pair.date, 'start_timestamp': date_timestamp_pair.db_timestamp} for date_timestamp_pair in dates_timestamps_pairs_for_days_back]}
        #                }

        # # Attr('query_state').eq('SUCCEEDED')
        # batch_get_finished_queries_for_days_function_call = functools.partial(self.dynamodb.batch_get_item,
        #                                                                       RequestItems=prepared_days_request_items)
        #
        # response = batch_get_finished_queries_for_days_function_call()
        # data = response['Responses']
        # self.logger.debug(response['Responses'])
        #
        # # check for paginated results
        # while response.get('UnprocessedKeys'):
        #     response = batch_get_finished_queries_for_days_function_call(
        #         ExclusiveStartKey=response['UnprocessedKeys'])
        #     data.extend(response['Responses'])

        self.logger.debug("athena_usage starting querying athena database")


        # DEBUG: one can reduce number of queries here to check for operations
        # without worrying about timeouts
        # results: List[AthenaQuery] = functools.reduce(operator.concat,
        #                                               map(self.__query_specific_date, days_back_dates_str[0:1]))
        # TODO: this map function call can be threaded for speed improvements
        results: List[AthenaQuery] = functools.reduce(operator.concat,
                                                      map(self.__query_specific_date, days_back_dates_str))
        self.logger.debug("athena_usage finished querying athena database")
        return results

    def __query_specific_date(self, date) -> List[AthenaQuery]:
        """
        Private method to query for all queries
        made on a particular date with data_scanned > 0
        :param date: str date of DATE_FORMAT
        :return: List of AthenaQuery, results of this operation
        """
        # low level client type query is used instead of resource
        # due to higher level resource query not allowing to filter
        # data_scanned > 0

        # start_timestamp is queried for 'true' 24h days calculation
        # instead of a 'day' being 24h +- 11.59h
        query_finished_queries_for_days_function_call = functools.partial(
            self.dynamodb.query,
            TableName=self.config['QUERIES_TABLE'],
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
        # so it needs to be deserialized while taking into account dynamodb's ('S'..) types

        python_data = [{field_name: TypeDeserializer().deserialize(type_value_dict)
                       for field_name, type_value_dict in data_entry.items()}
                       for data_entry in data]

        return [AthenaQuery(start_date=date, **item) for item in python_data]

