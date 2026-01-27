CREATE SCHEMA data_warehose.`3_gold`
managed LOCATION 's3://s3-databrick-warehouse/gold/';

---To Write the Gold table directly to S3 
CREATE OR REPLACE TABLE delta.`s3://s3-databrick-warehouse/gold/dim_customer/`
AS
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
    ci.cst_id AS customer_id,
    ci.cst_key AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,
    ci.cst_marital_status AS marital_status,
    CASE 
        WHEN ci.cst_gndr IS NOT NULL AND ci.cst_gndr != 'N/A' THEN ci.cst_gndr
        WHEN ca.GEN IS NOT NULL AND ca.GEN != 'N/A' THEN ca.GEN
        ELSE 'N/A'
    END AS gender,
    ci.cst_create_date AS create_date,
    ca.BDATE AS birthdate,
    COALESCE(la.cntry, 'Unknown') AS country
FROM data_warehose.`2_silver`.cust_info_clean ci
LEFT JOIN data_warehose.`2_silver`.erm_cust_az12_clean ca
    ON ci.cst_key = ca.cid
LEFT JOIN data_warehose.`2_silver`.erm_loc_a101_clean la
    ON ci.cst_key = la.cid;

---A VIEW so the table appears in Databricks

USE CATALOG workspace;
USE SCHEMA default;

CREATE OR REPLACE VIEW dim_customer
AS SELECT * FROM delta.`s3://s3-databrick-warehouse/gold/dim_customer/`;

SELECT * FROM dim_customer;

describe detail dim_customer;


