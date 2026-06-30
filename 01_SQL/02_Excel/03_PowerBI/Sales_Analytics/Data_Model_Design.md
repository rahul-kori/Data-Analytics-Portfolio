-- Power BI Data Modeling --

-- Fact Table --

Fact_Sales
Granularity
One row = One sales transaction (order line).

Key Columns
Column : Description
Order ID : Transaction identifier
Ship Date : Shaip date
Segment : shipment type 
Order Date : Transaction date
Customer ID : Customer key
Product ID : Product key
Region : Geographic key
Sales : Revenue
Profit : Profit
Quantity : Units sold
Discount : Discount applied

-- Dimension Tables --

Dim_Date

Column
Date
Year
Quarter
Month
Month Name
Week
Day

Purpose:
Time intelligence
YoY analysis
MoM analysis
Quarterly reporting

-- Dim_Product --

Column
Product ID
Product Name
Category
Sub Category
Purpose:
Product performance
Category analysis

-- Dim_Customer --

Column
Customer ID
Customer Name
Segment

Purpose:
Customer analytics
Segmentation
Retention reporting

-- Dim_Region --

Column
Region
State
City

Purpose:
Geographic reporting
Regional comparison
Market analysis

-- Relationships --
From : To : Cardinality
Dim_Date : Fact_Sales : One-to-Many
Dim_Product : Fact_Sales : One-to-Many
Dim_Customer : Fact_Sales : One-to-Many
Dim_Region : Fact_Sales : One-to-Many

-- Relationship Settings --
Cross-filter direction: Single
Active relationships only
No many-to-many relationships
Avoid bidirectional filtering unless a specific business requirement exists

