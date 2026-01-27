USE CATALOG workspace;
USE SCHEMA default;


CREATE OR REPLACE TABLE delta.`s3://s3-databrick-warehouse/gold/fact_sales/`
AS
SELECT
    sd.sls_ord_num AS order_number,
    pr.product_key ,
    cu.customer_id,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt AS shipping_date,
    sd.sls_due_dt AS due_date,
    sd.sls_sales AS sales,
    sd.sls_quantity AS quantity,
    sd.sls_price AS price
FROM data_warehose.`2_silver`.sales_detail_clean sd 
LEFT JOIN workspace.default.dim_products pr
ON sd.sls_prd_key = pr.product_key1
LEFT JOIN workspace.default.dim_customer cu
ON sd.sls_cust_id = cu.customer_id;

USE CATALOG workspace;
USE SCHEMA default;

CREATE OR REPLACE VIEW fact_sales
AS SELECT * FROM delta.`s3://s3-databrick-warehouse/gold/fact_sales/`;

select * from fact_sales;
