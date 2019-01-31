from influxdb import InfluxDBClient
from dashboard.utils import Timer
from influxdb.exceptions import InfluxDBClientError, InfluxDBServerError
import inspect
import backoff

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
        with Timer(self.logger, f"Influx query {query}"):
            return self.cnx.query(query)
