CREATE TABLE IF NOT EXISTS data_warehose.`1_bronze`.prd_info_raw(
  prd_id INT,
  prd_key VARCHAR(20),
  prd_nm VARCHAR(25),	
  prd_cost INT,
  prd_line VARCHAR(4),
  prd_start_dt DATE,	
  prd_end_dt DATE
)
USING DELTA
LOCATION 's3://s3-databrick-warehouse/bronze/prd_info_raw';