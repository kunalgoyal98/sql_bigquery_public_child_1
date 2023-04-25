WITH all_type_table AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_test_dataset', 'all_type_table') }}

),

Reformat_1 AS (

  SELECT * 
  
  FROM all_type_table AS in0

)

SELECT *

FROM Reformat_1
