import re


def clean_dag_id(dag_id):
    return re.sub('_v?[0-9]+.[0-9]+$', '', dag_id)


def handle_resource(resource, value = None):
    def check_optional(func):
        def func_wrapper(self, *args, **kwargs):
            return func(self, *args, **kwargs) if self.__dict__.get(resource) else value
        return func_wrapper
    return check_optional

def simple_state(state):
    if state in ('success', 'failed'):
        return state
    else: # simplifies statuses like "queued", "up_for_retry", etc
        return 'running'
