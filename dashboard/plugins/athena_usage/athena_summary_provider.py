from collections import defaultdict
from typing import DefaultDict, Tuple

from dashboard.utils import sizeof_fmt
from .query_dao import *


class AthenaSummaryProvider:
    """
    This class communicates with QueryDao in order to prepare summaries of athena usage
    """

    ALL_USERS_KEY = 'All users'

    def __init__(self, config: dict, dynamodb, logger):
        self.logger = logger
        self._query_dao = QueryDao(config, dynamodb, self.logger)

    @property
    def _summary_user_timespan_size_B(self) -> Tuple[DefaultDict[str, DefaultDict[str, int]], DefaultDict[str, DefaultDict[str, int]]]:
        """
        This gets a username dict containing a sum of size of user's queries in
        three timespans: last month, week, and a day,
        and the same-structured dict containing special summaries,
        e.g. sums for all users under ALL_USERS_KEY

        Sizes are given in Bytes or default db's 'data_scanned' unit
        :return: Tuple[Dict[username] -> Dict['month' | 'week' | 'day'] -> sum(sizes in Bytes),
                    Dict[special_summary] -> Dict['month' | 'week' | 'day'] -> sum(sizes in Bytes)]
        """
        # looking only 30 days back since it's the most we are going to present
        all_queries_set = self._query_dao.queries_last_30_days

        # prepare a dict of username: dict(daily, weekly, monthly usage)
        summary_user_dict = defaultdict(lambda: defaultdict(lambda: 0))

        # prepare a dict of special_summary: dict(daily, weekly, monthly usage)
        # e.g. special_summaries use: sum for all users, grouping by role, by team..
        special_summaries_dict = defaultdict(lambda: defaultdict(lambda: 0))

        for query in all_queries_set:
            # convert queries str start_timestamp to float for easier comparisons
            query_timestamp_from_date = time.mktime(datetime.strptime(query.start_timestamp, TIMESTAMP_FORMAT).timetuple())

            normalized_name = self._normalize_username(query.executing_user)

            # check if a query is less than a month old
            if time.time() - query_timestamp_from_date <= Timespan.MONTH.value:
                summary_user_dict[normalized_name]['month'] += query.data_scanned
                special_summaries_dict[self.ALL_USERS_KEY]['month'] += query.data_scanned

                # check if a query is less than a week old.
                if time.time() - query_timestamp_from_date <= Timespan.WEEK.value:
                    summary_user_dict[normalized_name]['week'] += query.data_scanned
                    special_summaries_dict[self.ALL_USERS_KEY]['week'] += query.data_scanned

                    # check if a query is less than a day old
                    if time.time() - query_timestamp_from_date <= Timespan.DAY.value:
                        summary_user_dict[normalized_name]['day'] += query.data_scanned
                        special_summaries_dict[self.ALL_USERS_KEY]['day'] += query.data_scanned

        return summary_user_dict, special_summaries_dict

    @property
    def summary_user_timespan_size(self) -> Tuple[DefaultDict[str, DefaultDict[str, str]], DefaultDict[str, DefaultDict[str, str]]]:
        """
        This gets a username dict containing a sum of size of user's queries in
        three timespans: last month, week, and a day,
        and the same-structured dict containing special summaries,
        e.g. sums for all users under ALL_USERS_KEY

        Sizes are given as a 'size:int unit:str':str in the appropriate unit
        :return: Tuple[Dict[username] -> Dict['month' | 'week' | 'day'] -> sum(str(size unit)),
                    Dict[special_summary] -> Dict['month' | 'week' | 'day'] -> sum(str(size unit))]
        """

        return tuple(map(self._convert_summary_dict_bytes_to_smart_unit, self._summary_user_timespan_size_B))

    def _convert_summary_dict_bytes_to_smart_unit(self, summary_dict: DefaultDict[str, DefaultDict[str, int]]) -> DefaultDict[str, DefaultDict[str, str]]:
        """
        This method converts
        Dict[name] -> Dict['month' | 'week' | 'day'] -> sum(sizes in Bytes)
        to use smart size unit
        :return: Dict[username] -> Dict['month' | 'week' | 'day'] -> sum(str(size unit))
        """
        for name in summary_dict.keys():
            for timespan in summary_dict[name].keys():
                summary_dict[name][timespan] = sizeof_fmt(int(summary_dict[name][timespan]))
        return summary_dict

    def _normalize_username(self, raw_name: str) -> str:
        """ Normalize usernames to count both @name and name as the same """
        return raw_name[1:] if raw_name[0] == '@' else raw_name
