import time
from collections import defaultdict

from .query_dao import *


class AthenaSummaryProvider:

    def __init__(self, config: dict, dynamodb):
        self.query_dao = QueryDao(config, dynamodb)

    def get_summaries(self):
        # looking only 30 days back since it's the most we are going to present
        all_queries_list = self.query_dao.get_finished_queries_for_days_back(30)

        # prepare a dict of username: dict(daily, weekly, monthly usage)
        summary_dict = defaultdict(lambda: defaultdict(lambda: 0))
        for query in all_queries_list:
            # convert queries str start_timestamp to float for easier comparisons
            query_timestamp_from_date = time.mktime(datetime.strptime(query.start_timestamp, TIMESTAMP_FORMAT).timetuple())

            # add query's size to monthly usage (it's guaranteed to be in the last 30 days)
            summary_dict[query.executing_user]['monthly']+=query.data_scanned

            # check if a query is less than a week old
            if time.time() - query_timestamp_from_date <= 7 * 24 * 60 * 60:
                summary_dict[query.executing_user]['weekly'] += query.data_scanned

                # check if a query is less than a day old
                if time.time() - query_timestamp_from_date <= 1 * 24 * 60 * 60:
                    summary_dict[query.executing_user]['daily'] += query.data_scanned

        return summary_dict


            
            
            
            
