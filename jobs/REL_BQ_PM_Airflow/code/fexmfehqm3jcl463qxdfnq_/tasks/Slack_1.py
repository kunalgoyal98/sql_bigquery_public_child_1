def Slack_1():
    settings = {}
    from airflow.providers.slack.operators.slack import SlackAPIPostOperator

    return SlackAPIPostOperator(
        task_id = "Slack_1",
        text = "Test Slack BQ PM",
        channel = "abhyslackpub",
        slack_conn_id = "7k_Cby3g6vOgeKrdy93nb",
        **settings
    )
