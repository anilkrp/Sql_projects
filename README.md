# Walmart Sales Data Analysis

This project involves analyzing Walmart sales data using SQL to derive insights and perform data transformations. The provided SQL file contains scripts used for data manipulation and analysis.

## Data Overview

The dataset consists of Walmart sales records with the following features:

- `Invoice ID`: Unique identifier for each invoice.
- `Branch`: Branch of the store (A, B, or C).
- `City`: City where the store is located.
- `Customer type`: Type of customer (Member or Normal).
- `Gender`: Gender of the customer.
- `Product line`: Category of the product sold.
- `Unit price`: Price per unit of the product.
- `Quantity`: Quantity of the product sold.
- `Tax 5%`: Tax amount for the sale.
- `Total`: Total amount of the sale including tax.
- `Date`: Date of the sale.
- `Time`: Time of the sale.
- `Payment`: Payment method used by the customer.
- `cogs`: Cost of goods sold.
- `gross margin percentage`: Gross margin percentage.
- `gross income`: Gross income from the sale.
- `Rating`: Customer rating of the store.

## SQL Scripts Overview

### Adding New Columns

- `time_of_day`: Categorizes the time of the sale into 'Morning', 'Afternoon', and 'Evening'.
- `product_category`: Categorizes products based on the total sales amount into 'Good' and 'Bad'.

### Extracting Day and Month Names

Extracts the day and month names from the `date` column for further analysis.

## How to Use

1. Ensure you have a PostgreSQL database set up.
2. Import the `sales` table into your database.
3. Run the provided SQL scripts to add columns and perform data analysis.

## File Information

The provided SQL file `Walmart.session.sql` contains all the necessary SQL scripts used in this analysis. Ensure you have the correct database setup to run these scripts.
