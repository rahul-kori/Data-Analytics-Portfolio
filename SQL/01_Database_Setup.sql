/* Database Environment Setup */

-- Create a dedicated database for the RetailNova analytics Project.
-- Database Name : RetailNova_Sales_Analytics_DB

-- Create Database 
CREATE DATABASE Sales_Analytics_DB;
GO
USE Sales_Analytics_DB;
GO

-- Create Database Schemas 
CREATE SCHEMA raw;
GO
CREATE SCHEMA clean;
GO
CREATE SCHEMA analytics;
GO
