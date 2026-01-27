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

INSERT INTO  data_warehose.`2_silver`.erm_loc_a101_clean(
    CID,
    CNTRY,
    dwh_create_date
)
SELECT
    REPLACE (CID, "-", "") CID,
    CASE WHEN TRIM(CNTRY) IN ("US", "USA") THEN('United States')
         WHEN TRIM(CNTRY) = ("DE") THEN ('Germany')
         WHEN TRIM(CNTRY) ='' OR CNTRY IS NULL THEN "N/A"
         ELSE TRIM(CNTRY)
    END AS CNTRY,
CURRENT_TIMESTAMP AS dwh_create_date
FROM data_warehose.`1_bronze`.erm_loc_a101_raw;

SELECT * FROM data_warehose.`2_silver`.erm_loc_a101_clean;

SELECT CNTRY FROM data_warehose.`2_silver`.erm_loc_a101_clean
GROUP BY CNTRY;
