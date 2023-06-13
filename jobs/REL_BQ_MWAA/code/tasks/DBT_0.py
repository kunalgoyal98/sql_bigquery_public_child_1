def DBT_0():
    settings = {}
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    envs = {}
    envs["DBT_PROFILES_DIR"] = "/usr/local/airflow/dags"
    envs["DBT_FULL_REFRESH"] = "true"

    return BashOperator(
        task_id = "DBT_0",
        bash_command = "set -euxo pipefail; tmpDir=`mktemp -d`; git clone https://github.com/abhisheks-prophecy/sql_bigquery_public_child_1 --branch dev --single-branch $tmpDir; cd $tmpDir/; dbt run --profile run_profile_bigquery; dbt test --profile run_profile_bigquery; ",
        env = envs,
        append_env = True,
        **settings
    )
