import datetime
from dashboard.service.influxdb_service import InfluxDbService

class InfluxDBData:
    def __init__(self, config, logger):
        self.influx = InfluxDbService(config, logger)
        self.logger = logger

    def get_influx_stats(self, table, days):
        query = self.__get_table_sql(table, days)
        return list(self.influx.query(query).get_points())

    def __get_table_sql(self, table, days):
        period_filter = f" AND period_id = '{table.period.id}' " if table.period else ""
        query = f'SELECT * FROM "emr_stats_{table.db}_{table.name}" ' \
                f'WHERE time >= now() - {days}d {period_filter}' \
                f'ORDER BY time ASC'
        return query

    def get_influx_data(self, days, period_mapping):
        influx_stats = {}
        query = 'SELECT * FROM /emr_stats_.*/ ' \
                'WHERE time >= now() - {days}d'.format(days=days)
        result_set = self.influx.query(query)
        measurements = result_set.raw['series']
        mapper = lambda row:  (datetime.datetime.strptime(row['time'], '%Y-%m-%dT%H:%M:%SZ'), row['records'])

        for measurement_name in [x['name'] for x in measurements]:
            measurement_data = list(result_set.get_points(measurement=measurement_name))
            base_table_id = measurement_name[10:]
            if measurement_data:
                if measurement_data[0].get('period_id') is None:
                    influx_stats[base_table_id] = [mapper(row) for row in measurement_data]
                else:
                    for row in measurement_data:
                        period_id = row['period_id']
                        table_id = f'{base_table_id}_{period_mapping[int(period_id)]}'
                        influx_stats.setdefault(table_id, []).append(mapper(row))
        return influx_stats
