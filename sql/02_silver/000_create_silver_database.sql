-- ============================================================
-- CREATE SILVER SCHEMA
-- This command creates the Silver schema inside the catalog
-- 'data_warehose'. The Silver layer stores cleaned data
-- exactly as it arrives from the raw zone.
--
-- data_warehouse:
--   This is the Unity Catalog catalog where all your schemas
--   and tables for the project are organized.
--
-- `2_silver`:
--   The schema name. Backticks are required because the name
--   starts with a number. This schema will contain all cleaned
--   Delta tables such as cust_info_raw, prd_info_raw, etc.
--
-- ============================================================




CREATE DATABASE IF NOT EXISTS data_warehose.`2_silver`;