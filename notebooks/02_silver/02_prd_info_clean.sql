-- The error indicates missing source table in the SELECT statement.
USE data_warehose.`2_silver`;

INSERT INTO prd_info_clean(
  prd_id,
  cat_id,
  prd_key,
  prd_nm,	
  prd_cost,
  prd_line,
  prd_start_dt,	
  prd_end_dt, 
  dwh_create_date 
)
SELECT 
  prd_id, 
  REPLACE(SUBSTRING(prd_key,1, 5), "-", "_") AS cat_id, ---split into category id  
  SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key, ---split into product key
  prd_nm, 
  COALESCE(prd_cost, 0) AS prd_cost, --- replace into null as 0 
  CASE UPPER(TRIM(prd_line)) --- standardize the value
    WHEN 'M' THEN 'Mountain'
    WHEN 'R' THEN 'Road'
    WHEN 'T' THEN 'Touring'
    WHEN 'S' THEN 'Other Sales'
    ELSE 'N/A'
  END AS prd_line,
  CAST(prd_start_dt AS DATE) AS prd_start_dt,
  CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS prd_end_dt, -- Date modification 
  current_date() AS dwh_create_date
FROM data_warehose.`1_bronze`.prd_info_raw;

SELECT * FROM prd_info_clean;