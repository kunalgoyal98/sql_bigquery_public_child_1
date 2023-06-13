import os
import sys
import pendulum
from datetime import timedelta
import airflow
from airflow import DAG
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from tasks import DBT_0, DBT_0_2
PROPHECY_RELEASE_TAG = "__PROJECT_ID_PLACEHOLDER__/__PROJECT_RELEASE_VERSION_PLACEHOLDER__"

with DAG(
    dag_id = "NPP4q9MIzskxZeICpwPZAw_", 
    schedule_interval = "0 0 13 * *", 
    default_args = {
      "owner": "Prophecy", 
      "retry_exponential_backoff": True, 
      "retries": 1, 
      "execution_timeout": timedelta(seconds = 900), 
      "max_retry_delay": timedelta(minutes = 1.0), 
      "retry_delay": timedelta(minutes = 1.0), 
      "trigger_rule": "all_success", 
      "depends_on_past": False, 
      "ignore_first_depends_on_past": True, 
      "wait_for_downstream": True, 
      "priority_weight": 2, 
      "weight_rule": "downstream", 
      "pool": "tB-MN8Ps", 
      "do_xcom_push": True
    }, 
    start_date = pendulum.datetime(2023, 2, 28, tz = "UTC"), 
    end_date = pendulum.datetime(2023, 7, 3, tz = "UTC"), 
    catchup = True, 
    dagrun_timeout = timedelta(seconds = 3600), 
    max_active_runs = 25, 
    max_active_tasks = 2, 
    tags = ["bigquery_shared"]
) as dag:
    DBT_0_op = DBT_0()
    DBT_0_2_op = DBT_0_2()
    DBT_0_op >> DBT_0_2_op
