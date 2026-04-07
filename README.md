# Sql-data-warehouse-project
******Greetings 🙌
**Welcome to the Datawarehouse and Analytic Project respository!!!!!**
This project demonstrates the design and development of a data warehouse using SQL Server, focusing on ETL processes, data modeling, and analytics,Here, you'll learn how organized pipelines and effective database design turn unstructured data into insightful knowledge. The project shows how to handle data integration, create scalable schemas, and run analytical queries in a useful way.

Project Summary

This project encompasses the full lifecycle of building and utilizing a data warehouse, focusing on the Medallion Architecture. Key areas include:
Data Architecture: Establishing a robust data warehouse structure using Bronze, Silver, and Gold layers.
ETL Pipelines: Implementing processes to ingest, clean, and load data from various sources.
Data Modeling: Designing efficient fact and dimension tables tailored for analytical purposes.
Analytics & Reporting: Developing SQL-driven reports and dashboards to provide valuable business insights.

This project serves as a practical showcase for skills in:
.SQL Development
.Data Architecture
.Data Engineering
.ETL Pipeline Development
.Data Modeling
.Data Analytics

Important Links & Tools:

Everything is for Free!

Datasets: Access to the project dataset (csv files).
SQL Server Express: Lightweight server for hosting your SQL database.
SQL Server Management Studio (SSMS): GUI for managing and interacting with databases.
Git Repository: Set up a GitHub account and repository to manage, version, and collaborate on your code efficiently.
DrawIO: Design data architecture, models, flows, and diagrams.
Notion: All-in-one tool for project management and organization.
Notion Project Steps: Access to All Project Phases and Tasks.

Project Requirements
Building the Data Warehouse (Data Engineering)
ObjectiveDevelop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.
Specifications
Data Sources: Import data from two source systems (ERP and CRM) provided as CSV files.
Data Quality: Cleanse and resolve data quality issues prior to analysis.
Integration: Combine both sources into a single, user-friendly data model designed for analytical queries.
Scope: Focus on the latest dataset only; historization of data is not required.
Documentation: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

BI: Analytics & Reporting (Data Analytics)
ObjectiveDevelop SQL-based analytics to deliver detailed insights into:
Customer Behavior
Product Performance
Sales Trends
These insights empower stakeholders with key business metrics, enabling strategic decision-making.
For more details, refer to docs/requirements.md.

Data Architecture
The data architecture for this project follows Medallion Architecture Bronze, Silver, and Gold layers:
1.Bronze Layer: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2.Silver Layer: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3.Gold Layer: Houses business-ready data modeled into a star schema required for reporting and analytics.


Repository Structure 

data-warehouse-project/
├── datasets/                                  # Raw datasets used for the project (ERP and CRM data)
├── docs/
│   ├── etl.drawio                             # Project documentation and architecture details
│   ├── data_architecture.drawio               # Draw.io file shows all different techniques and methods of E
│   ├── data_catalog.md                        # Catalog of datasets, including field descriptions and metadat
│   ├── data_flow.drawio                       # Draw.io file for the data flow diagram
│   ├── data_models.drawio                     # Draw.io file for data models (star schema)
│   └── naming_conventions.md                  # Consistent naming guidelines for tables, columns, and files
├── scripts/
│   ├── bronze/                                # SQL scripts for ETL and transformations
│   ├── silver/                                # Scripts for extracting and loading raw data
│   └── gold/                                  # Scripts for cleaning and transforming data
│                                              # Scripts for creating analytical models
├── tests/                                     # Test scripts and quality files
├── README.md                                  # Project overview and instructions
├── LICENSE                                    # License information for the repository
├── .gitignore                                 # Files and directories to be ignored by Git
└── requirements.txt                           # Dependencies and requirements for the project


Develop SQL-based analytics to deliver detailed insights into:
**Customer Behavior**
**Product Performance**
**Sales Trends
These insights empower stakeholders with key business metrics, enabling strategic decision-making.**

## License 🪪
This project is licensed under the MIT License (LICENSE). You are free to use, modify, and share this project with proper attribution.

##About me ♀️
Hi there,I am Yetunde Afolayan, A Data Analyst and Business Strategy Analyst with experience in monitoring & evaluation, and strategic decision-making in various business projects. Skilled in business analysis, data collection, cleaning, validation, and analysis, transforming raw data into actionable business insights that drive program performance and strategic planning. 
