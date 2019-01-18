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

    tables = app.table_data_provider.list()
    streams = [dict(active_alerts = next(table['active_alerts'] for table in tables if table['id'] == stream['table']), **stream)
                     for stream in streams_definition]
                     
    return render_template('streaming/index.html', streams=streams)