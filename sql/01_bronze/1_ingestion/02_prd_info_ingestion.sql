-- ============================================================
-- BRONZE INGESTION: PRODUCT INFORMATION (prd_info_raw)
-- Layer: Bronze
-- Purpose: Load raw CRM customer data from S3 into Delta table
-- ============================================================

-- Use the correct catalog and schema
USE CATALOG data_warehose;
USE SCHEMA `1_bronze`;

-- Ingest raw CSV into Bronze Delta table
COPY INTO data_warehose.`1_bronze`.prd_info_raw 
FROM 's3://s3-databrick-warehouse/databases/source_crm/prd_info.csv'
FILEFORMAT = CSV
FORMAT_OPTIONS (
    'header' = 'true',
    'inferSchema' = 'true',
    'delimiter' = ','
)
COPY_OPTIONS (
    'mergeSchema' = 'true'
);

-- Optional: Quick validation after ingestion
SELECT COUNT(*) AS total_records
FROM data_warehose.`1_bronze`.prd_info_raw;

SELECT *
FROM data_warehose.`1_bronze`.prd_info_raw
LIMIT 10;

select * from prd_info_raw;