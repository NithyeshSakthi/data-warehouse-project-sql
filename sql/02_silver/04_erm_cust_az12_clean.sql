---============================================================================
---This script transforms the raw Bronze product data into a clean, deduplicated, 
---standardized Silver dataset.
---It loads cleaned data into the Silver table created by the DDL.
---Key Transformations Performed
---1.1 Customer key (cid) is connected and standardized; extra characters removed
---1.2 ddate data type is validated
---Birthday boundary is checked; invalid birthdays are flagged
---1.3Gender (gen) is standardized and checked for consistency
---===============================================================================

USE data_warehose.`2_silver`;

INSERT INTO  data_warehose.`2_silver`.erm_cust_az12_clean(
  CID,
  BDATE,
  GEN,
  dwh_create_date
)
SELECT
CASE 
    WHEN CID LIKE "NAS%" THEN SUBSTRING (CID, 4, LEN(CID))
    ELSE CID
END AS CID,
CASE 
    WHEN BDATE > GETDATE() THEN NULL
    ELSE BDATE
END AS BDATE,
CASE 
    WHEN UPPER(TRIM(GEN)) IN ("M", "MALE") THEN "Male"
    WHEN UPPER(TRIM(GEN)) IN ("F", "FEMALE") THEN "Female"
    ELSE "n/a"
END AS GEN,
CURRENT_TIMESTAMP AS dwh_create_date
FROM data_warehose.`1_bronze`.erm_cust_az12_raw;

SELECT * FROM data_warehose.`2_silver`.erm_cust_az12_clean;
