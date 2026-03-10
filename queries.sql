-- ================================================
-- Databricks Sales Analytics — SQL Queries
-- Dataset: Bike Company Sales Data
-- Tool: Databricks SQL Editor
-- Note: Queries written based on bike sales dataset
-- ================================================

-- 1. Total Sales and Total Customers
SELECT 
    ROUND(SUM(SalesAmount), 2) AS total_sales,
    COUNT(DISTINCT CustomerKey) AS total_customers
FROM fact_sales;

-- 2. Sales by Product Category
SELECT 
    p.Category,
    ROUND(SUM(f.SalesAmount), 2) AS total_sales
FROM fact_sales f
JOIN dim_products p ON f.ProductKey = p.ProductKey
GROUP BY p.Category
ORDER BY total_sales DESC;

-- 3. Monthly Sales Trend
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS month,
    ROUND(SUM(SalesAmount), 2) AS monthly_sales
FROM fact_sales
GROUP BY month
ORDER BY month;

-- 4. Top 10 Customers by Sales
SELECT 
    c.FirstName,
    c.LastName,
    ROUND(SUM(f.SalesAmount), 2) AS total_sales
FROM fact_sales f
JOIN dim_customers c ON f.CustomerKey = c.CustomerKey
GROUP BY c.FirstName, c.LastName
ORDER BY total_sales DESC
LIMIT 10;

-- 5. Peak Sales Month
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS month,
    ROUND(SUM(SalesAmount), 2) AS monthly_sales
FROM fact_sales
GROUP BY month
ORDER BY monthly_sales DESC
LIMIT 1;

-- 6. Bikes vs Other Categories (% of Sales)
SELECT 
    p.Category,
    ROUND(SUM(f.SalesAmount), 2) AS total_sales,
    ROUND(SUM(f.SalesAmount) * 100.0 / SUM(SUM(f.SalesAmount)) OVER (), 2) AS pct_of_total
FROM fact_sales f
JOIN dim_products p ON f.ProductKey = p.ProductKey
GROUP BY p.Category
ORDER BY total_sales DESC;

-- 7. Sales by Customer Country
SELECT 
    c.Country,
    ROUND(SUM(f.SalesAmount), 2) AS total_sales,
    COUNT(DISTINCT f.CustomerKey) AS total_customers
FROM fact_sales f
JOIN dim_customers c ON f.CustomerKey = c.CustomerKey
GROUP BY c.Country
ORDER BY total_sales DESC;
