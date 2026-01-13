CREATE TABLE IF NOT EXISTS data_warehose.`1_bronze`.erm_PX_CAT_G1V2_raw(
  ID VARCHAR(20),
  CAT VARCHAR(20),	
  SUBCAT VARCHAR(20),	
  MAINTENANCE VARCHAR(10)
)
USING DELTA
LOCATION "s3://s3-databrick-warehouse/bronze/erm_PX_CAT_G1V_raw"
;