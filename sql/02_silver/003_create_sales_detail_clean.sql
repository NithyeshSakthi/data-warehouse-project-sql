-- ============================================================
-- CREATE SILVER TABLE: prd_info_raw
-- Creating the clean DDL extracted from the raw zone

USE data_warehose.`2_silver`;

CREATE TABLE IF NOT EXISTS sales_detail_clean (
  sls_ord_num VARCHAR(20),
  sls_prd_key VARCHAR(20),
  sls_cust_id INT,
  sls_order_dt  DATE,
  sls_ship_dt DATE,
  sls_due_dt DATE,
  sls_sales INT,	
  sls_quantity INT,	
  sls_price INT,
  dwh_create_date TIMESTAMP
)
USING DELTA;

SELECT * FROM data_warehose.`2_silver`.sales_detail_clean;
DROP TABLE data_warehose.`2_silver`.sales_detail_clean;
