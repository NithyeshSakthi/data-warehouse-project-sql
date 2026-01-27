
---============================================================================
---This script transforms the raw Bronze product data into a clean, deduplicated, 
---standardized Silver dataset.
---It loads cleaned data into the Silver table created by the DDL.
---Key Transformations Performed
--- 1. Deduplication
--- 2. Whitespace Cleanup
---  Removes leading/trailing spaces from names and text fields.
--- 3. Standardization
---   Converts inconsistent values into clean categories
--- 4. Null Handling
---   Ensures rows with missing cst_key are excluded, since cst_key is the unique identifier.
--- 5. Insert Overwrite
---  Replaces the entire Silver table with the latest cleaned dataset.
---1.1 Finding Duplicates
---1.2 Checking Unwanted spaces
---1.3 Low cardinality columns
--- Checking each columns in the prd_info_raw

---prd_id - Finding duplicate and null values

---prd_key - Contains too many informations like product key with categorical id
--- Separed the customer key into category id and product key

---prd_nm - no change

---prd_cost - Have few null values
---cHNAGED NULL INTO 0

---prd_line Standarization required 
---    'M' THEN 'Mountain', 'R' ->'Road', 'T'  =>'Touring', 'S' => 'Other Sales'

---prd_start_dt missmatching dates & no time required

---prd-end_dt missmatched dates & no time requrired
 --- dATE modification done

---dwh_create_date
--- =========================================================================================

USE data_warehose.`2_silver`;

INSERT INTO prd_info_clean(
  prd_id,
  cat_id,
  prd_key,
  prd_nm,	
  prd_cost,
  prd_line,
  prd_start_dt,	
  prd_end_dt, 
  dwh_create_date 
)
SELECT 
  prd_id, 
  REPLACE(SUBSTRING(prd_key,1, 5), "-", "_") AS cat_id, ---split into category id  
  SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key, ---split into product key
  prd_nm, 
  COALESCE(prd_cost, 0) AS prd_cost, --- replace into null as 0 
  CASE UPPER(TRIM(prd_line)) --- standardize the value
    WHEN 'M' THEN 'Mountain'
    WHEN 'R' THEN 'Road'
    WHEN 'T' THEN 'Touring'
    WHEN 'S' THEN 'Other Sales'
    ELSE 'N/A'
  END AS prd_line,
  CAST(prd_start_dt AS DATE) AS prd_start_dt,
  CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS prd_end_dt, -- Date modification 
  current_date() AS dwh_create_date
FROM data_warehose.`1_bronze`.prd_info_raw;

SELECT * FROM prd_info_clean;