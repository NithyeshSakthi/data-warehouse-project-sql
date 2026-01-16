-- ============================================================
-- BRONZE INGESTION: PRODUCT INFORMATION (CUST_AZ12)
-- Layer: Bronze
-- Purpose: Load raw CRM customer data from S3 into Delta table
-- ============================================================

-- Use the correct catalog and schema
USE CATALOG data_warehose;
USE SCHEMA `1_bronze`;

-- Ingest raw CSV into Bronze Delta table
COPY INTO data_warehose.`1_bronze`.erm_cust_az12_raw
FROM 's3://s3-databrick-warehouse/databases/source_erm/CUST_AZ12.csv'
FILEFORMAT = CSV
FORMAT_OPTIONS (
    'header' = 'true',
    'inferSchema' = 'true',
    'delimiter' = ','
)
COPY_OPTIONS (
    'mergeSchema' = 'true'
);

-- Quick validation after ingestion
SELECT COUNT(*) AS total_records
FROM data_warehose.`1_bronze`.erm_cust_az12_raw;

SELECT *
FROM data_warehose.`1_bronze`.erm_cust_az12_raw
LIMIT 10;