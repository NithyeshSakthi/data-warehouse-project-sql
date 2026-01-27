-- ============================================================
-- BRONZE INGESTION: PRODUCT INFORMATION (/PX_CAT_G1V2)
-- Layer: Bronze
-- Purpose: Load raw CRM customer data from S3 into Delta table
-- ============================================================

-- Use the correct catalog and schema
USE CATALOG data_warehose;
USE SCHEMA `1_bronze`;

-- Ingest raw CSV into Bronze Delta table
COPY INTO data_warehose.`1_bronze`.erm_px_cat_g1v2_raw
FROM 's3://s3-databrick-warehouse/databases/source_erm/PX_CAT_G1V2.csv'
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
FROM data_warehose.`1_bronze`.erm_px_cat_g1v2_raw;

SELECT *
FROM data_warehose.`1_bronze`.erm_px_cat_g1v2_raw
LIMIT 10;