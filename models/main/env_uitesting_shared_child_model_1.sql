WITH env_uitesting_shared_mid_model_1 AS (

  SELECT * 
  
  FROM {{ ref('env_uitesting_shared_mid_model_1')}}

),

Reformat_1 AS (

  SELECT * 
  
  FROM env_uitesting_shared_mid_model_1 AS in0

),

OrderBy_1 AS (

  SELECT * 
  
  FROM Reformat_1 AS in0
  
  ORDER BY c_int64 ASC NULLS FIRST, c_bignumeric DESC NULLS LAST, c_bool DESC, c_string ASC NULLS LAST

),

Limit_1 AS (

  SELECT * 
  
  FROM OrderBy_1 AS in0
  
  LIMIT 45

),

Filter_1 AS (

  SELECT * 
  
  FROM Limit_1 AS in0
  
  WHERE true

)

SELECT *

FROM Filter_1
