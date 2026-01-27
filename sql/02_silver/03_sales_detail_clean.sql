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
---===============================================================
---1.1 sls_ord_num: CHECK THE SPACING
---1.2 sls_prd_key: CHECK WITH prd_info prd_key
---1.3 sls_cust_id: CHECK WITH cus_info cust_id
---1.4 sls_order_dt: CHECK NULL 0, CONTAIN MORE THAN 8 DIGIT, ORDER DATE> SHIP DATE & ORDER DATE> due date 
---1.5 sls_ship_dt: CHECK NULL 0, CONTAIN MORE THAN 8 DIGIT
---1.6 sls_due_dt: CHECK NULL 0, CONTAIN MORE THAN 8 DIGIT
---1.7 sls_sales: CHECK NULL & ''-'', 0, NULL 
---1.8 sls_quantity:CHECK NULL & ''-'', 0, NULL 
---1.9 sls_price:CHECK NULL & ''-'', 0, NULL 
--- =========================================================================================

USE data_warehose.`2_silver`;

INSERT INTO  data_warehose.`2_silver`.sales_detail_clean(
  sls_ord_num,
  sls_prd_key ,
  sls_cust_id,
  sls_order_dt,
  sls_ship_dt,
  sls_due_dt,
  sls_sales,	
  sls_quantity,	
  sls_price,
  dwh_create_date
)
SELECT 
  sls_ord_num ,
  sls_prd_key ,
  sls_cust_id,
        CASE 
            WHEN sls_order_dt = 0 
              OR sls_order_dt IS NULL
              OR LENGTH(CAST(sls_order_dt AS STRING)) != 8 
            THEN NULL
            ELSE to_date(CAST(sls_order_dt AS STRING), 'yyyyMMdd')
        END AS sls_order_dt,

        -- SHIP DATE CLEAN
        CASE 
            WHEN sls_ship_dt = 0
              OR sls_ship_dt IS NULL
              OR LENGTH(CAST(sls_ship_dt AS STRING)) != 8 
            THEN NULL
            ELSE to_date(CAST(sls_ship_dt AS STRING), 'yyyyMMdd')
        END AS sls_ship_dt,

        -- DUE DATE CLEAN
        CASE 
            WHEN sls_due_dt = 0
              OR sls_due_dt IS NULL
              OR LENGTH(CAST(sls_due_dt AS STRING)) != 8 
            THEN NULL
            ELSE to_date(CAST(sls_due_dt AS STRING), 'yyyyMMdd')
        END AS sls_due_dt,

  CASE 
      WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
          THEN CAST(sls_quantity AS DOUBLE) * ABS(CAST(sls_price AS DOUBLE))
      ELSE CAST(sls_sales AS DOUBLE)    
  END AS sls_sales,
  CAST(sls_quantity AS DOUBLE),---No chnage in the quntity 
  CASE 
    WHEN sls_price IS NULL OR sls_price <=0 
          THEN CAST(sls_sales AS DOUBLE) / NULLIF(CAST(sls_quantity AS DOUBLE),0)
    ELSE CAST(sls_price AS DOUBLE)
  END AS sls_price,
  current_date() AS dwh_create_date
FROM data_warehose.`1_bronze`.sales_detail_raw;

SELECT * FROM sales_detail_clean;
