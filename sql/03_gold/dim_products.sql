


-- data_warehose.`2_silver`.prd_info_clean
-- data_warehose.`2_silver`.erm_px_cat_g1v2_clean

CREATE OR REPLACE TABLE delta.`s3://s3-databrick-warehouse/gold/dim_products/`
AS
SELECT DISTINCT
    ROW_NUMBER() OVER	(ORDER BY pn.prd_start_dt , pn.prd_key ) AS product_key,
	  pn.prd_id AS product_id,
	  pn.prd_key AS product_key1,
	  pn.prd_nm AS product_name,
	  pc.CAT AS category,
	  pc.SUBCAT AS sub_category,	
	  pn.prd_cost AS cost,
	  pn.prd_line AS product_line,
	  pn.prd_start_dt AS product_start_dt,	
    pc.maintenance AS maintenance
  FROM data_warehose.`2_silver`.prd_info_clean AS pn
  LEFT JOIN data_warehose.`2_silver`.erm_px_cat_g1v2_clean AS pc 
    ON pn.cat_id = pc.id
  WHERE pn.prd_end_dt IS NULL;




---A VIEW so the table appears in Databricks

USE CATALOG workspace;
USE SCHEMA default;

CREATE OR REPLACE VIEW dim_customer
AS SELECT * FROM delta.`s3://s3-databrick-warehouse/gold/dim_products/`;

SELECT * FROM dim_customer;



select product_name
order by count(product_name) desc;