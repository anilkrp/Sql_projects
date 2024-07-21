# Walmart Sales Data Analysis

This project involves analyzing Walmart sales data using SQL to derive insights and perform data transformations. The provided SQL file contains various SQL scripts used for data manipulation and analysis.

## Table of Contents

- [Project Description](#project-description)
- [Data Overview](#data-overview)
- [SQL Scripts](#sql-scripts)
- [Data Analysis](#data-analysis)
- [Results](#results)
- [Conclusion](#conclusion)
- [How to Use](#how-to-use)
- [File Information](#file-information)

## Project Description

The goal of this project is to analyze the sales data of Walmart to understand sales patterns, categorize products, and derive meaningful insights from the data. This involves creating new columns, updating existing data, and performing various SQL queries to analyze the data.

## Data Overview

The data used in this project consists of Walmart sales records. The main table, `sales`, includes the following columns:

- `date`: The date of the sale.
- `time`: The time of the sale.
- `total`: The total amount of the sale.
- `product_category`: The category of the product sold (added during the analysis).

## SQL Scripts

### Adding New Columns

We added a new column `time_of_day` to categorize the time of the sale into 'Morning', 'Afternoon', and 'Evening':

```sql
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
    CASE 
        WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        ELSE 'Evening'
    END
);
