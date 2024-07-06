-- Check if the schema exists, if not, create it
DO
$$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.schemata
        WHERE schema_name = 'stg'
    ) THEN
        CREATE SCHEMA stg;
    END IF;
END
$$;

DO
$$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.schemata
        WHERE schema_name = 'dwh'
    ) THEN
        CREATE SCHEMA dwh;
    END IF;
END
$$;

DO
$$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.schemata
        WHERE schema_name = 'dm'
    ) THEN
        CREATE SCHEMA dm;
    END IF;
END
$$;

-- public.sales_transaction definition

-- Drop table

-- DROP TABLE public.sales_transaction;

CREATE TABLE public.sales_transaction (
	transaction_id int4 NULL,
	sales_date date NULL,
	customer_id int4 NULL,
	customer_name varchar(100) NULL,
	customer_address varchar(200) NULL,
	customer_phone varchar(20) NULL,
	customer_email varchar(100) NULL,
	product_id int4 NULL,
	product_name varchar(100) NULL,
	product_category varchar(50) NULL,
	product_price numeric(10, 2) NULL,
	quantity int4 NULL,
	sales_amount numeric NULL
);


INSERT INTO public.sales_transaction (transaction_id,sales_date,customer_id,customer_name,customer_address,customer_phone,customer_email,product_id,product_name,product_category,product_price,quantity,sales_amount) VALUES
	 (1,'2023-07-05',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2003,'Jeans','Apparel',40.00,2,80.00),
	 (2,'2023-07-05',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2001,'Shirt','Apparel',25.00,1,25.00),
	 (3,'2023-07-06',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2004,'Watch','Accessories',100.00,3,300.00),
	 (4,'2023-07-06',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (5,'2023-07-07',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2003,'Jeans','Apparel',40.00,1,40.00),
	 (6,'2023-07-08',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2001,'Shirt','Apparel',25.00,4,100.00),
	 (7,'2023-07-08',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (8,'2023-07-09',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2004,'Watch','Accessories',100.00,1,100.00),
	 (9,'2023-07-09',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2001,'Shirt','Apparel',25.00,3,75.00),
	 (10,'2023-07-10',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2003,'Jeans','Apparel',40.00,2,80.00),
	 (11,'2023-07-10',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (12,'2023-07-11',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2004,'Watch','Accessories',100.00,1,100.00),
	 (13,'2023-07-11',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2003,'Jeans','Apparel',40.00,3,120.00),
	 (14,'2023-07-12',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2001,'Shirt','Apparel',25.00,1,25.00),
	 (15,'2023-07-12',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (16,'2023-07-13',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2004,'Watch','Accessories',100.00,2,200.00),
	 (17,'2023-07-13',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2003,'Jeans','Apparel',40.00,1,40.00),
	 (18,'2023-07-14',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2001,'Shirt','Apparel',25.00,3,75.00),
	 (19,'2023-07-14',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (20,'2023-07-15',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2004,'Watch','Accessories',100.00,1,100.00),
	 (21,'2023-07-15',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2003,'Jeans','Apparel',40.00,2,80.00),
	 (22,'2023-07-16',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2001,'Shirt','Apparel',25.00,1,25.00),
	 (23,'2023-07-16',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (24,'2023-07-17',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2004,'Watch','Accessories',100.00,3,300.00),
	 (25,'2023-07-17',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2003,'Jeans','Apparel',40.00,1,40.00),
	 (26,'2023-07-18',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (27,'2023-07-18',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2004,'Watch','Accessories',100.00,1,100.00),
	 (28,'2023-07-19',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2001,'Shirt','Apparel',25.00,2,50.00),
	 (29,'2023-07-19',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2003,'Jeans','Apparel',40.00,3,120.00),
	 (30,'2023-07-20',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2002,'Shoes','Footwear',50.00,1,50.00);



-- stg.stg_sales_transaction definition

-- Drop table

-- DROP TABLE stg.stg_sales_transaction;

CREATE TABLE stg.stg_sales_transaction (
	transaction_id int4 NULL,
	sales_date date NULL,
	customer_id int4 NULL,
	customer_name varchar(100) NULL,
	customer_address varchar(200) NULL,
	customer_phone varchar(20) NULL,
	customer_email varchar(100) NULL,
	product_id int4 NULL,
	product_name varchar(100) NULL,
	product_category varchar(50) NULL,
	product_price numeric(10, 2) NULL,
	quantity int4 NULL,
	sales_amount numeric NULL
);


INSERT INTO stg.stg_sales_transaction (transaction_id,sales_date,customer_id,customer_name,customer_address,customer_phone,customer_email,product_id,product_name,product_category,product_price,quantity,sales_amount) VALUES
	 (1,'2023-07-05',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2003,'Jeans','Apparel',40.00,2,80.00),
	 (2,'2023-07-05',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2001,'Shirt','Apparel',25.00,1,25.00),
	 (3,'2023-07-06',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2004,'Watch','Accessories',100.00,3,300.00),
	 (4,'2023-07-06',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (5,'2023-07-07',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2003,'Jeans','Apparel',40.00,1,40.00),
	 (6,'2023-07-08',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2001,'Shirt','Apparel',25.00,4,100.00),
	 (7,'2023-07-08',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (8,'2023-07-09',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2004,'Watch','Accessories',100.00,1,100.00),
	 (9,'2023-07-09',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2001,'Shirt','Apparel',25.00,3,75.00),
	 (10,'2023-07-10',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2003,'Jeans','Apparel',40.00,2,80.00),
	 (11,'2023-07-10',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (12,'2023-07-11',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2004,'Watch','Accessories',100.00,1,100.00),
	 (13,'2023-07-11',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2003,'Jeans','Apparel',40.00,3,120.00),
	 (14,'2023-07-12',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2001,'Shirt','Apparel',25.00,1,25.00),
	 (15,'2023-07-12',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (16,'2023-07-13',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2004,'Watch','Accessories',100.00,2,200.00),
	 (17,'2023-07-13',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2003,'Jeans','Apparel',40.00,1,40.00),
	 (18,'2023-07-14',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2001,'Shirt','Apparel',25.00,3,75.00),
	 (19,'2023-07-14',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (20,'2023-07-15',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2004,'Watch','Accessories',100.00,1,100.00),
	 (21,'2023-07-15',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2003,'Jeans','Apparel',40.00,2,80.00),
	 (22,'2023-07-16',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2001,'Shirt','Apparel',25.00,1,25.00),
	 (23,'2023-07-16',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (24,'2023-07-17',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2004,'Watch','Accessories',100.00,3,300.00),
	 (25,'2023-07-17',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2003,'Jeans','Apparel',40.00,1,40.00),
	 (26,'2023-07-18',1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com',2002,'Shoes','Footwear',50.00,2,100.00),
	 (27,'2023-07-18',1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com',2004,'Watch','Accessories',100.00,1,100.00),
	 (28,'2023-07-19',1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com',2001,'Shirt','Apparel',25.00,2,50.00),
	 (29,'2023-07-19',1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com',2003,'Jeans','Apparel',40.00,3,120.00),
	 (30,'2023-07-20',1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com',2002,'Shoes','Footwear',50.00,1,50.00);


-- Create dwh.dim_customers table
CREATE TABLE dwh.dim_customers (
    customer_id int4 PRIMARY KEY,
    customer_name varchar(100),
    customer_address varchar(200),
    customer_phone varchar(20),
    customer_email varchar(100)
);

-- Create dwh.dim_products table
CREATE TABLE dwh.dim_products (
    product_id int4 PRIMARY KEY,
    product_name varchar(100),
    product_category varchar(50),
    product_price numeric(10, 2)
);

-- Create dwh.fact_sales_transaction table
CREATE TABLE dwh.fact_sales_transaction (
    transaction_id int4,
    customer_id int4,
    product_id int4,
    sales_date date,
    quantity int4,
    sales_amount numeric,
    FOREIGN KEY (customer_id) REFERENCES dwh.dim_customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES dwh.dim_products(product_id)
);



INSERT INTO dwh.dim_customers (customer_id,customer_name,customer_address,customer_phone,customer_email) VALUES
	 (1001,'John Doe','123 Main St, Jakarta','081234567890','johndoe@example.com'),
	 (1002,'Jane Smith','456 Elm St, Jakarta','082345678901','janesmith@example.com'),
	 (1003,'David Johnson','789 Oak St, Jakarta','083456789012','davidjohnson@example.com'),
	 (1004,'Emily Davis','321 Maple St, Jakarta','084567890123','emilydavis@example.com'),
	 (1005,'Michael Wilson','654 Pine St, Jakarta','085678901234','michaelwilson@example.com');

	
INSERT INTO dwh.dim_products (product_id,product_name,product_category,product_price) VALUES
	 (2001,'Shirt','Apparel',25.00),
	 (2002,'Shoes','Footwear',50.00),
	 (2003,'Jeans','Apparel',40.00),
	 (2004,'Watch','Accessories',100.00),
	 (2005,'Hat','Accessories',15.00);

INSERT INTO dwh.fact_sales_transaction (transaction_id,customer_id,product_id,sales_date,quantity,sales_amount) VALUES
	 (1,1003,2003,'2023-07-05',2,80.00),
	 (2,1002,2001,'2023-07-05',1,25.00),
	 (3,1005,2004,'2023-07-06',3,300.00),
	 (4,1004,2002,'2023-07-06',2,100.00),
	 (5,1001,2003,'2023-07-07',1,40.00),
	 (6,1003,2001,'2023-07-08',4,100.00),
	 (7,1002,2002,'2023-07-08',2,100.00),
	 (8,1005,2004,'2023-07-09',1,100.00),
	 (9,1004,2001,'2023-07-09',3,75.00),
	 (10,1001,2003,'2023-07-10',2,80.00),
	 (11,1003,2002,'2023-07-10',2,100.00),
	 (12,1002,2004,'2023-07-11',1,100.00),
	 (13,1005,2003,'2023-07-11',3,120.00),
	 (14,1004,2001,'2023-07-12',1,25.00),
	 (15,1001,2002,'2023-07-12',2,100.00),
	 (16,1003,2004,'2023-07-13',2,200.00),
	 (17,1002,2003,'2023-07-13',1,40.00),
	 (18,1005,2001,'2023-07-14',3,75.00),
	 (19,1004,2002,'2023-07-14',2,100.00),
	 (20,1001,2004,'2023-07-15',1,100.00),
	 (21,1003,2003,'2023-07-15',2,80.00),
	 (22,1002,2001,'2023-07-16',1,25.00),
	 (23,1005,2002,'2023-07-16',2,100.00),
	 (24,1004,2004,'2023-07-17',3,300.00),
	 (25,1001,2003,'2023-07-17',1,40.00),
	 (26,1003,2002,'2023-07-18',2,100.00),
	 (27,1002,2004,'2023-07-18',1,100.00),
	 (28,1005,2001,'2023-07-19',2,50.00),
	 (29,1004,2003,'2023-07-19',3,120.00),
	 (30,1001,2002,'2023-07-20',1,50.00);


-- dm.dm_sales_transaction definition

-- Drop table

-- DROP TABLE dm.dm_sales_transaction;

CREATE TABLE dm.dm_sales_transaction (
	transaction_id int4 NULL,
	sales_date date NULL,
	customer_name varchar(100) NULL,
	product_name varchar(100) NULL,
	quantity int4 NULL,
	sales_amount numeric NULL
);

INSERT INTO dm.dm_sales_transaction (transaction_id,sales_date,customer_name,product_name,quantity,sales_amount) VALUES
	 (21,'2023-07-15','David Johnson','Jeans',2,80.00),
	 (22,'2023-07-16','Jane Smith','Shirt',1,25.00),
	 (23,'2023-07-16','Michael Wilson','Shoes',2,100.00),
	 (24,'2023-07-17','Emily Davis','Watch',3,300.00),
	 (25,'2023-07-17','John Doe','Jeans',1,40.00),
	 (26,'2023-07-18','David Johnson','Shoes',2,100.00),
	 (27,'2023-07-18','Jane Smith','Watch',1,100.00),
	 (28,'2023-07-19','Michael Wilson','Shirt',2,50.00),
	 (29,'2023-07-19','Emily Davis','Jeans',3,120.00),
	 (30,'2023-07-20','John Doe','Shoes',1,50.00),
	 (21,'2023-07-15','David Johnson','Jeans',2,80.00),
	 (22,'2023-07-16','Jane Smith','Shirt',1,25.00),
	 (23,'2023-07-16','Michael Wilson','Shoes',2,100.00),
	 (24,'2023-07-17','Emily Davis','Watch',3,300.00),
	 (25,'2023-07-17','John Doe','Jeans',1,40.00),
	 (26,'2023-07-18','David Johnson','Shoes',2,100.00),
	 (27,'2023-07-18','Jane Smith','Watch',1,100.00),
	 (28,'2023-07-19','Michael Wilson','Shirt',2,50.00),
	 (29,'2023-07-19','Emily Davis','Jeans',3,120.00),
	 (30,'2023-07-20','John Doe','Shoes',1,50.00);
