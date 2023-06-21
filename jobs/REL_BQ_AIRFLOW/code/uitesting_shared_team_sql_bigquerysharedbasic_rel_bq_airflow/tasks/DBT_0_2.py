def DBT_0_2():
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    envs = {}
    envs["DBT_WRITE_JSON"] = "false"
    envs["DBT_PRINTER_WIDTH"] = "100"
    envs["DBT_VERSION_CHECK"] = "false"
    envs["DBT_PARTIAL_PARSE"] = "true"
    envs["DBT_USE_EXPERIMENTAL_PARSER"] = "true"
    envs["DBT_PROFILES_DIR"] = "/home/airflow/gcs/data"
    envs["DBT_SEND_ANONYMOUS_USAGE_STATS"] = "false"
    envs["DBT_FAIL_FAST"] = "true"
    envs["DBT_QUIET"] = "true"
    envs["DBT_PRINT"] = "false"
    envs["DBT_CACHE_SELECTED_ONLY"] = "false"
    envs["DBT_TARGET_PATH"] = "compiled"
    envs["DBT_LOG_PATH"] = "logs.txt"
    envs["DBT_DEFER"] = "true"
    envs["DBT_FAVOR_STATE"] = "true"
    envs["DBT_FULL_REFRESH"] = "true"
    envs["DBT_INDIRECT_SELECTION"] = "Cautious"

    return BashOperator(
        task_id = "DBT_0_2",
        bash_command = "set -euxo pipefail; tmpDir=`mktemp -d`; git clone https://github.com/abhisheks-prophecy/sql_bigquery_public_child_1 --branch dev --single-branch $tmpDir; cd $tmpDir/; dbt -r output.profile deps --profile run_profile_bigquery -t dev --vars '{test_var: hello}'; dbt -r output.profile seed --profile run_profile_bigquery -t dev --vars '{test_var: hello}' --threads=2 --exclude env_uitesting_shared_excluded_model; dbt -r output.profile run --profile run_profile_bigquery -t dev --vars '{test_var: hello}' --threads=2 --exclude env_uitesting_shared_excluded_model; ",
        env = envs,
        append_env = True,
        email = "abhisheks@prophecy.io", 
        email_on_failure = True, 
        email_on_retry = True, 
        retry_exponential_backoff = True, 
        retries = 1, 
        execution_timeout = timedelta(seconds = 1800), 
        max_retry_delay = timedelta(minutes = 1.0), 
        retry_delay = timedelta(minutes = 1.0), 
        trigger_rule = "always", 
        depends_on_past = True, 
        ignore_first_depends_on_past = True, 
        wait_for_downstream = True, 
        priority_weight = 1, 
        weight_rule = "absolute", 
        queue = "", 
        pool = "testAutomationPool", 
        pool_slots = 2, 
        max_active_tis_per_dag = 2
    )
