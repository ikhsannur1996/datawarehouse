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
    INSERT INTO dwh.dim_products (product_id, product_name, product_category, product_price)
	SELECT product_id, product_name, product_category, product_price
	FROM (select * from (
		SELECT
        src.product_id, src.product_name, src.product_category, src.product_price,
        ROW_NUMBER() OVER (PARTITION BY src.product_id ORDER BY src.created_at DESC) AS data_update
        FROM 
            stg.stg_sales_transaction as src) sub_query
        where data_update=1) sub_query
	ON CONFLICT (product_id) DO UPDATE SET product_name = EXCLUDED.product_name, product_category = EXCLUDED.product_category, product_price = EXCLUDED.product_price, created_at =  CURRENT_TIMESTAMP;

    -- Step 3: Insert into dim_customers
    -- Description: Insert new customer data into the customer dimension if they don't already exist.
    INSERT INTO dwh.dim_customers (customer_id, customer_name, customer_address, customer_phone, customer_email)
	SELECT customer_id, customer_name, customer_address, customer_phone, customer_email
	FROM (select * from (
		SELECT
        src.customer_id, src.customer_name, src.customer_address, src.customer_phone, src.customer_email,
        ROW_NUMBER() OVER (PARTITION BY src.customer_id ORDER BY src.created_at DESC) AS data_update
        FROM 
            stg.stg_sales_transaction as src) sub_query
        where data_update=1) sub_query
	ON CONFLICT (customer_id) DO UPDATE SET customer_name = EXCLUDED.customer_name, customer_address = EXCLUDED.customer_address, customer_phone = EXCLUDED.customer_phone, customer_email = EXCLUDED.customer_email, created_at =  CURRENT_TIMESTAMP;

    -- Step 4: Insert into fact
    -- Description: Insert new sales transactions into the fact table if they don't already exist.
    INSERT INTO dwh.fact_sales_transaction
        (transaction_id, customer_id, product_id, sales_date, quantity, sales_amount)
	SELECT
		src.transaction_id, src.customer_id, src.product_id, src.sales_date, src.quantity, src.sales_amount
	FROM
		stg.stg_sales_transaction AS src 
	WHERE NOT EXISTS (
		SELECT 1
		FROM dwh.fact_sales_transaction AS fact
		WHERE 
			COALESCE(fact.transaction_id, 0) = COALESCE(src.transaction_id, 0) AND
			COALESCE(fact.customer_id, 0) = COALESCE(src.customer_id, 0) AND
			COALESCE(fact.product_id, 0) = COALESCE(src.product_id, 0) AND
			COALESCE(fact.sales_date, current_date) = COALESCE(src.sales_date, current_date) AND
			COALESCE(fact.quantity, 0) = COALESCE(src.quantity, 0) AND
			COALESCE(fact.sales_amount, 0) = COALESCE(src.sales_amount, 0)
	);


    -- Step 5: Truncate and Insert into dm_sales_transaction
    -- Description: Populate the data mart with the latest sales transactions.
    TRUNCATE TABLE dm.dm_sales_transaction;
    INSERT INTO dm.dm_sales_transaction 
        (transaction_id, sales_date, customer_name, product_name, quantity, sales_amount)
    SELECT
        transaction_id, sales_date, customer_name, product_name, quantity, sales_amount
    FROM (
        SELECT 
            f.transaction_id, 
            f.sales_date, 
            c.customer_name, 
            p.product_name, 
            f.quantity, 
            f.quantity * p.product_price as sales_amount,
            ROW_NUMBER() OVER (PARTITION BY f.transaction_id ORDER BY f.created_at DESC) AS data_update
        FROM 
            dwh.fact_sales_transaction AS f
        LEFT JOIN 
            dwh.dim_products AS p ON f.product_id = p.product_id
        LEFT JOIN 
            dwh.dim_customers AS c ON f.customer_id = c.customer_id
    ) AS subquery
    WHERE data_update = 1 and transaction_id IN (SELECT distinct transaction_id from stg.stg_sales_transaction);
    
END;
$procedure$;


-- Inserting new data into public.sales_transaction table
INSERT INTO public.sales_transaction(
    transaction_id, sales_date, customer_id, customer_name, customer_address, customer_phone, customer_email, product_id, product_name, product_category, product_price, quantity, sales_amount)
VALUES 
    (32, '2023-11-11', 1006, 'Mohamad Ikhsan Nurulloh', 'Jakarta', '0833231431', 'ikhsan@gmail.com', 2006, 'Laptop', 'Laptop', 1500, 2, 3000);

-- Calling the stored procedure to generate the data warehouse
CALL dwh.generate_dwh();

-- Update new data into public.sales_transaction table
UPDATE public.sales_transaction
SET 
    sales_date = '2023-11-12',
    quantity = 10,
    created_at =  CURRENT_TIMESTAMP
WHERE transaction_id = 32;
