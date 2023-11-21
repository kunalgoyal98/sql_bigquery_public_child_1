WITH SHIP_MODE AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_test_dataset', 'SHIP_MODE') }}

),

CATALOG_SALES AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_test_dataset', 'CATALOG_SALES') }}

),

DATE_DIM AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_test_dataset', 'DATE_DIM') }}

),

ITEM AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_test_dataset', 'ITEM') }}

),

SQLStatement_3 AS (

  SELECT 
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price,
    sum(ss_ext_sales_price) AS itemrevenue,
    sum(ss_ext_sales_price) * 100 / sum(sum(ss_ext_sales_price)) OVER (PARTITION BY i_class) AS revenueratio
  
  FROM `prophecy-qa`.qa_test_dataset.STORE_SALES, item, date_dim
  
  WHERE ss_item_sk = i_item_sk
        and i_category IN ('Women', 'Electronics', 'Shoes')
        and ss_sold_date_sk = d_date_sk
        and d_date BETWEEN CAST('2002-05-27' AS date)
        and DATE_ADD(DATE'2002-05-27', INTERVAL 30 DAY)
  
  GROUP BY 
    i_item_id, i_item_desc, i_category, i_class, i_current_price
  
  ORDER BY i_category, i_class, i_item_id, i_item_desc, revenueratio

),

WAREHOUSE AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_test_dataset', 'WAREHOUSE') }}

),

CALL_CENTER AS (

  SELECT * 
  
  FROM {{ source('prophecy-qa.qa_test_dataset', 'CALL_CENTER') }}

),

SQLStatement_0 AS (

  SELECT 
    substr(w_warehouse_name, 1, 20),
    sm_type,
    cc_name,
    sum(CASE
      WHEN (cs_ship_date_sk - cs_sold_date_sk <= 30)
        THEN 1
      ELSE 0
    END) AS a_30_days,
    sum(
      CASE
        WHEN (cs_ship_date_sk - cs_sold_date_sk > 30) and (cs_ship_date_sk - cs_sold_date_sk <= 60)
          THEN 1
        ELSE 0
      END) AS a_31_60_days,
    sum(
      CASE
        WHEN (cs_ship_date_sk - cs_sold_date_sk > 60) and (cs_ship_date_sk - cs_sold_date_sk <= 90)
          THEN 1
        ELSE 0
      END) AS a_61_90_days,
    sum(
      CASE
        WHEN (cs_ship_date_sk - cs_sold_date_sk > 90) and (cs_ship_date_sk - cs_sold_date_sk <= 120)
          THEN 1
        ELSE 0
      END) AS a_91_120_days,
    sum(CASE
      WHEN (cs_ship_date_sk - cs_sold_date_sk > 120)
        THEN 1
      ELSE 0
    END) AS a_120_days_and_more
  
  FROM catalog_sales, warehouse, ship_mode, call_center, date_dim
  
  WHERE d_month_seq BETWEEN 1200
        and 1200 + 11
        and cs_ship_date_sk = d_date_sk
        and cs_warehouse_sk = w_warehouse_sk
        and cs_ship_mode_sk = sm_ship_mode_sk
        and cs_call_center_sk = cc_call_center_sk
  
  GROUP BY 
    substr(w_warehouse_name, 1, 20), sm_type, cc_name
  
  ORDER BY sm_type, cc_name
  
  LIMIT 100

),

Join_1 AS (

  SELECT 
    in1.I_ITEM_ID AS I_ITEM_ID,
    in1.I_ITEM_DESC AS I_ITEM_DESC,
    in1.I_CATEGORY AS I_CATEGORY,
    in1.I_CLASS AS I_CLASS,
    in1.I_CURRENT_PRICE AS I_CURRENT_PRICE,
    in1.ITEMREVENUE AS ITEMREVENUE,
    in1.REVENUERATIO AS REVENUERATIO,
    in0.SM_TYPE AS SM_TYPE,
    in0.CC_NAME AS CC_NAME
  
  FROM SQLStatement_0 AS in0
  INNER JOIN SQLStatement_3 AS in1
     ON in0.SM_TYPE != in1.I_ITEM_DESC

)

SELECT *

FROM Join_1
