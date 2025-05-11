-- 1. Sales Overview Analysis
SELECT 
    COUNT(DISTINCT `Order ID`) AS total_orders,
    SUM(Amount) AS total_revenue,
    AVG(Amount) AS avg_order_value,
    SUM(Qty) AS total_quantity
FROM sales_data
WHERE Status NOT IN ('Cancelled');

-- 2. Monthly Trend Analysis
SELECT 
    DATE_FORMAT(STR_TO_DATE(`Date`, '%m/%d/%Y'), '%Y-%m') AS sales_month,
    COUNT(DISTINCT `Order ID`) AS order_count,
    SUM(Amount) AS monthly_revenue,
    SUM(Qty) AS total_quantity
FROM sales_data
WHERE Status NOT IN ('Cancelled')
GROUP BY sales_month
ORDER BY sales_month;

-- 3. Geographical Distribution Analysis
SELECT 
    `ship-state` AS state,
    `ship-city` AS city,
    COUNT(DISTINCT `Order ID`) AS order_count,
    SUM(Amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(Amount) DESC) AS revenue_rank
FROM sales_data
WHERE Status NOT IN ('Cancelled')
GROUP BY state, city
ORDER BY total_revenue DESC
LIMIT 10;

-- 4. Product Performance Analysis
SELECT 
    Category,
    Style,
    Size,
    COUNT(DISTINCT `Order ID`) AS order_count,
    SUM(Qty) AS total_quantity,
    SUM(Amount) AS total_revenue,
    ROUND(SUM(Amount)*100.0 / (SELECT SUM(Amount) FROM sales_data WHERE Status NOT IN ('Cancelled')), 2) AS revenue_percent
FROM sales_data
WHERE Status NOT IN ('Cancelled')
GROUP BY Category, Style, Size
ORDER BY total_revenue DESC;

-- 5. Operational Efficiency Analysis
SELECT 
    `Fulfilment`,
    `ship-service-level`,
    AVG(CASE WHEN `Courier Status` = 'Shipped' THEN 1 ELSE 0 END) AS shipping_success_rate,
    AVG(Amount) AS avg_order_value,
    COUNT(DISTINCT `Order ID`) AS order_count
FROM sales_data
GROUP BY `Fulfilment`, `ship-service-level`;

-- 6. Promotion Effectiveness Analysis
SELECT 
    CASE 
        WHEN `promotion-ids` IS NOT NULL THEN 'Promotion' 
        ELSE 'Regular' 
    END AS promotion_type,
    COUNT(DISTINCT `Order ID`) AS order_count,
    SUM(Amount) AS total_revenue,
    AVG(Amount) AS avg_order_value
FROM sales_data
WHERE Status NOT IN ('Cancelled')
GROUP BY promotion_type;

-- 7. Customer Type Analysis
SELECT 
    B2B,
    `fulfilled-by`,
    COUNT(DISTINCT `Order ID`) AS order_count,
    SUM(Amount) AS total_revenue,
    AVG(Amount) AS avg_order_value
FROM sales_data
WHERE Status NOT IN ('Cancelled')
GROUP BY B2B, `fulfilled-by`;

-- 8. Cancellation Analysis
SELECT 
    Status,
    COUNT(DISTINCT `Order ID`) AS order_count,
    SUM(Amount) AS lost_revenue,
    GROUP_CONCAT(DISTINCT `ship-city`) AS affected_cities
FROM sales_data
WHERE Status IN ('Cancelled')
GROUP BY Status;

-- 9. Shipping Performance Analysis
SELECT 
    `ship-service-level`,
    `ship-state`,
    COUNT(DISTINCT `Order ID`) AS order_count,
    AVG(Amount) AS avg_order_value
FROM sales_data
WHERE Status LIKE 'Shipped%'
GROUP BY `ship-service-level`, `ship-state`;

-- 10. Inventory Turnover Analysis
SELECT 
    SKU,
    ASIN,
    SUM(Qty) AS total_sold,
    COUNT(DISTINCT `Order ID`) AS order_count,
    DENSE_RANK() OVER (ORDER BY SUM(Qty) DESC) AS sales_rank
FROM sales_data
WHERE Status NOT IN ('Cancelled')
GROUP BY SKU, ASIN
ORDER BY total_sold DESC
LIMIT 10;

-- Additional Analytical Queries
-- Order Status Distribution
SELECT Status, COUNT(*) AS OrderCount
FROM sales_data
GROUP BY Status
ORDER BY OrderCount DESC;

-- Category Revenue Breakdown
SELECT Category, SUM(Amount) AS Revenue
FROM sales_data
WHERE Status = 'Shipped'
GROUP BY Category
ORDER BY Revenue DESC;

-- Top Cities by Revenue
SELECT `ship-city`, SUM(Amount) AS Revenue
FROM sales_data
WHERE Status = 'Shipped'
GROUP BY `ship-city`
ORDER BY Revenue DESC
LIMIT 10;

-- Fulfillment Performance
SELECT `fulfilled-by`, COUNT(*) AS Orders, SUM(Amount) AS Revenue
FROM sales_data
WHERE Status = 'Shipped'
GROUP BY `fulfilled-by`
ORDER BY Revenue DESC;

-- Monthly Revenue Pattern
SELECT 
    SUBSTR(Date, 4, 2) AS Month,
    SUM(Amount) AS Revenue
FROM sales_data
WHERE Status = 'Shipped'
GROUP BY Month
ORDER BY Month;

-- B2B vs B2C Analysis
SELECT B2B, COUNT(*) AS Orders, SUM(Amount) AS Revenue
FROM sales_data
GROUP BY B2B;