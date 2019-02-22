import time
from collections import defaultdict
from typing import DefaultDict

from dashboard.plugins.athena_usage.athena_query_model import TIMESTAMP_FORMAT
from dashboard.utils import sizeof_fmt
from .query_dao import *


class AthenaSummaryProvider:
    """
    This class communicates with QueryDao in order to prepare summaries of athena usage
    """

    def __init__(self, config: dict, dynamodb, logger):
        self.logger = logger
        self._query_dao = QueryDao(config, dynamodb, self.logger)
        # TODO: this needs to communicate with cached db states

    @property
    def _summary_user_timespan_size_B(self) -> DefaultDict[str, DefaultDict[str, int]]:
        """
        This gets a username dict containing a sum of size of user's queries in
        three timespans: last month, week, and a day.

        Sizes are given in Bytes or default db's 'data_scanned' unit
        :return: Dict[username] -> Dict['month' | 'week' | 'day'] -> sum(sizes in Bytes)
        """
        # looking only 30 days back since it's the most we are going to present
        all_queries_list = self._query_dao.get_finished_queries_for_days_back(30)

        # prepare a dict of username: dict(daily, weekly, monthly usage)
        summary_dict = defaultdict(lambda: defaultdict(lambda: 0))
        for query in all_queries_list:
            # convert queries str start_timestamp to float for easier comparisons
            query_timestamp_from_date = time.mktime(datetime.strptime(query.start_timestamp, TIMESTAMP_FORMAT).timetuple())

            normalized_name = self.__normalize_username(query.executing_user)

            # add query's size to monthly usage (it's guaranteed to be in the last 30 days)
            summary_dict[normalized_name]['month'] += query.data_scanned

            # check if a query is less than a week old
            if time.time() - query_timestamp_from_date <= 7 * 24 * 60 * 60:
                summary_dict[normalized_name]['week'] += query.data_scanned

                # check if a query is less than a day old
                if time.time() - query_timestamp_from_date <= 1 * 24 * 60 * 60:
                    summary_dict[normalized_name]['day'] += query.data_scanned

        return summary_dict

    # TODO: add an 'all' entry that is displayed on top

    @property
    def summary_user_timespan_size(self) -> DefaultDict[str, DefaultDict[str, str]]:
        """
        This gets a username dict containing a sum of size of user's queries in
        three timespans: last month, week, and a day.

        Sizes are given as a 'size:int unit:str':str in the appropriate unit
        :return: Dict[username] -> Dict['month' | 'week' | 'day'] -> sum(str(size unit))
        """
        summary_dict = self._summary_user_timespan_size_B
        for username in summary_dict.keys():
            for timespan in summary_dict[username].keys():
                summary_dict[username][timespan] = sizeof_fmt(int(summary_dict[username][timespan]))
        return summary_dict



    def __normalize_username(self, raw_name: str) -> str:
        """ Normalize usernames to count both @name and name as the same """
        return raw_name[1:] if raw_name[0] == '@' else raw_name
