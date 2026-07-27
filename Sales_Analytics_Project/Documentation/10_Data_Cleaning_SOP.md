Data Cleaning SOP (Standard Operating Procedure)

Objective
The purpose of Data Cleaning is not to make the data look clean. It is to ensure the dataset is accurate, consistent, reliable, and ready for business analysis while preserving data integrity.

Every cleaning action must have:
•	The business problem
•	The business impact
•	The cleaning logic
•	The SQL implementation
•	The validation method
This mirrors how production analytics teams document data preparation.

Data Cleaning SOP
Project Information
Field		Value
Project		SQL Flagship Sales Analytics
Database	Sales_Analytics_DB
Table		sales_orders
Owner		Data Analyst
Version		1.0

Data Cleaning Workflow
Raw Data
    ↓
Identify Data Quality Issues
    ↓
Evaluate Business Impact
    ↓
Apply Cleaning Rules
    ↓
Validate Results
    ↓
Business Ready Dataset

Cleaning Rule 1: Duplicate Records
Business Problem
Duplicate transactions inflate revenue, profit, and order counts.
Business Impact
•	Incorrect KPIs
•	Misleading dashboards
•	Poor business decisions

Cleaning Logic
•	Verify duplicate row_id values.
•	If duplicates exist, investigate the source before deleting records.
•	Never delete data without documenting the reason.

SQL Validation
SELECT
    row_id,
    COUNT(*) AS duplicate_count
FROM sales_orders
GROUP BY row_id
HAVING COUNT(*) > 1;

Expected Action
Result	Action
No duplicates	No action required
Duplicates found	Investigate before removal

Cleaning Rule 2: Missing Values
Business Problem
Missing business keys prevent accurate reporting.
Business Impact
•	Incomplete customer analysis
•	Missing product insights
•	Incorrect regional reporting
Critical Columns
•	Customer ID
•	Product ID
•	Order Date
•	Sales
•	Profit

SQL Validation
SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_nulls,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_nulls,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS sales_nulls,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS profit_nulls
FROM sales_orders;

Cleaning Decision
•	Investigate missing values.
•	Do not replace values without business justification.

Cleaning Rule 3: Data Type Standardization
Business Problem
Incorrect data types can lead to calculation errors and failed queries.
Required Data Types
Column		Required Type
Order Date	DATE
Ship Date	DATE
Sales		DECIMAL
Profit		DECIMAL
Quantity	INT
Discount	DECIMAL
Cleaning Decision
Convert only after validating that all values can be safely converted.

Cleaning Rule 4: Date Validation
Business Problem
Invalid dates distort trend analysis.
Validation Rule
Order Date ≤ Ship Date

SQL Validation
SELECT *
FROM sales_orders
WHERE order_date > ship_date;
Cleaning Decision
Investigate invalid records before making corrections.

Cleaning Rule 5: Numeric Value Validation
Business Rules
Field	Rule
Sales	≥ 0
Quantity	> 0
Discount	Between 0 and 1
Profit	Positive or Negative allowed

SQL Example
SELECT *
FROM sales_orders
WHERE sales < 0
   OR quantity <= 0
   OR discount < 0
   OR discount > 1;

Cleaning Rule 6: Text Standardization
Business Problem
Inconsistent text values create duplicate categories.
Validation
Check for inconsistent values in:
•	Region
•	Category
•	Sub-Category
•	Segment
•	Ship Mode
Cleaning Decision
Standardize formatting while preserving the original business meaning.


Cleaning Rule 7: Business Key Validation
Validate:
•	Customer ID
•	Product ID
•	Order ID
These identifiers must remain unchanged unless a verified data issue exists.

Cleaning Audit Log
Every cleaning action should be recorded.
Step	Issue			Business Impact		Cleaning Action	Validation
1	Duplicate records	Double-counted sales	Investigated	Passed
2	Missing values		Incomplete reporting	Reviewed	Passed
3	Invalid data types	Query failures		Standardized	Passed
4	Invalid dates		Incorrect trends	Validated	Passed
5	Numeric validation	Incorrect KPIs		Verified	Passed
6	Text consistency	Duplicate categories	Standardized	Passed

Before vs After Validation
Metric		Before					After
Duplicate 	Records	Measured during profiling	Resolved if required
Missing Values	Documented				Addressed where appropriate
Invalid Dates	Identified				Corrected if valid business logic exists
Data Types	Reviewed				Standardized
Business 	Rule Violations	Logged			Resolved or documented

