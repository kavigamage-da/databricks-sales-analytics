-- 1. Total Sales and Customers
SELECT 
    ROUND(SUM(SalesAmount), 2) AS total_sales,
    COUNT(DISTINCT CustomerKey) AS total_customers
FROM fact_sales;

-- 2. Sales by Category
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
