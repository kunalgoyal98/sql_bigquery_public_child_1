def Script_1_1():
    settings = {}
    from datetime import timedelta
    from airflow.operators.bash import BashOperator

    return BashOperator(task_id = "Script_1_1", bash_command = "ls -ltr", **settings)
