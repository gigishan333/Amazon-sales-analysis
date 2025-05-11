# Amazon-sales-analysis Project 🚀
Amazon Sales Insight Project using SQLite and Tableau

![SQLite](https://img.shields.io/badge/SQLite-07405E?style=for-the-badge&logo=sqlite&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=for-the-badge&logo=Tableau&logoColor=white)

## 📌 Project Overview
This analytics project provides comprehensive insights into Amazon's 2022 sales performance through SQL analysis and Tableau visualizations. The analysis focuses on sales patterns, geographical distribution, product performance, and operational efficiency.

## 🔥 Key Features
- **10+ Analytical Dimensions**: From sales trends to inventory turnover
- **Cancellation Insights**: Identify lost revenue opportunities
- **Promotion Analysis**: Measure campaign effectiveness
- **B2B vs B2C Comparison**: Understand different customer segments
- **Operational Metrics**: Shipping performance and fulfillment analysis

## 🛠 Tech Stack
- **Database**: SQLite (Lightweight, serverless relational database)
- **Visualization**: Tableau Public (Interactive dashboard creation)
- **Data Source**: Amazon Sale Report 2022 (5000+ transactions)

## 📂 Dataset Overview
- **Time Period**: January - December 2022
- **Key Attributes**:
  - Order metadata (ID, dates, status)
  - Financials (Amount, quantity)
  - Product details (Category, Style, SKU)
  - Logistics (Fulfillment, shipping details)
  - Customer type (B2B flag)

⚠️ **Note**: Excludes cancelled orders from core analysis

## 🔍 SQL Analysis Highlights
### Core Queries
1. **Sales Overview** - Key metrics aggregation
2. **Monthly Trends** - YoY/MoM revenue patterns
3. **Geospatial Analysis** - Top 10 cities/states by revenue
4. **Product Breakdown** - Category performance analysis
5. **Shipping Efficiency** - Service level comparisons

### Advanced Analysis
```sql
-- Inventory Turnover (Top 10 SKUs)
SELECT SKU, SUM(Qty) AS total_sold 
FROM sales_data 
GROUP BY SKU 
ORDER BY total_sold DESC 
LIMIT 10;

-- Promotion Impact Analysis
SELECT 
    CASE WHEN `promotion-ids` IS NOT NULL THEN 1 ELSE 0 END AS has_promotion,
    AVG(Amount) AS avg_order_value
FROM sales_data
GROUP BY has_promotion;
