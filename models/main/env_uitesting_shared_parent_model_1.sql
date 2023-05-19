WITH all_type_table AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_test_dataset', 'all_type_table') }}

),

Reformat_1 AS (

  SELECT * 
  
  FROM all_type_table AS in0

),

prophecy_qa_qa_test_dataset_ungrouped_customers AS (

  SELECT * 
  
  FROM prophecy-qa.qa_test_dataset.ungrouped_customers

),

Join_1 AS (

  SELECT 
    in0.c_int64 AS c_int64,
    in0.c_bignumeric AS c_bignumeric,
    in0.c_bool AS c_bool,
    in0.c_bytes AS c_bytes,
    in0.c_string AS c_string,
    in0.c_float64 AS c_float64,
    in0.c_numeric_1 AS c_numeric_1,
    in0.c_numeric_2 AS c_numeric_2,
    in0.c_date AS c_date,
    in0.c_interval AS c_interval,
    in0.c_time AS c_time,
    in0.c_timestamp AS c_timestamp,
    in0.c_datetime AS c_datetime,
    in0.c_geography AS c_geography,
    in0.c_json AS c_json,
    in0.c_array_int64 AS c_array_int64,
    in0.c_struct AS c_struct,
    in0.p_date AS p_date
  
  FROM Reformat_1 AS in0
  INNER JOIN prophecy_qa_qa_test_dataset_ungrouped_customers AS in1
     ON in0.c_int64 != in1.id

)

SELECT *

FROM Join_1
