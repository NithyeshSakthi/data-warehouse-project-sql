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
![](/Workspace/Users/nithyeshsakthi@gmail.com/data-warehouse-project-sql/src/image_1769612116979.png)



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
## 4.Folder Structure
```
databricks-data-warehouse-project/
│
├── dashboards/                          # Dashboard exports and visuals 
│   ├── Revenue Analytics Dashboard.pdf
│   └── sales.pdf
│
├── data_exports/                        # Exported data snapshots by layer in HTML format
│   ├── 01_bronze/
│   ├── 02_silver/
│   └── 03_gold/
│
├── datasets/                            # Raw input datasets (CRM, ERM)
│                    
│
├── docs/                                # Project documentation and diagrams
│   ├── 00WarehouseDiagram.drawio        # Warehouse architecture diagram
│   ├── 01Data Model2.drawio.png         # Explanation of Table structure
│   ├── 02Mermaid flowchart code.png     # End-to-end Table transformastion flow diagram
│   └── Project folder structure.md      # Detiled Folder structure with sample screenshots
│
├── notebooks/                           # Databricks notebooks by layer
│   ├── 01_bronze/
│   ├── 02_silver/
│   └── 03_gold/
│       ├── dim_customer_view.ipynb
│       ├── dim_products_view.ipynb
│       └── fact_sales_view.ipynb
│
├── sql/                                 # SQL scripts for ETL and modeling
│   ├── 01_bronze/
│   │   ├── 1_ingestion/
│   │   └── 3_validation/
│   │       ├── 000_create_bronze_database.sql
│   │       ├── 001_create_cust_info_raw.sql
│   │       ├── 002_create_prd_info_raw.sql
│   │       ├── 003_create_sales_detail_raw.sql
│   │       ├── 004_create_CUST_AZ12.sql
│   │       └── 005_create_LOC_A101.sql
│   ├── 02_silver/
│   └── 03_gold/
│
└── README.md                            # Project overview and instructions
```
---
Why we used DATA WAREHOUSE?
- To optimize & quick run in sql serverless compute
- Designed for dashboard & reporting
- Provide high concurrency for analysis
- Integrsted directly wit Databricks SQL Dashboards

DataBricks SQL Warehouse - Compute engine for analysis & Dashboard

---
## 4.Project Requirements



![](/Workspace/Users/nithyeshsakthi@gmail.com/data-warehouse-project-sql/src/image_1769613786380.png)
![](/Workspace/Users/nithyeshsakthi@gmail.com/data-warehouse-project-sql/src/image_1769613830072.png)
![](/Workspace/Users/nithyeshsakthi@gmail.com/data-warehouse-project-sql/src/image_1769613897777.png)
![](/Workspace/Users/nithyeshsakthi@gmail.com/data-warehouse-project-sql/src/image_1769613969702.png)
