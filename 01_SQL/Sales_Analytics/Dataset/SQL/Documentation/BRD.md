-- Business Requirements Document (BRD) --

-- Document Information --
Field : Value
Project : Sales Analytics
Company : RetailNova
Industry : Retail & E-commerce
Prepared By : Data Analyst
Version : 1.0
Status : Approved for Development

-- Business Background --
RetailNova operates across multiple regions, selling Electronics, Furniture, and Office Supplies through online and offline channels.
Leadership currently receives fragmented reports from different departments, making it difficult to monitor sales performance consistently.
The Analytics team has been asked to build a centralized SQL reporting layer that supports management dashboards and business decision-making.

-- Business Problem --
Current reporting challenges include:
Revenue trends are not monitored consistently.
Regional performance is difficult to compare.
Top-performing products are not clearly identified.
Customer purchasing patterns are not analyzed.
Profitability by category is unclear.
Reporting is manual and time-consuming.
Different departments use inconsistent metrics.

-- Business Objective --
Develop a production-ready SQL reporting solution that enables stakeholders to:
Monitor sales performance.
Evaluate profitability.
Identify top-performing products.
Track customer purchasing behavior.
Compare regional performance.
Support executive decision-making through standardized KPIs.

-- Project Scope --
In Scope
 Sales Analysis
 Product Analysis
 Customer Analysis
 Regional Analysis
 Category Analysis
 Time-based Analysis
 KPI Development
 Executive Reporting Dataset

Out of Scope
 Demand Forecasting
 Machine Learning
 Inventory Optimization
 Marketing Attribution
 Customer Lifetime Value Modeling
 Real-time Streaming Analytics

-- Stakeholders --
CEO : Overall business performance
CFO : Revenue, Profit, Margin
Sales Director : Sales trends and targets
Regional Managers : Regional performance
Operations Manager : Order volume
Analytics Manager : Standardized reporting

-- Business Questions --
Revenue
Total Revenue
Monthly Revenue
Quarterly Revenue
Annual Revenue

Orders
Total Orders
Orders by Region
Orders by Category
Orders by Segment

Customers
Top Customers
Repeat Customers
Customer Distribution

Products
Top Selling Products
Lowest Selling Products
Highest Profit Products

Geography
Sales by Region
Sales by State
Profit by Region

Time
Monthly Trend
Quarterly Trend
Yearly Trend

-- KPI Definitions --
KPI : Business Definition
Total Sales : Total sales amount
Total Profit : Total business profit
Total Orders : Number of unique orders
Average Order Value : Sales ÷ Orders
Profit Margin % : Profit ÷ Sales × 100
Quantity Sold : Total units sold
Top Product : Highest sales product
Top Customer :Highest revenue customer

-- Success Criteria --
The project will be considered successful if it delivers:
Accurate KPI calculations.
Standardized SQL queries.
Clean and validated data.
Executive-ready reporting datasets.
Documentation suitable for handover.
Queries that support dashboard development.

-- Assumptions --
Sales transactions are complete.
Product IDs uniquely identify products.
Order IDs are unique.
Dates are valid.
Revenue values are stored correctly.
Profit values are calculated correctly.

-- Risks --
Risk : Mitigation
Missing values : Data validation and cleaning
Duplicate records : Duplicate detection queries
Invalid dates : Date validation
Incorrect data types : Data type checks
Inconsistent category names : Standardization during cleaning

-- Deliverables --
Business Requirements Document (BRD)
Functional Requirements Document (FRD)
Data Validation Report
Data Cleaning Report
SQL Scripts
KPI Documentation
Executive Reporting Dataset
Power BI Dashboard
README
Executive Summary

-- Acceptance Criteria --
The Analytics Manager will approve the project when:
Business questions are addressed.
KPIs are correctly calculated.
SQL scripts are reusable.
Documentation is complete.
Data quality issues are resolved.
Dashboard requirements are satisfied.
