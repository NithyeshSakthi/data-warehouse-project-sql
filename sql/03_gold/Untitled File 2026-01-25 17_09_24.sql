

---CREATE SCHEMA data_warehose.`3_gold`
use LOCATION 's3://s3-databrick-warehouse/gold/';



DESCRIBE DETAIL data_warehose.`3_gold`.dim_products;
DESCRIBE DETAIL data_warehose.`3_gold`.dim_customer;
DESCRIBE DETAIL data_warehose.`3_gold`.fact_sales;



select * from data_warehose.`3_gold`.dim_customer;