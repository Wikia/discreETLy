from flask import Blueprint
from flask import render_template, jsonify
from flask import current_app as app
from dashboard.utils import get_yaml_file_content

base_path = '/streaming'
tab_name = 'Streaming'
plugin = Blueprint('streaming', __name__, template_folder='templates')


def init(app):
    lag_provider_class = app.config.get('STREAMING_LAG_PROVIDER', 'InfluxBasedLagProvider')
    class_instance = globals()[lag_provider_class]
    app.streaming_lag_data_provider = class_instance(app)

@plugin.route('/')
def index():
    streams_definition = get_yaml_file_content('config/streaming.yaml')
    if not streams_definition:
        return render_template('no_config.html', filename='streaming.yaml')

    alerts = [table['id'] for table in app.table_data_provider.list() if table['active_alerts']]
    streams = [dict(active_alerts = stream['table'] in alerts, **stream) for stream in streams_definition]
                     
    return render_template('streaming/index.html', streams=streams)


@plugin.route('/api/lag/<string:stream>/<string:table>/<string:period>')
def api_lag_value(stream, table, period):
    return jsonify(app.streaming_lag_data_provider.get_lag(stream, table, period))

class LagProvider:
    def __init__(self, app):
        self.app = app
        self.interval = app.config.get('STREAMING_BATCH_INTERVAL', '15m')

    def get_lag(self, stream, table, period):
        raise NotImplementedException()

class InfluxBasedLagProvider(LagProvider):
    def get_lag(self, stream, table, period):
        return list(self.app.influx_client.query('SELECT mean(extra_lag)/1000 AS lag FROM emr_stats_{} WHERE time >= now() - {} GROUP BY time({})'.format(
            table.replace('.', '_'), period, self.interval)).get_points())
    
