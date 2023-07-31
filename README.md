# Creating Staging, Data Warehouse, and Data Mart

## 1. Staging Table (stg.stg_sales_transaction)

The staging table `stg.stg_sales_transaction` is used to store raw data coming from the source system without any transformation. It contains information about sales transactions, including details about customers, products, and sales amounts. The table has the following columns:

- `transaction_id`: The identifier for each sales transaction (integer).
- `sale_date`: The date of the sales transaction (date).
- `customer_id`: The identifier of the customer associated with the transaction (integer).
- `customer_name`: The name of the customer (varchar).
- `customer_address`: The address of the customer (varchar).
- `customer_phone`: The phone number of the customer (varchar).
- `customer_email`: The email address of the customer (varchar).
- `product_id`: The identifier of the product associated with the transaction (integer).
- `product_name`: The name of the product (varchar).
- `product_category`: The category of the product (varchar).
- `product_price`: The price of the product (numeric).
- `quantity`: The quantity of the product sold (integer).
- `sales_amount`: The total sales amount for the transaction (numeric).

## 2. Data Warehouse Tables (dwh.dim_customers, dwh.dim_products, dwh.fact_sales_transaction)

### a. dwh.dim_customers

The `dwh.dim_customers` table serves as a dimension table to store unique customer information. It contains the following columns:

- `customer_id`: The identifier for each customer (integer) - Primary Key.
- `customer_name`: The name of the customer (varchar).
- `customer_address`: The address of the customer (varchar).
- `customer_phone`: The phone number of the customer (varchar).
- `customer_email`: The email address of the customer (varchar).

### b. dwh.dim_products

The `dwh.dim_products` table is another dimension table that stores unique product information. It contains the following columns:

- `product_id`: The identifier for each product (integer) - Primary Key.
- `product_name`: The name of the product (varchar).
- `product_category`: The category of the product (varchar).
- `product_price`: The price of the product (numeric).

### c. dwh.fact_sales_transaction

The `dwh.fact_sales_transaction` table serves as the central fact table that stores aggregated and related information about sales transactions. It contains the following columns:

- `transaction_id`: The identifier for each sales transaction (integer) - Primary Key.
- `customer_id`: The identifier of the customer associated with the transaction (integer) - Foreign Key to `dwh.dim_customers`.
- `product_id`: The identifier of the product associated with the transaction (integer) - Foreign Key to `dwh.dim_products`.
- `sale_date`: The date of the sales transaction (date).
- `quantity`: The quantity of the product sold in the transaction (integer).
- `sales_amount`: The total sales amount for the transaction (numeric).

## 3. Data Mart Table (dm.dm_sales_transaction)

The `dm.dm_sales_transaction` table represents a data mart that stores denormalized and pre-aggregated data for sales transactions. It contains the following columns:

- `transaction_id`: The identifier for each sales transaction (integer).
- `sale_date`: The date of the sales transaction (date).
- `customer_name`: The name of the customer associated with the transaction (varchar).
- `product_name`: The name of the product associated with the transaction (varchar).
- `quantity`: The quantity of the product sold in the transaction (integer).
- `sales_amount`: The total sales amount for the transaction (numeric).

The data mart table `dm.dm_sales_transaction` is designed for optimized querying and reporting purposes, providing a denormalized view of sales transactions with key information from the dimension tables (`dwh.dim_customers` and `dwh.dim_products`).

## Conclusion

In this document, we have created three tables - a staging table (`stg.stg_sales_transaction`) to store raw data from the source system, data warehouse tables (`dwh.dim_customers`, `dwh.dim_products`, and `dwh.fact_sales_transaction`) to store dimension and fact data, and a data mart table (`dm.dm_sales_transaction`) to provide a denormalized view of sales transactions for efficient querying and reporting. This data pipeline allows for efficient data storage, analysis, and reporting of sales transaction information.
