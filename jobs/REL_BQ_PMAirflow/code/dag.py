import os
import sys
import pendulum
from datetime import timedelta
import airflow
from airflow import DAG
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from uitesting_shared_team_sql_childbigqueryshared_rel_bq_pmairflow.tasks import DBT_0, DBT_0_2
PROPHECY_RELEASE_TAG = "__PROJECT_ID_PLACEHOLDER__/__PROJECT_RELEASE_VERSION_PLACEHOLDER__"

with DAG(
    dag_id = "uitesting_shared_team_SQL_ChildBigqueryShared_REL_BQ_PMAirflow", 
    schedule_interval = "0 0 25 * *", 
    default_args = {"owner" : "Prophecy", "ignore_first_depends_on_past" : True, "do_xcom_push" : True}, 
    start_date = pendulum.today('UTC'), 
    catchup = True
) as dag:
    DBT_0_op = DBT_0()
    DBT_0_2_op = DBT_0_2()
    DBT_0_op >> DBT_0_2_op
