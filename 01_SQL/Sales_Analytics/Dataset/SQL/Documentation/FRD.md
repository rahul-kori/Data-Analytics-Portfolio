-- Functional Requirements Document (FRD) --

-- Document Information --
Field : Value
Project : Sales Analytics
Company : RetailNova
Document : Functional Requirements Document (FRD)
Version : 1.0
Status : Approved for Development

-- Functional Objective --
Develop a SQL reporting layer that produces validated, reusable datasets for executive dashboards and business reporting.

-- Data Source --
Item : Value 
Dataset : Sample Superstore
Refresh Type : Manual (Portfolio Simulation)
Target Database : PostgreSQL / MySQL / SQL Server (queries written to ANSI SQL where possible)

-- Reporting Frequency --
Report : Frequency
Executive Dashboard : Daily
Sales Dashboard : Daily
Product Performance : Weekly
Customer Analysis : Weekly
Regional Performance : Monthly
KPI Summary : Daily

-- Business Rules --
The SQL layer must follow these rules:
Count only valid sales transactions.
Exclude records with null Order ID.
Sales and Profit must be numeric.
Order Date cannot be after Ship Date.
Duplicate transactions must be identified before reporting.
Categories and Regions must use standardized values.
KPI calculations must use cleaned data only.

-- Required SQL Outputs --
The reporting layer must produce:

Executive KPI Summary
Total Sales
Total Profit
Total Orders
Total Customers
Average Order Value
Profit Margin %

Product Report
Sales by Product
Profit by Product
Quantity Sold
Top 10 Products
Bottom 10 Products

Customer Report
Customer Sales
Customer Profit
Order Count
Average Order Value
Top Customers

Regional Report
Sales by Region
Profit by Region
Orders by Region

Time Report
Monthly Sales
Quarterly Sales
Yearly Sales
Month-over-Month Growth (Intermediate/Advanced)

-- Data Validation Requirements --
Before any KPI is calculated, SQL must validate:

Total row count
Null values
Duplicate rows
Primary key uniqueness (Order ID + Product ID)
Data types
Invalid dates
Negative sales (if unexpected)
Category consistency
Region consistency

-- Performance Requirements --
Avoid SELECT * in production queries.
Use meaningful table aliases.
Use CTEs when they improve readability.
Keep queries modular and reusable.
Write SQL suitable for dashboard refreshes.

-- Deliverables --
01_Database_Setup.sql
02_Data_Validation.sql
03_Data_Cleaning.sql
04_EDA.sql
05_KPI_Analysis.sql
06_Product_Analysis.sql
07_Customer_Analysis.sql
08_Regional_Analysis.sql
09_Time_Analysis.sql
10_Final_Executive_Report.sql

-- Acceptance Criteria --
The FRD is considered complete when:
All required reports are defined.
Business rules are documented.
Validation requirements are identified.
SQL outputs align with stakeholder needs.
Reporting frequency is documented.
