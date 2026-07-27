/* Create Raw sales Table  and Data loading into SQL Server */

CREATE TABLE raw.sales_orders
(
Row_ID NVARCHAR(50),
Order_ID NVARCHAR(50),
Order_Date NVARCHAR(50),
Ship_Date NVARCHAR(50),
Ship_Mode NVARCHAR(50),
Customer_ID NVARCHAR(50),
Customer_Name NVARCHAR(100),
Segment NVARCHAR(50),
Country NVARCHAR(100),
City NVARCHAR(100),
State NVARCHAR(100),
Postal_Code NVARCHAR(50),
Region NVARCHAR(50),
Product_ID NVARCHAR(50),
Category NVARCHAR(50),
Sub_Category NVARCHAR(50),
Product_Name NVARCHAR(225),
Sales NVARCHAR(50),
Quantity NVARCHAR(50),
Discount NVARCHAR(50),
Profit NVARCHAR(50)
);
GO

-- Verift table creation and data import
SELECT TOP 1000 * FROM raw.sales_orders;
