# data-warehouse-project-sql

Welcome to the **Retail Sales Data Warehouse** [repo](https://github.com/NithyeshSakthi/data-warehouse-project-sql/tree/main)

This project demonstrate the data warehouse from building to generating the actionable insights. Best practices done for Data Engineering and Analytics.
Cloud data lake
---
# 1. Project Overview

A complete End to End project for Data Engineering & Analysis purpose for the E-Commerce Auto sales company using AWS S3, Data Bricks SQL warehouse and Unity Catalog.

This pipeline ingests raw CRM and ERM datsets into AWS S#. Then it process through Bronze -> silver -> Gold layers using Databricks and produces the sales & Revenue Dashboard using Datbricks 
SQL warehouse.

List of Real Data Engineer Practices.

- Cloud Storage (s3+ Delta Lake)
- SQL Warehouse compute for BI work
- Unity Catlog Governance
- Medallion Architecture
- Star schema modelling
- Databricks Dashboard
- GitHub version control

---
# 2.High Level Architecture
![image_1769612116979.png](./image_1769612116979.png "image_1769612116979.png")



---

# 3.Medallion Architecture
### Bronze Layer- Raw Zone(storage- s3+ Delta)
Object Type- Table
- Stores raw CRM & ERM data exactly as received 
- Schema on read
- Used for audit & replay
- validate

### Silver layer - Cleaned Zone(Delta)
Object Type- Table

Transformation &  Cleaning
-     Removes Duplicate
-     Standrization
-     Data Normalization derived column 
-     data Enrichment

### Gold layer - Business zone(storage- s3)
Object Type- View
- Data integration 
- Aggregation
- Business Logic
- Star Schema modeling
- Optimize for BI performance

---
Why we used DATA WAREHOUSE?
- To optimize & quick run in sql serverless compute
- Designed for dashboard & reporting
- Provide high concurrency for analysis
- Integrsted directly wit Databricks SQL Dashboards

DataBricks SQL Warehouse - Compute engine for analysis & Dashboard

---
## 4.Project Requirements


![image_1769613897777.png](./image_1769613897777.png "image_1769613897777.png")

![image_1769613969702.png](./image_1769613969702.png "image_1769613969702.png")

![image_1769613830072.png](./image_1769613830072.png "image_1769613830072.png")

![image_1769613786380.png](./image_1769613786380.png "image_1769613786380.png")