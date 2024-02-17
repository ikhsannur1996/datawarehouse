-- Sample Store Procedure
CREATE OR REPLACE PROCEDURE dwh.generate_dwh()
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Step 1: Truncate and Insert into stg
    -- Description: Clear the staging table and populate it with data from the source table.
    TRUNCATE TABLE stg.stg_sales_transaction;
    INSERT INTO stg.stg_sales_transaction 
    SELECT * FROM public.sales_transaction;
	
	-- Step 2: Insert into dim_products
    -- Description: Insert new product data into the product dimension if they don't already exist.
    INSERT INTO dwh.dim_products
        (product_id, product_name, product_category, product_price)
    SELECT
        src.product_id, src.product_name, src.product_category, src.product_price
    FROM
        stg.stg_sales_transaction AS src
    LEFT JOIN dwh.dim_products AS dim ON
        COALESCE(dim.product_id, 0) = COALESCE(src.product_id, 0)
    WHERE dim.product_id IS NULL;

    -- Step 3: Insert into dim_customers
    -- Description: Insert new customer data into the customer dimension if they don't already exist.
    INSERT INTO dwh.dim_customers
        (customer_id, customer_name, customer_address, customer_phone, customer_email)
    SELECT
        src.customer_id, src.customer_name, src.customer_address, src.customer_phone, src.customer_email
    FROM
        stg.stg_sales_transaction AS src
    LEFT JOIN dwh.dim_customers AS dim ON
        COALESCE(dim.customer_id, 0) = COALESCE(src.customer_id, 0)
    WHERE dim.customer_id IS NULL;

    -- Step 4: Insert into fact
    -- Description: Insert new sales transactions into the fact table if they don't already exist.
    INSERT INTO dwh.fact_sales_transaction
        (transaction_id, customer_id, product_id, sale_date, quantity, sales_amount)
    SELECT
        src.transaction_id, src.customer_id, src.product_id, src.sale_date, src.quantity, src.sales_amount
    FROM
        stg.stg_sales_transaction AS src
    LEFT JOIN dwh.fact_sales_transaction AS fact ON
        COALESCE(fact.transaction_id, 0) = COALESCE(src.transaction_id, 0) AND
        COALESCE(fact.customer_id, 0) = COALESCE(src.customer_id, 0) AND
        COALESCE(fact.product_id, 0) = COALESCE(src.product_id, 0) AND
        COALESCE(fact.sale_date, current_date) = COALESCE(src.sale_date, current_date) AND
        COALESCE(fact.quantity, 0) = COALESCE(src.quantity, 0) AND
        COALESCE(fact.sales_amount, 0) = COALESCE(src.sales_amount, 0)
    WHERE fact.transaction_id IS NULL;

    -- Step 5: Truncate and Insert into dm_sales_transaction
    -- Description: Populate the data mart with the latest sales transactions.
    TRUNCATE TABLE dm.dm_sales_transaction;
    INSERT INTO dm.dm_sales_transaction 
        (transaction_id, sale_date, customer_name, product_name, quantity, sales_amount)
    SELECT 
        f.transaction_id, f.sale_date, c.customer_name, p.product_name, f.quantity, f.sales_amount
    FROM 
        dwh.fact_sales_transaction AS f
    LEFT JOIN 
        dwh.dim_products AS p ON f.product_id = p.product_id
    LEFT JOIN 
        dwh.dim_customers AS c ON f.customer_id = c.customer_id;

END;
$procedure$;


-- Inserting new data into public.sales_transaction table
INSERT INTO public.sales_transaction(
    transaction_id, sale_date, customer_id, customer_name, customer_address, customer_phone, customer_email, product_id, product_name, product_category, product_price, quantity, sales_amount)
VALUES 
    (32, '2023-11-11', 1006, 'Mohamad Ikhsan Nurulloh', 'Jakarta', '0833231431', 'ikhsan@gmail.com', 2006, 'Laptop', 'Laptop', 1500, 2, 3000);

-- Calling the stored procedure to generate the data warehouse
CALL dwh.generate_dwh();
