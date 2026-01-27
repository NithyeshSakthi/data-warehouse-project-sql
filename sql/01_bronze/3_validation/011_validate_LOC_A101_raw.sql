-- ============================================================
-- VALIDATION SCRIPT FOR BRONZE TABLE -LOC_A101_RAW
-- Purpose: Identify data quality issues before Silver cleaning

---=====================================================
SELECT * FROM data_warehose.`1_bronze`.erm_loc_a101_raw;  
---1.1 cid- CID
DESCRIBE data_warehose.`1_bronze`.erm_loc_a101_raw;

SELECT DISTINCT
CNTRY
FROM data_warehose.`1_bronze`.erm_loc_a101_raw
ORDER BY CNTRY;

---reslut; CONTRY HAVE FEW ISSUES, WRONG NAME, NULL, MISSING VALUES
---RESULT: REMOVE - IN THE CID, 