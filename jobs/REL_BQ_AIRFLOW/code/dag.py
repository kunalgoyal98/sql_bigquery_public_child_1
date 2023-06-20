import os
import sys
import pendulum
from datetime import timedelta
import airflow
from airflow import DAG
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from uitesting_shared_team_sql_bigquerysharedbasic_rel_bq_airflow.tasks import DBT_0, DBT_0_2, Script_1, Script_1_1
PROPHECY_RELEASE_TAG = "__PROJECT_ID_PLACEHOLDER__/__PROJECT_RELEASE_VERSION_PLACEHOLDER__"

with DAG(
    dag_id = "uitesting_shared_team_SQL_BigquerySharedBasic_REL_BQ_AIRFLOW", 
    schedule_interval = "0 0 10 * *", 
    default_args = {
      "owner": "Prophecy", 
      "retries": 1, 
      "retry_delay": timedelta(minutes = 2.0), 
      "ignore_first_depends_on_past": True, 
      "do_xcom_push": True
    }, 
    start_date = pendulum.datetime(2023, 2, 22, tz = "America/Adak"), 
    end_date = pendulum.datetime(2080, 2, 22, tz = "America/Adak"), 
    catchup = True, 
    tags = []
) as dag:
    DBT_0_op = DBT_0()
    Script_1_1_op = Script_1_1()
    Script_1_op = Script_1()
    DBT_0_2_op = DBT_0_2()
    DBT_0_op >> Script_1_op
    Script_1_op >> [DBT_0_2_op, Script_1_1_op]
