-- ============================================================
-- VALIDATION SCRIPT FOR BRONZE TABLE -erm_px_cat_g1v2_raw
-- Purpose: Identify data quality issues before Silver cleaning

---=====================================================
SELECT * FROM data_warehose.`1_bronze`.erm_px_cat_g1v2_raw;  
---1.1 id- ID
DESCRIBE data_warehose.`1_bronze`.erm_px_cat_g1v2_raw;

---CAT CHECKING FOR WHITE SPACE
SELECT CAT, SUBCAT, MAINTENANCE
FROM data_warehose.`1_bronze`.erm_px_cat_g1v2_raw
WHERE CAT != TRIM(CAT) OR SUBCAT != TRIM(SUBCAT) OR MAINTENANCE != TRIM(MAINTENANCE)
;

---CHECK STANDARIZATION & CONSISTENCY OF COLUMNS
SELECT DISTINCT CAT, SUBCAT, MAINTENANCE
FROM data_warehose.`1_bronze`.erm_px_cat_g1v2_raw;


---RESULT: NO ISSUES