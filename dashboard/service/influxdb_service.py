from influxdb import InfluxDBClient
from timeit import default_timer as timer
import inspect
from influxdb.exceptions import InfluxDBClientError, InfluxDBServerError
import backoff

class InfluxTimer:

    def __init__(self, logger):
        self.logger = logger
        self.query = next(call.function for call in inspect.stack()[2:] if call.function != 'retry') # first call that is not retry

    def __enter__(self):
        self.start = timer()
        self.logger.debug(f"Influx query {self.query} started")
        return self

    def __exit__(self, *args):
        self.end = timer()
        self.interval = self.end - self.start
        self.logger.info(f"Influx query for {self.query} took {self.interval:.2f} sec")


class InfluxDbService:

    def __init__(self, config, logger):
        self.cnx = self.create_connection(config)
        self.logger = logger

    def create_connection(self, config):
        return InfluxDBClient(
            config['INFLUXDB_HOST'],
            8086,
            config['INFLUXDB_USERNAME'],
            config['INFLUXDB_PASSWORD'],
            config['INFLUXDB_DATABASE'])

    @backoff.on_exception(backoff.expo, (InfluxDBServerError, InfluxDBClientError), max_tries=4)
    def query(self, query):
        with InfluxTimer(self.logger):
            return self.cnx.query(query)
