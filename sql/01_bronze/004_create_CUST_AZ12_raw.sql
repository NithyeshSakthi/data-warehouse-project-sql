CREATE TABLE IF NOT EXISTS data_warehose.`1_bronze`.erm_CUST_AZ12_raw(
  CID VARCHAR(20),
  BDATE DATE,
  GEN VARCHAR(20)
)
USING DELTA
LOCATION "s3://s3-databrick-warehouse/bronze/erm_CUST_AZ12_raw"
;