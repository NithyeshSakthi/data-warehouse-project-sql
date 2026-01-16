-- ============================================================
-- VALIDATION SCRIPT FOR BRONZE TABLE -prd_info_raw
-- Purpose: Identify data quality issues before Silver cleaning
--- Checking Data qulaity issues
---select * FROM data_warehose.`1_bronze`.prd_info_raw;
---This helps to create the DDL for silver Layer and load the cleaned data
---1.1 Finding Duplicates
---1.2 Checking Unwanted spaces
---1.3 Low cardinality columns
--- Checking each columns in the prd_info_raw

---prd_id - Finding duplicate and null values

---prd_key - Contains too many informations like product key with categorical id 

---prd_nm - looks cleaned 

---prd_cost - Have few null values

---prd_line Standarization required

---prd_start_dt missmatching dates & no time required

---prd-end_dt missmatched dates & no time requrired
-- ============================================================
use data_warehose.`1_bronze`;
-- ============================================================
-- 1.1 Finding Duplicates or null values

SELECT prd_id, count(*) AS duplicate_id 
FROM prd_info_raw 
GROUP BY prd_id 
HAVING count(*) >1 
OR prd_id IS NULL; 

--No null values

---1.2 validate prd_key 

SELECT prd_key
FROM prd_info_raw;
---need to seprate the categorical id and product key 
--eg: CO-RF-FR-R92B-58 should split as CO_RF as Categorical ID (cat_id) & FR-R92B-58 as product key(prd_key)

-- 1.3 Finding white Space prd_nm
SELECT prd_nm
FROM prd_info_raw
WHERE
prd_nm != trim(prd_nm); 

-- Result no white sapces 

--1.4 Finding negative and Null values in prd_cost

SELECT prd_cost
FROM prd_info_raw
WHERE prd_cost < 0 OR prd_cost IS NULL;

---Data contain no negtive values but few nulls 

-- 1.5 Data standardization & Consistency 
SELECT DISTINCT prd_line
FROM prd_info_raw;

---Result Standardize value R ,S ,M ,T &  null

---1.6 Checking for invalid start & end date
SELECT * 
FROM prd_info_raw
WHERE prd_end_dt < prd_start_dt or prd_start_dt IS NULL;


---Reslut having sart at 2011 and end at 2007 is wrong value






