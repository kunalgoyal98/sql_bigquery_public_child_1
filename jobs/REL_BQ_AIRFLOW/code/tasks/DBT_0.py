def DBT_0():
    settings = {}
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    envs = {}
    envs["DBT_FULL_REFRESH"] = "true"

    return BashOperator(
        task_id = "DBT_0",
        bash_command = "set -euxo pipefail; tmpDir=`mktemp -d`; git clone https://github.com/abhisheks-prophecy/test_repo_sql --branch main --single-branch $tmpDir; cd $tmpDir/test/SQL/uitesting/SQL_BigquerySharedBasic; dbt run; dbt test; ",
        env = envs,
        append_env = True,
        **settings
    )
