from dashboard.service.prometheus_service import PrometheusService

ALERT_PREFIX = 'emr_stats_'


class PrometheusData:
    def __init__(self, config, logger):
        self.prometheus = PrometheusService(config, logger)

    def alerts(self):
        response = self.prometheus.query(f'ALERTS{{alertname=~"{ALERT_PREFIX}.*"}}')
        alerts = [result['metric']['alertname'] for result in response['data']['result']]
        return [{'db_table': alert.rsplit('__', 1)[0][len(ALERT_PREFIX):], 'name': alert} for alert in alerts]

    def alert_link(self, alert_name):
        return self.prometheus.alert_link(alert_name)
