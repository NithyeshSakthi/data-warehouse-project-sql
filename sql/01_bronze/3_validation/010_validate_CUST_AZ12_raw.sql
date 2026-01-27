-- ============================================================
-- VALIDATION SCRIPT FOR BRONZE TABLE -prd_info_raw
-- Purpose: Identify data quality issues before Silver cleaning
--- Checking Data qulaity issues
---cid- CID should connect customer key 
---extra character
---1.2BDATE
---check ddate- data type
---check birthday boundary 
---invalid birthday
---1.3GEN- ccheck standardization & consistenc 
---=====================================================

---1.1 cid- CID
SELECT cid FROM data_warehose.`1_bronze`.erm_cust_az12_raw;

---RESULT: CONTAIN EXTRA INFO IN THE IT NOT RELATED TO cutomer ID
---1.2 BDATE
SELECT BDATE FROM data_warehose.`1_bronze`.erm_cust_az12_raw;

DESCRIBE data_warehose.`1_bronze`.erm_cust_az12_raw;

--RESULT FEW WRONG INFO & INVALID BIRTH DATE BOUNDRY
---1.3GEN- ccheck standardization & consistenc
SELECT GEN FROM data_warehose.`1_bronze`.erm_cust_az12_raw;

---RESULT: FEW SERLIZATON REURED , CORRECT SPACE

---