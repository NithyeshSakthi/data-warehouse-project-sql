USE CATALOG data_warehose;
USE SCHEMA `2_silver`;

CREATE TABLE IF NOT EXISTS cust_info_clean (
  cst_id INT,
  cst_key VARCHAR(20),
  cst_firstname VARCHAR(20),
  cst_lastname VARCHAR(20),
  cst_marital_status VARCHAR(10),
  cst_gndr VARCHAR(10),
  cst_create_date DATE,
  dwh_create_date TIMESTAMP
)
USING DELTA;