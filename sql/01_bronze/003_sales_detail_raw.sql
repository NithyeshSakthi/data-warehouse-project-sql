CREATE TABLE IF NOT EXISTS data_warehose.`1_bronze`.sales_detail_raw(
  sls_ord_num VARCHAR(20),
  sls_prd_key VARCHAR(20),
  sls_cust_id INT,
  sls_order_dt  INT,
  sls_ship_dt INT,
  sls_due_dt INT,
  sls_sales INT,	
  sls_quantity INT,	
  sls_price INT  
)
USING DELTA
LOCATION "s3://s3-databrick-warehouse/bronze/sales_detail_raw"
;