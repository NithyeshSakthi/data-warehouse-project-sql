-- ============================================================
-- VALIDATION SCRIPT FOR BRONZE TABLE -cust_info_raw
-- Purpose: Identify data quality issues before Silver cleaning
select * FROM data_warehose.`1_bronze`.cust_info_raw;
---This helps to create the DDL for silver Layer and load the cleaned data
---1.1 Finding Duplicates
---1.2 Checking Unwanted spaces
---1.3 Low cardinality columns
-- ============================================================
use catalog data_warehose;
use schema `1_bronze`;


--1.1 check total records
SELECT COUNT(*) AS total_records FROM cust_info_raw;

--1.2 Missing fields
SELECT * FROM cust_info_raw
WHERE cst_key is null
OR cst_firstname is null
OR cst_lastname is null
OR cst_marital_status is null;

--1.3 Duplicates
SELECT cst_id, count(*) FROM cust_info_raw 
GROUP BY cst_id
HAVING count(*) > 1;

--1.4 Unwanted spaces
SELECT * FROM cust_info_raw
WHERE TRIM(cst_firstname) != cst_firstname
OR TRIM(cst_lastname) != cst_lastname
OR TRIM(cst_gndr) != cst_gndr;

--1.5 Low cardinality columns
SELECT cst_gndr, count(*) FROM cust_info_raw GROUP BY cst_gndr;




