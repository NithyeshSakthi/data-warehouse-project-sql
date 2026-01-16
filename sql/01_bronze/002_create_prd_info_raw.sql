-- ============================================================
-- CREATE BRONZE TABLE: prd_info_raw
--
-- Purpose:
--   This table stores raw customer information exactly as it
--   arrives from the source system (CSV in S3). No cleaning,
--   no transformations — pure raw data for auditability.
--
-- IF NOT EXISTS:
--   Ensures the script does not fail if the table already
--   exists. Safe for repeated runs during development.
--
-- data_warehouse.`1_bronze`:
--   The Unity Catalog catalog (data_warehose) and Bronze
--   schema (`1_bronze`) where all raw Delta tables are stored.
--   Backticks are required because the schema name starts
--   with a number.
--
-- USING DELTA:
--   Creates a Delta Lake table with ACID transactions,
--   schema enforcement, and versioning.
--
-- LOCATION:
--   Points the table to the physical storage path in S3.
--   This is the Bronze zone folder where Delta files will
--   be written and maintained.
--
-- Result:
--   A fully defined Bronze raw table ready for COPY INTO
--   ingestion from S3.
-- ============================================================

CREATE TABLE IF NOT EXISTS data_warehose.`1_bronze`.prd_info_raw(
  prd_id INT,
  prd_key VARCHAR(20),
  prd_nm VARCHAR(25),	
  prd_cost INT,
  prd_line VARCHAR(4),
  prd_start_dt DATE,	
  prd_end_dt DATE
)
USING DELTA
LOCATION "s3://s3-databrick-warehouse/bronze/prd_info_raw"
;