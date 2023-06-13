def DBT_0():
    settings = {}
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    envs = {}
    envs["DBT_SEND_ANONYMOUS_USAGE_STATS"] = "false"
    envs["DBT_FAIL_FAST"] = "true"
    envs["DBT_PRINT"] = "false"
    envs["DBT_FULL_REFRESH"] = "true"
    envs["DBT_PROFILE_SECRET"] = "NLLzyDWWL-0ro4aLPT44-"
    envs["GIT_TOKEN_SECRET"] = ""
    envs["GIT_ENTITY"] = "branch"
    envs["GIT_ENTITY_VALUE"] = "main"
    envs["GIT_SSH_URL"] = "https://github.com/abhisheks-prophecy/sql_bigquery_public_child_1"
    envs["GIT_SUB_PATH"] = ""

    return BashOperator(
        task_id = "DBT_0",
        bash_command = f"$PROPHECY_HOME/run_dbt.sh \"dbt deps --profile run_profile; dbt seed --profile run_profile --exclude env_uitesting_shared_excluded_model; dbt run --profile run_profile --exclude env_uitesting_shared_excluded_model; dbt test --profile run_profile --exclude env_uitesting_shared_excluded_model; \"",
        env = envs,
        append_env = True,
        **settings
    )
