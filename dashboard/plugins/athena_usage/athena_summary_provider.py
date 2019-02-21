import time
from collections import defaultdict
from typing import DefaultDict
from .query_dao import *


class AthenaSummaryProvider:
    """
    This class communicates with QueryDao in order to prepare summaries of athena usage
    """

    def __init__(self, config: dict, dynamodb):
        self.__query_dao = QueryDao(config, dynamodb)

    @property
    def summary_user_timespan_size(self) -> DefaultDict[str, DefaultDict[str, int]]:
        """
        This gets a username dict containing a sum of size of user's queries in
        three timespans: last month, week, and a day
        :return: Dict[username] -> Dict['month' | 'week' | 'day'] -> sum(sizes)
        """
        # looking only 30 days back since it's the most we are going to present
        all_queries_list = self.__query_dao.get_finished_queries_for_days_back(30)

        # prepare a dict of username: dict(daily, weekly, monthly usage)
        summary_dict = defaultdict(lambda: defaultdict(lambda: 0))
        for query in all_queries_list:
            # convert queries str start_timestamp to float for easier comparisons
            query_timestamp_from_date = time.mktime(datetime.strptime(query.start_timestamp, TIMESTAMP_FORMAT).timetuple())

            # add query's size to monthly usage (it's guaranteed to be in the last 30 days)
            summary_dict[query.executing_user]['month']+=query.data_scanned

            # check if a query is less than a week old
            if time.time() - query_timestamp_from_date <= 7 * 24 * 60 * 60:
                summary_dict[query.executing_user]['week'] += query.data_scanned

                # check if a query is less than a day old
                if time.time() - query_timestamp_from_date <= 1 * 24 * 60 * 60:
                    summary_dict[query.executing_user]['day'] += query.data_scanned

        return summary_dict
    
            
            
