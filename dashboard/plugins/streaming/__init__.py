from flask import Blueprint
from flask import render_template
from flask import current_app as app
from dashboard.utils import get_yaml_file_content

base_path = '/streaming'
tab_name = 'Streaming'
plugin = Blueprint('streaming', __name__, template_folder='templates')

@plugin.route('/')
def index():
    streams_definition = get_yaml_file_content('config/streaming.yaml')
    if not streams_definition:
        return render_template('no_config.html', filename='streaming.yaml')

    alerts = [table['id'] for table in app.table_data_provider.list() if table['active_alerts']]
    streams = [dict(active_alerts = stream['table'] in alerts, **stream) for stream in streams_definition]
                     
    return render_template('streaming/index.html', streams=streams)