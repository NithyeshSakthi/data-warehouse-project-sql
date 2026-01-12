CREATE TABLE IF NOT EXISTS data_warehose.`1_bronze`.cust_info_raw(
 cst_id INT,
  cst_key	VARCHAR(20),
  cst_firstname VARCHAR(20),
  cst_lastname VARCHAR(20),
  cst_marital_status VARCHAR(5),	
  cst_gndr VARCHAR(5),	
  cst_create_date DATE 
)
USING DELTA
LOCATION 's3://s3-databrick-warehouse/bronze/cust_info_raw';