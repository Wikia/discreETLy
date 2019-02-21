from dataclasses import dataclass
from enum import Enum

TIMESTAMP_FORMAT = '%Y-%m-%d %H:%M:%S'

DATE_FORMAT = '%Y-%m-%d'

class QueryState(Enum):
    QUEUED = 'QUEUED'
    RUNNING = 'RUNNING'
    SUCCEEDED = 'SUCCEEDED'
    FAILED = 'FAILED'
    CANCELLED = 'CANCELLED'


@dataclass
class AthenaQuery:
    start_date: str
    start_timestamp: str
    query_execution_id: str
    query_state: str
    executing_user: str
    data_scanned: int = 0
    query_sql: str = None