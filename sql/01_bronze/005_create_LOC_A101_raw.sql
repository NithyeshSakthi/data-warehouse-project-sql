CREATE TABLE IF NOT EXISTS data_warehose.`1_bronze`.erm_LOC_A101_raw(
  CID VARCHAR(20),	
  CNTRY VARCHAR(20)
)
USING DELTA
LOCATION "s3://s3-databrick-warehouse/bronze/erm_LOC_A101_raw";