-- ============================================================
-- CREATE SILVER TABLE: erm_px_cat_g1v2_clean
-- Creating the clean DDL extracted from the raw zone

USE data_warehose.`2_silver`;

CREATE TABLE IF NOT EXISTS erm_px_cat_g1v2_clean (
  ID	varchar(20),
  CAT	varchar(20),
  SUBCAT	varchar(20),
  MAINTENANCE	varchar(10),
  dwh_create_date TIMESTAMP
)
USING DELTA;

SELECT * FROM data_warehose.`2_silver`.erm_px_cat_g1v2_clean;

