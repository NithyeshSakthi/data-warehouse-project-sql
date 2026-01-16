---============================================================================
---This script transforms the raw Bronze customer data into a clean, deduplicated, 
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
--- =========================================================================================


INSERT OVERWRITE TABLE data_warehose.`2_silver`.cust_info_clean
SELECT  
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM (cst_lastname) AS cst_lastname, --- Remove the spacing 
    CASE
      WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
      WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
      ELSE 'N/A'
    END AS cst_marital_status, --- Standardize the marital status
    CASE
      WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
      WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
      ELSE 'N/A'
    END AS cst_gndr, ----- Standardize the gender
    cst_create_date DATE,
    CURRENT_TIMESTAMP AS dwh_create_date ----Current timestamp
FROM (
  SELECT *,
  ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
  FROM data_warehose.`1_bronze`.cust_info_raw
  WHERE cst_key IS NOT NULL
) t
WHERE flag_last =1; --- Latest record and depdlicated records are removed