-- ============================================================
-- CREATE SILVER TABLE: prd_info_raw
-- Creating the clean DDL extracted from the raw zone

USE data_warehose.`2_silver`;

CREATE TABLE IF NOT EXISTS prd_ifo_clean (
  prd_id INT,
  cat_id VARCHAR(50),--- creating additonal column with categorical ID
  prd_key VARCHAR(50),
  prd_nm VARCHAR(50),	
  prd_cost INT,
  prd_line VARCHAR(20),
  prd_start_dt DATE,	
  prd_end_dt DATE, 
  dwh_create_date TIMESTAMP -- Creating and record the date of loading
)
USING DELTA;

SELECT * FROM data_warehose.`2_silver`.prd_ifo_clean;

ALTER TABLE data_warehose.`2_silver`.prd_ifo_clean 
RENAME TO data_warehose.`2_silver`.prd_info_clean;