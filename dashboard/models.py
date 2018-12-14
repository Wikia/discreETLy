import dataclasses
from dataclasses import dataclass
from datetime import datetime
from typing import Optional

@dataclasses.dataclass
class TaskInstance:
    dag_id: str
    task_id: str
    end_date: datetime
    execution_date: datetime = None
    start_date: datetime = None
    task_state: str = None
    dag_name: Optional[str] = None
    dag_state: Optional[str] = None
    duration: Optional[float] = None

    def is_done(self):
        return self.task_state == "success"


@dataclasses.dataclass
class DagRun:
    dag_id: str
    date: str
    state: str


@dataclass
class EtlWithProgress:
    name: str
    link_title: Optional[str] = None                 # only for streams
    link_href: Optional[str] = None                  # only for streams
    schedule: Optional[str] = None                   # only for DAGs
    state: Optional[str] = None                      # only for DAGs
    tasks_completed: Optional[int] = None            # only for DAGs
    tasks_total: Optional[int] = None                # only for DAGs
    tables_completed: Optional[int] = None           # only for DAGs
    tables_total: Optional[int] = None               # only for DAGs
    duration_seconds: Optional[int] = None           # only for DAGs
    dag_id: Optional[str] = None                     # only for DAGs
    last_execution_date: Optional[datetime] = None   # only for DAGs

@dataclass
class Period:
    id: int
    name: str

@dataclass
class Table:
    id: str
    db: str
    name: str
    glue: bool = False
    streaming: bool = False
    uses: Optional[str] = None
    period: Optional[Period] = None
    dag_id: Optional[str] = None
    task_id: Optional[str] = None

    def get_parent(self):
        if self.uses is None:
            return 'main'
        return self.uses

    def is_rollup(self):
        return self.period is not None

@dataclass
class ExtraEtl:
    name: str
    link_title: str
    link_href: str
    table: str
    active_alerts: Optional[list] = None
