import os
import sys
import pendulum
from datetime import timedelta
import airflow
from airflow import DAG
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from tasks import DBT_0
PROPHECY_RELEASE_TAG = "__PROJECT_ID_PLACEHOLDER__/__PROJECT_RELEASE_VERSION_PLACEHOLDER__"

with DAG(
    dag_id = "uitesting_shared_team_SQL_ChildBigqueryShared_REL_BQ_DoAnything_Job", 
    schedule_interval = "0 0 1 1 *", 
    default_args = {
      "owner": "Prophecy", 
      "email": "abhisheks@prophecy.io,abhisheks@simpledatalabs.com", 
      "email_on_failure": True, 
      "email_on_retry": True, 
      "retry_exponential_backoff": True, 
      "retries": 1, 
      "execution_timeout": timedelta(seconds = 1800), 
      "max_retry_delay": timedelta(minutes = 1.0), 
      "retry_delay": timedelta(minutes = 1.0), 
      "trigger_rule": "all_done", 
      "depends_on_past": True, 
      "ignore_first_depends_on_past": True, 
      "wait_for_downstream": True, 
      "priority_weight": 1, 
      "weight_rule": "downstream", 
      "pool": "testAutomationPool", 
      "pool_slots": 2, 
      "max_active_tis_per_dag": 1, 
      "do_xcom_push": True
    }, 
    start_date = pendulum.datetime(2023, 2, 28, tz = "UTC"), 
    end_date = pendulum.datetime(2080, 2, 28, tz = "UTC"), 
    catchup = True, 
    dagrun_timeout = timedelta(seconds = 1800), 
    max_active_runs = 26, 
    max_active_tasks = 2, 
    tags = ["doanything"]
) as dag:
    DBT_0_op = DBT_0()
