import requests
import urllib.parse


class PrometheusService:

    def __init__(self, config, logger):
        self.hostname = config['PROMETHEUS_HOST']
        self.logger = logger

    def query(self, query):
        response = requests.get(f'http://{self.hostname}/api/v1/query', params=dict(query=query))
        response.raise_for_status()
        response_json = response.json()
        self.logger.info(f"Querying prometheus was succesful - url {response.url}, response {response_json}")
        return response_json

    def alert_link(self, alert_name):
        query_params = urllib.parse.urlencode({'g0.expr': 'ALERTS{{alertname="{}"}}'.format(alert_name), 'g0.tab':'0'})
        return f'http://{self.hostname}/graph?{query_params}'
