from flask import Blueprint
from flask import render_template
from flask import current_app as app
from dashboard.utils import get_yaml_file_content
from .reports_data import ReportsDataProvider

base_path = '/reports'
tab_name = 'Reports'
plugin = Blueprint('reports', __name__, template_folder='templates')

REPORTS_PATH = 'config/reports.yaml'

@plugin.route('/')
def index():
    reports = get_yaml_file_content(REPORTS_PATH)
    if not reports:
        return render_template('no_config.html', filename='reports.yaml')

    report_data_provider = ReportsDataProvider(app.table_data_provider.list(), reports['reports'])
    return render_template('reports/index.html', reports=report_data_provider.reports)