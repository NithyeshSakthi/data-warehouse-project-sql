-- ============================================================
-- VALIDATION SCRIPT FOR BRONZE TABLE -sales_detail_raw
-- Purpose: Identify data quality issues before Silver cleaning
--- Checking Data qulaity issues
---select * FROM data_warehose.`1_bronze`.sales_detail_raw;
---This helps to create the DDL for silver Layer and load the cleaned data
---1.1 Finding Duplicates
---1.2 Checking Unwanted spaces
---1.3 Low cardinality columns
--- Checking each columns in the sales_detail_raw

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

SELECT * FROM sales_detail_raw;

---1.1 sls_ord_num: CHECK THE SPACING
---1.2 sls_prd_key: CHECK WITH prd_info prd_key
---1.3 sls_cust_id: CHECK WITH cus_info cust_id
---1.4 sls_order_dt: CHECK NULL 0, CONTAIN MORE THAN 8 DIGIT, ORDER DATE> SHIP DATE & ORDER DATE> due date 
---1.5 sls_ship_dt: CHECK NULL 0, CONTAIN MORE THAN 8 DIGIT
---1.6 sls_due_dt: CHECK NULL 0, CONTAIN MORE THAN 8 DIGIT
---1.7 sls_sales: CHECK NULL & ''-'', 0, NULL 
---1.8 sls_quantity:CHECK NULL & ''-'', 0, NULL 
---1.9 sls_price:CHECK NULL & ''-'', 0, NULL 
---========================================================================

---1.1 sls_ord_num
SELECT TRIM(sls_ord_num) != sls_ord_num FROM sales_detail_raw;

---1.2 CHECK MATCH WITH PRODUCT KEY
SELECT *
FROM sales_detail_raw
WHERE sls_prd_key NOT IN (SELECT prd_key FROM data_warehose.`2_silver`.prd_info_clean);

---RESULT NO ROW

---1.3 sls_cust_id
SELECT * FROM sales_detail_raw
WHERE sls_cust_id NOT IN (SELECT cst_id FROM data_warehose.`1_bronze`.cust_info_raw);

---1.4 sls_order_dt  CHECK NULL 0, CONTAIN MORE THAN 8 DIGIT, ORDER DATE> SHIP DATE & ORDER DATE> due date 
SELECT sls_order_dt 
FROM `1_bronze`.sales_detail_raw
WHERE sls_order_dt IS NULL
OR sls_order_dt <=0
OR LENGTH(sls_order_dt) != 8;
--- RESLUT coontan multiple 0, strange numbera, all values are <=8 digits 


---1.5 sls_ship_dt: CHECK NULL 0, CONTAIN MORE THAN 8 DIGIT

SELECT sls_ship_dt
FROM `1_bronze`.sales_detail_raw
WHERE sls_ship_dt IS NULL
OR sls_ship_dt <=0
OR LENGTH(sls_ship_dt) !=8;


---RESULT: NO ISSUES IN THE sls_ship_dt
---1.6 sls_due_dt: CHECK NULL 0, CONTAIN MORE THAN 8 DIGIT
SELECT sls_due_dt
FROM `1_bronze`.sales_detail_raw
WHERE sls_due_dt IS NULL
OR sls_due_dt <=0
OR LENGTH(sls_due_dt) != 8;

---RESULT: EVERYTHING LOOKS GOOD

---1.7 cHCKING DATE ORDERS

SELECT sls_due_dt, sls_ship_dt, sls_order_dt
FROM `1_bronze`.sales_detail_raw
WHERE sls_order_dt > sls_ship_dt
OR sls_order_dt > sls_due_dt;

----RESLUT: ORDERS ARE GOOD

---1.8sls_sales: CHECK NULL & ''-'', 0, NULL 
---1.8 sls_quantity:CHECK NULL & ''-'', 0, NULL 
---1.9 sls_price:CHECK NULL & ''-'', 0, NULL 

SELECT DISTINCT sls_sales, sls_quantity, sls_price
FROM  `1_bronze`.sales_detail_raw
WHERE sls_sales IS NULL OR sls_sales <=0
OR sls_quantity IS NULL OR sls_quantity <=0
OR sls_price is null OR sls_price <=0
OR sls_sales != sls_quantity * sls_price
--- RESLULT: MANU NULL. NEGATIVE, WRONG SALES NUMBER

SELECT DISTINCT
    sls_sales,
    sls_quantity,
    sls_price,
    sls_quantity * sls_price AS expected_sales,
    sls_sales -   AS diff_from_expected
FROM `1_bronze`.sales_detail_raw
WHERE sls_sales IS NOT NULL
  AND sls_quantity IS NOT NULL
  AND sls_price IS NOT NULL
  AND sls_sales != sls_quantity * sls_price;

  ---RESULT : MANY UN MATCHED SALES NUMBER

  SELECT * FROM data_warehose.`1_bronze`.sales_detail_raw LIMIT 5;

