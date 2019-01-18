import json
from dataclasses import dataclass
from collections import defaultdict
from dashboard.utils.vis import tree_diagram


class ReportsDataProvider:

    def __init__(self, tables, reports):

        self.__tables = tables
        self.__reports = reports
        self.COLORS = {
            "success": 1,
            "pending": 2,
            "failure": 3
        }

    @property
    def reports(self):

        statuses = {table['id']: table['state'] for table in self.__tables}

        output_reports = []

        for report in self.__reports:

            id_mapping = {table['id']: index+2
                        for index, table in enumerate(report['definition']['tables'])}

            tables = [{'id': id_mapping[table['id']],
                    'name': table['name'],
                    'parent': id_mapping.get(table.get('parent', None)),
                    'success': self.COLORS.get(statuses[table['id']], "black")
                    }
                    for table in report['definition']['tables']]

            parent_updated = [{**table, **{'parent': 1}}
                    if table['parent'] is None else table
                    for table in tables]

            output_reports.append({
                'id': report['id'],
                'name': report['definition']['name'],
                'data': json.dumps(
                        tree_diagram([{'id': 1, 'tid': None, 'name': report['definition']['name'], 'success': 0}] + parent_updated, provide_links=True)
                    )
                })

        return output_reports
