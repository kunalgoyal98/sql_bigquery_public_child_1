def DBT_0():
    settings = {}
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    envs = {}
    envs["DBT_PROFILES_DIR"] = "/home/airflow/gcs/data"
    envs["DBT_SEND_ANONYMOUS_USAGE_STATS"] = "false"
    envs["DBT_FAIL_FAST"] = "true"
    envs["DBT_PRINT"] = "false"
    envs["DBT_FULL_REFRESH"] = "true"

    return BashOperator(
        task_id = "DBT_0",
        bash_command = "set -euxo pipefail; tmpDir=`mktemp -d`; git clone https://github.com/abhisheks-prophecy/sql_bigquery_public_child_1 --branch dev --single-branch $tmpDir; cd $tmpDir/; dbt deps --profile run_profile_bigquery; dbt seed --profile run_profile_bigquery --exclude env_uitesting_shared_excluded_model; dbt run --profile run_profile_bigquery --exclude env_uitesting_shared_excluded_model; dbt test --profile run_profile_bigquery --exclude env_uitesting_shared_excluded_model; ",
        env = envs,
        append_env = True,
        **settings
    )
