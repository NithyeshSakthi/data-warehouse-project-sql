-- ============================================================
-- CREATE SILVER TABLE: erm_loc_a101_clean
-- Creating the clean DDL extracted from the raw zone

USE data_warehose.`2_silver`;

CREATE TABLE IF NOT EXISTS erm_loc_a101_clean (
  CID	varchar(20),
  CNTRY	varchar(20),
  dwh_create_date TIMESTAMP
)
USING DELTA;

SELECT * FROM data_warehose.`2_silver`. erm_loc_a101_clean;

