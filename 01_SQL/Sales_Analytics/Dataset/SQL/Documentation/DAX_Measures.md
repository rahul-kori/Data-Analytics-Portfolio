-- DAX Measure Development --

-- Measure Table --
Create an empty table named:
Measures
Store all DAX measures in this table to keep the model
organized.

-- KPI Measures

1. Total Sales
Business Purpose: Total revenue generated.
Total Sales = SUM(Fact_Sales[Sales])

Used By: CEO, CFO

2. Total Profit
Total Profit = SUM(Fact_Sales[Profit])

3. Total Orders
Total Orders = DISTINCTCOUNT(Fact_Sales[Order ID])

4. Total Customers
Total Customers = DISTINCTCOUNT(Fact_Sales[Customer ID])

5. Total Quantity
Total Quantity = SUM(Fact_Sales[Quantity])

6. Average Order Value
Average Order Value =
DIVIDE(
    [Total Sales],
    [Total Orders]
)

7. Profit Margin %
Profit Margin % =
DIVIDE(
    [Total Profit],
    [Total Sales]
)

-- Time Intelligence Measures --
8. Sales YTD
DAX
Sales YTD =
TOTALYTD(
    [Total Sales],
    Dim_Date[Date]
)

9. Profit YTD
DAX
Profit YTD =
TOTALYTD(
    [Total Profit],
    Dim_Date[Date]
)

10. Previous Year Sales
DAX
Previous Year Sales =
CALCULATE(
    [Total Sales],
    SAMEPERIODLASTYEAR(Dim_Date[Date])
)

11. YoY Growth %
DAX
YoY Growth % =
DIVIDE(
    [Total Sales] - [Previous Year Sales],
    [Previous Year Sales]
)

12. Previous Month Sales
DAX
Previous Month Sales =
CALCULATE(
    [Total Sales],
    DATEADD(
        Dim_Date[Date],
        -1,
        MONTH
    )
)

13. MoM Growth %
DAX
MoM Growth % =
DIVIDE(
    [Total Sales] - [Previous Month Sales],
    [Previous Month Sales]
)
