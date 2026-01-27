-- ============================================================
-- CREATE SILVER TABLE: ERM_cust_az12
-- Creating the clean DDL extracted from the raw zone

USE data_warehose.`2_silver`;
DESCRIBE data_warehose.`1_bronze`.erm_cust_az12_raw;

CREATE TABLE IF NOT EXISTS erm_cust_az12_clean (
  CID	varchar(20),
  BDATE	date,
  GEN	varchar(20),
  dwh_create_date TIMESTAMP
)
USING DELTA;

SELECT * FROM data_warehose.`2_silver`.erm_cust_az12_clean;

