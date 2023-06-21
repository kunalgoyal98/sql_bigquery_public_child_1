{{
  config({    
    "materialized": "view",
    "pre_hook": [],
    "post_hook": []
  })
}}

{% set v_complex_dict = { "problems" : [{ "Diabetes" : [{ "medications" : [{ "medicationsClasses" : [{ "className" : [{ "associatedDrug" : [{ "name" : "asprin", "dose" : "", "strength" : "500 mg" }], "associatedDrug#2" : [{ "name" : "somethingElse", "dose" : "", "strength" : "500 mg" }] }], "className2" : [{ "associatedDrug" : [{ "name" : "asprin", "dose" : "", "strength" : "500 mg" }], "associatedDrug#2" : [{ "name" : "somethingElse", "dose" : "", "strength" : "500 mg" }] }] }] }], "labs" : [{ "missing_field" : "missing_value" }] }], "Asthma" : [{  }] }] } %}
{% set v_float = 10.12 %}
{% set v_bool = True %}
{% set v_expression_config = 'concat(c_string, c_struct.age, c_struct.name)' %}
{% set v_array = [1, 2, 3, 4] %}
{% set v_dict = { 'a' : 10, 'b' : 20 } %}
{% set v_int = 22 %}







WITH env_uitesting_main_model_bigquery_1 AS (

  SELECT * 
  
  FROM {{ ref('env_uitesting_main_model_bigquery_1')}}

),

SQLStatement_1 AS (

  SELECT * 
  
  FROM env_uitesting_main_model_bigquery_1
  
  WHERE c_base_dependency_macro IS NOT NULL or c_boolean_macro IN (true, false, NULL) or c_numeric_1 > -100 or c_int64 BETWEEN 100 and 10000000

),

Limit_5 AS (

  SELECT * 
  
  FROM SQLStatement_1 AS in0
  
  LIMIT 20

),

Aggregate_1 AS (

  SELECT 
    any_value(c_string) AS c_string,
    any_value(c_float64) AS c_float64,
    any_value(c_bytes) AS c_bytes,
    any_value(c_numeric_1) AS c_numeric_1,
    any_value(c_date) AS c_date,
    any_value(c_time) AS c_time,
    any_value(c_timestamp) AS c_timestamp,
    any_value(c_datetime) AS c_datetime,
    any_value(c_geography) AS c_geography,
    APPROX_COUNT_DISTINCT(c_int64) + sum(c_int64) + max(c_int64) + min(c_int64) + COUNTIF(
      c_int64 > 25) + AVG(c_int64) + BIT_AND(c_int64) - BIT_OR(c_int64) + BIT_XOR(c_int64) + COUNT(DISTINCT c_bignumeric) AS c_int_aggregate,
    ARRAY_CONCAT_AGG(c_array_int64) AS c_array_concat_agg,
    LOGICAL_AND(
      c_int64 < 3) or LOGICAL_OR(
      c_int64 < 3) AS c_bool_aggregate,
    APPROX_QUANTILES(c_int64, 2) AS c_approx_qauntiles,
    APPROX_TOP_COUNT(c_int64, 2) AS c_approx_top_count,
    APPROX_TOP_SUM(c_int64, 2, 2) AS c_approx_top_sum
  
  FROM Limit_5 AS in0
  
  GROUP BY c_bool
  
  HAVING c_float64 > -10

),

raw_orders AS (

  SELECT * 
  
  FROM {{ ref('raw_orders')}}

),

Macro_1 AS (

  {{ SQL_BigQueryParentProjectMain.qa_all_not_null(model = 'raw_orders', column_name = 'user_id') }}

),

raw_payments AS (

  SELECT * 
  
  FROM {{ ref('raw_payments')}}

),

SQLStatement_2 AS (

  SELECT 
    t1.id,
    t1.payment_method
  
  FROM raw_payments AS t1, raw_orders AS t2
  
  WHERE t1.order_id = t2.id or t2.status IS NOT NULL or t1.payment_method IS NOT NULL

),

Limit_5_1 AS (

  SELECT * 
  
  FROM SQLStatement_2 AS in0
  
  LIMIT 25

),

Join_2 AS (

  SELECT 
    in0.c_string AS c_string,
    in0.c_float64 AS c_float64,
    in0.c_bytes AS c_bytes,
    in0.c_numeric_1 AS c_numeric_1,
    in0.c_date AS c_date,
    in0.c_time AS c_time,
    in0.c_timestamp AS c_timestamp,
    in0.c_datetime AS c_datetime,
    in0.c_geography AS c_geography
  
  FROM Aggregate_1 AS in0
  INNER JOIN Macro_1 AS in1
     ON in0.c_string != in1.status
  RIGHT JOIN Limit_5_1 AS in2
     ON in1.status != in2.payment_method

),

Limit_2 AS (

  SELECT * 
  
  FROM Join_2 AS in0
  
  LIMIT 10

),

INCOME_BAND AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_suggestion_database', 'INCOME_BAND') }}

),

Reformat_5 AS (

  SELECT * 
  
  FROM INCOME_BAND AS in0

),

tpcds_1_env_uitesting_shared AS (

  SELECT * 
  
  FROM {{ ref('tpcds_1_env_uitesting_shared')}}

),

SQLStatement_1_1 AS (

  SELECT 
    RAND() AS c_float,
    GENERATE_UUID() AS c_string,
    GENERATE_ARRAY(1, 4, 10) AS c_array,
    GENERATE_DATE_ARRAY('2016-10-05', '2016-10-08') AS c_date_array
  
  FROM `prophecy-qa.qa_test_dataset.all_type_table`
  
  WHERE c_int64 != (
    SELECT count(*)
    
    FROM tpcds_1_env_uitesting_shared
   )
  
  LIMIT 100

),

Limit_1 AS (

  SELECT * 
  
  FROM SQLStatement_1_1 AS in0
  
  LIMIT 10

),

OrderBy_1 AS (

  SELECT * 
  
  FROM Limit_1 AS in0
  
  ORDER BY concat(c_string, c_float) ASC NULLS FIRST, c_string DESC

),

env_uitesting_shared_mid_model_1 AS (

  SELECT * 
  
  FROM {{ ref('env_uitesting_shared_mid_model_1')}}

),

Limit_4 AS (

  SELECT * 
  
  FROM env_uitesting_shared_mid_model_1 AS in0
  
  LIMIT 10

),

env_uitesting_shared_child_model_1 AS (

  SELECT * 
  
  FROM {{ ref('env_uitesting_shared_child_model_1')}}

),

env_uitesting_shared_parent_model_1 AS (

  SELECT * 
  
  FROM {{ ref('env_uitesting_shared_parent_model_1')}}

),

Limit_3 AS (

  SELECT * 
  
  FROM env_uitesting_shared_parent_model_1 AS in0
  
  LIMIT 10

),

Join_1 AS (

  SELECT 
    env_uitesting_shared_parent_model_1.c_string AS c_string,
    env_uitesting_shared_parent_model_1.c_geography AS c_geography,
    env_uitesting_shared_parent_model_1.c_numeric_1 AS c_numeric_1,
    env_uitesting_shared_mid_model_1.p_date AS p_date,
    env_uitesting_shared_parent_model_1.c_timestamp AS c_timestamp,
    env_uitesting_shared_parent_model_1.c_bool AS c_bool,
    env_uitesting_shared_parent_model_1.c_json AS c_json,
    env_uitesting_shared_parent_model_1.c_interval AS c_interval,
    env_uitesting_shared_parent_model_1.c_int64 AS c_int64,
    env_uitesting_shared_parent_model_1.c_float64 AS c_float64,
    env_uitesting_shared_parent_model_1.c_numeric_2 AS c_numeric_2,
    env_uitesting_shared_parent_model_1.c_date AS c_date,
    env_uitesting_shared_parent_model_1.c_datetime AS c_datetime,
    env_uitesting_shared_parent_model_1.c_bytes AS c_bytes,
    env_uitesting_shared_parent_model_1.c_struct AS c_struct,
    env_uitesting_shared_parent_model_1.c_array_int64 AS c_array_int64,
    env_uitesting_shared_parent_model_1.c_time AS c_time,
    env_uitesting_shared_parent_model_1.c_bignumeric AS c_bignumeric,
    env_uitesting_shared_child_model_1.c_struct.name AS c_struct_name,
    env_uitesting_shared_child_model_1.c_struct.age AS c_struct_age
  
  FROM Limit_3 AS env_uitesting_shared_parent_model_1
  LEFT JOIN env_uitesting_shared_child_model_1
     ON env_uitesting_shared_parent_model_1.c_bool = env_uitesting_shared_child_model_1.c_bool
  RIGHT JOIN Limit_4 AS env_uitesting_shared_mid_model_1
     ON env_uitesting_shared_parent_model_1.c_int64 = env_uitesting_shared_mid_model_1.c_int64 and env_uitesting_shared_parent_model_1.c_bignumeric = env_uitesting_shared_mid_model_1.c_bignumeric and env_uitesting_shared_parent_model_1.c_bool = env_uitesting_shared_mid_model_1.c_bool

),

AllStunningOne AS (

  SELECT 
    {% for c_i in range(0, 5) %}
      concat(c_string, {{c_i}}) AS cfor_col_{{c_i}},
    {% endfor %}
    
    {% if v_int > 0 or                             var('v_project_dict')['a'] > 10 or     var('v_project_int') > 10 %}
      concat(c_string, c_bool) AS c_if,
    {% elif v_dict['a'] > 10 or     var('v_project_dict')['b'] == 'hello' %}
      concat(c_string, c_int64) AS c_if,
    {% else %}
      concat(c_string, c_numeric_1) AS c_if,
    {% endif %}
    (10 < 20) or (20 < 30) or (20 <= 30) or (20 >= 30) or (10 <> 10) or (20 = 10) or (20 BETWEEN 10 and 21) or ('hello' LIKE '%h\\%\\_\\/%') or (10 IN (20, 10, 30)) or ((20 >= 30) IS TRUE) or ((20 >= 30) IS NOT TRUE) or ((20 >= 30) IS FALSE) or ((20 >= 30) IS NOT FALSE) or ((10 > 20) IS UNKNOWN) or ((10 > 20) IS NOT UNKNOWN) or ((10 > 20) IS NOT NULL) or ((10 > 20) IS NULL) or (COLLATE('Foo', 'und:ci') LIKE COLLATE('%foo%', 'und:ci')) or ('MASSE' LIKE 'Ma?e') or ('\u3042' LIKE '%\u30A2%') or (CASE
      WHEN c_int64 > 10
        THEN True
      WHEN c_int64 < 10
        THEN False
      ELSE True
    END) or (COALESCE(NULL, 'B', 'C') = 'B') or (IF(
      c_int64 < c_float64, 
      'true', 
      'false') = 'true') or (IFNULL(NULL, 0) = 0) or (NULLIF(10, 0) = 10) or ((ANY_VALUE(c_int64) OVER (ORDER BY LENGTH(c_string) ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) = 0) or (CAST('1' AS string) = '1') or (CAST('1' AS string) = '1') or (CAST('1' AS BIGNUMERIC) = 1) or (CAST('TRUE' AS BOOL) = TRUE) or (CAST(CAST('hi' AS BYTES) AS STRING) = 'hi') or (CAST('2021-04-20' AS DATE) = DATE'2020-09-22') or (CAST('2021-04-20 00:00:00' AS TIMESTAMP) = TIMESTAMP'2020-09-22 00:00:00') or (CAST('23.45' AS FLOAT64) = 23.45) or (CAST('-23' AS INT64) = -23) or (CAST('-0x123' AS INT64) = -291) or (CAST('123' AS NUMERIC) = 123) or (CAST(b'\x48\x65\x6c\x6c\x6f' AS STRING FORMAT 'ASCII') = 'Hello') or (CAST(CURRENT_DATE() AS STRING) = '2020-12-12') or (CAST(CURRENT_DATE() AS STRING FORMAT 'DAY') = 'MONDAY') or (CAST(TIMESTAMP'2008-12-25 00:00:00+00:00' AS STRING FORMAT 'YYYY-MM-DD HH24:MI:SS TZH:TZM') = '2008-12-25 00:00:00+00:00') or (CAST(TIMESTAMP'2008-12-25 00:00:00+00:00' AS STRING FORMAT 'YYYY-MM-DD HH24:MI:SS TZH:TZM' AT TIME ZONE 'Asia/Kolkata') = '2008-12-25 00:00:00+00:00') or ((CAST('18-12-03' AS DATE FORMAT 'YY-MM-DD') = CAST('18-12-03' AS DATE FORMAT 'YY-MM-DD'))) or (CAST('DEC 03, 2018' AS DATE FORMAT 'MON DD, YYYY') = CAST('DEC 03, 2018' AS DATE FORMAT 'MON DD, YYYY')) or (CAST('15:30' AS TIME FORMAT 'HH24:MI') = CAST('15:30' AS TIME FORMAT 'HH24:MI')) or (CAST('03:30 P.M.' AS TIME FORMAT 'HH:MI P.M.') = CAST('03:30 P.M.' AS TIME FORMAT 'HH:MI P.M.')) or (CAST('03:30 P.M.' AS TIME FORMAT 'HH:MI A.M.') = CAST('03:30 P.M.' AS TIME FORMAT 'HH:MI A.M.')) or (CAST(-12345.678 AS STRING FORMAT '$999,999.999') = '-$12,345.678') or (CAST(-123456 AS STRING FORMAT '9.999EEEE') = '-1.235E+05') or (PARSE_BIGNUMERIC("  -  123.45 ") = 123.45) or (PARSE_BIGNUMERIC("  1,2,,3,.45 + ") = 123.25) or (PARSE_NUMERIC("12.34e-1-") = -1.234) or (SAFE_CAST("apple" AS INT64) IS NULL) or (ARRAY_TO_STRING(['asd', 'asd'], '--') = 'asd--asd') or (TO_BASE64(b'\377\340') IS NULL) or (SAFE_CONVERT_BYTES_TO_STRING(b'\xc2') IS NULL) or is_inf(CAST('Infinity' AS float64)) or is_nan(CAST('NaN' AS float64)) or (CONTAINS_SUBSTR('the blue house', 'Blue house')) or (CONTAINS_SUBSTR((23, 35, 41), '35')) or (CONTAINS_SUBSTR(('abc', ['def', 'ghi', 'jkl'], 'mno'), 'jk')) or (CONTAINS_SUBSTR(JSON '{"lunch":"soup"}', "lunch", json_scope => "JSON_VALUES")) or (CONTAINS_SUBSTR(JSON '{"lunch":"soup"}', "lunch", json_scope => "JSON_KEYS_AND_VALUES")) or (ENDS_WITH(c_string, 'e')) or (REGEXP_CONTAINS('abhishek@prophecy.io', r'@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+')) or (REGEXP_CONTAINS('abhishek@prophecy.io', r'^([\w.+-]+@foo\.com|[\w.+-]+@bar\.org)$')) or (STARTS_WITH('asdasdasd', 'b')) or (BOOL(JSON_QUERY(JSON '{"hotel class": "5-star", "vacancy": true}', "$.vacancy"))) or (SAFE.FLOAT64(JSON '"strawberry"') IS NULL) AS c_bool_expr,
    {{ SQL_BaseGitDepProjectAllFinal.bigquery__language_specific_concat_base() }} AS c_concat_expr,
    (10 * 2) / 5 + 10 - 3 + abs(-10) + SIGN(-1) + IEEE_DIVIDE(20, 4.0) + RAND() + SQRT(25.0) + pow(2, 3) - power(2, 3) + exp(1) + ln(1) + log(100, 10) + log10(10) + GREATEST(1, 2, 3, 4, 5.23, 0, -10) + LEAST(1, 2, 3, 4, 5.23, 0, -10) + div(10, 10) + SAFE_DIVIDE(0, 20) + SAFE_MULTIPLY(1, 2) + SAFE_NEGATE(2000) + SAFE_ADD(1, 2) + SAFE_SUBTRACT(10, 20000) + mod(10, 2) + ROUND(2.8) + ROUND(-2.3) + ROUND(NUMERIC "2.25", 1, "ROUND_HALF_EVEN") + ROUND(NUMERIC "-2.5", 0, "ROUND_HALF_AWAY_FROM_ZERO") + trunc(-2.3323) + ceil(-2.8) + ceiling(-2.8) + floor(2.3) + cos(12) + cosh(1) + ACOS(0.123) + ACOSH(1) + COT(1) + SAFE.COT(0) + COTH(1) + SAFE.COTH(1) - CSC(100) + SAFE.CSC(100) + CSCH(0.5) + SEC(100) + SECH(0.5) + SIN(0.2) + SINH(0.2) + ASIN(0.2) + ASINH(0.1) + TAN(1) + TANH(1) + ATAN(1) + ATANH(0.12321) + ATAN2(1, 2) + CBRT(27) + RANGE_BUCKET(20, [0, 10, 20, 30, 40]) + RANGE_BUCKET('a', ['a', 'b', 'c', 'd']) + BYTE_LENGTH('?????') + CHAR_LENGTH('asdasd?????') + CHARACTER_LENGTH('asdasd?????') + INSTR('banana', 'an', 1, 2) + LENGTH('?????') + OCTET_LENGTH('sadasd') + REGEXP_INSTR('abhisheks@gmail.com', '@[^.]*') + STRPOS('abhishek@gmail.com', '@') + UNICODE('?') + INT64(JSON_QUERY(JSON '{"gate": "A4", "flight_number": 2}', "$.flight_number")) + FLOAT64(JSON_QUERY(JSON '{"vo2_max": 2.1, "age": 18}', "$.vo2_max")) + ARRAY_LENGTH([1, 2]) + EXTRACT(HOUR FROM DATETIME(2008, 12, 25, 15, 30, 0)) - EXTRACT(WEEK(SUNDAY) FROM DATETIME(TIMESTAMP'2017-11-05 00:00:00+00', "UTC")) + EXTRACT(HOUR FROM TIME "15:30:00") - EXTRACT(MONTH FROM (INTERVAL '1-2 3 4:5:6.789999' YEAR TO SECOND)) AS c_add_expr,
    c_string AS c_string,
    c_geography AS c_geography,
    c_numeric_1 AS c_numeric_1,
    p_date AS p_date,
    c_timestamp AS c_timestamp,
    c_bool AS c_bool,
    c_json AS c_json,
    c_interval AS c_interval,
    c_int64 * 2 AS c_int16_into_two,
    c_float64 AS c_float64,
    c_numeric_2 AS c_numeric_2,
    c_date AS c_date,
    c_datetime AS c_datetime,
    c_bytes AS c_bytes,
    c_struct AS c_struct,
    c_array_int64 AS c_array_int64,
    c_time AS c_time,
    c_bignumeric AS c_bignumeric,
    {{ SQL_BigQueryParentProjectMain.qa_boolean_macro('c_int64') }} AS c_concat_basic,
    concat('{{ dbt_utils.pretty_time() }}', '{{ dbt_utils.pretty_log_format("my pretty message") }}') AS c_dbt_utils,
    `prophecy-qa`.qa_test_dataset.qa_addFourAndDivide(c_int64, 2) AS c_function_bigquery,
    {{v_expression_config}} AS c_expression_from_config,
    JUSTIFY_DAYS(INTERVAL 29 DAY) AS c_interval_1,
    SUM(c_numeric_1) OVER (PARTITION BY c_date ORDER BY c_datetime ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS c_sum_over
  
  FROM Join_1 AS in0

),

ORDERS AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_suggestion_database', 'ORDERS') }}

),

Reformat_4 AS (

  SELECT * 
  
  FROM ORDERS AS in0

),

PAYMENTS AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_suggestion_database', 'PAYMENTS') }}

),

Reformat_3 AS (

  SELECT * 
  
  FROM PAYMENTS AS in0

),

TIME_DIM AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_suggestion_database', 'TIME_DIM') }}

),

Reformat_2 AS (

  SELECT 
    T_TIME_SK AS T_TIME_SK,
    T_TIME_ID AS T_TIME_ID,
    T_TIME AS T_TIME,
    T_HOUR AS T_HOUR,
    T_MINUTE AS T_MINUTE,
    T_SECOND AS T_SECOND,
    T_AM_PM AS T_AM_PM,
    T_SHIFT AS T_SHIFT,
    T_SUB_SHIFT AS T_SUB_SHIFT,
    T_MEAL_TIME AS T_MEAL_TIME
  
  FROM TIME_DIM AS in0

),

CUSTOMER_ADDRESS AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_suggestion_database', 'CUSTOMER_ADDRESS') }}

),

Reformat_1 AS (

  SELECT * 
  
  FROM CUSTOMER_ADDRESS AS in0

),

combine_multi_tables_2 AS (

  {{ SQL_BigquerySharedBasic.combine_multi_tables(table_1 = 'Reformat_2', table_2 = 'Reformat_1', table_3 = 'Reformat_3', table_4 = 'Reformat_4', table_5 = 'Reformat_5', col_table_1 = 'T_SECOND') }}

),

Filter_1 AS (

  SELECT * 
  
  FROM AllStunningOne AS in0
  
  WHERE c_bool IS true or c_bool IS false

),

model_with_only_seed_base AS (

  SELECT * 
  
  FROM {{ ref('model_with_only_seed_base')}}

),

combine_multi_tables_1 AS (

  {{ SQL_BigquerySharedBasic.combine_multi_tables(table_1 = 'Filter_1', table_2 = 'Limit_2', table_3 = 'OrderBy_1', table_4 = 'Limit_1', table_5 = 'model_with_only_seed_base', col_table_1 = 'c_numeric_1') }}

)

SELECT *

FROM combine_multi_tables_1
