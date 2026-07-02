-- DATABASE
CREATE DATABASE RetailSalesDB;
USE RetailSalesDB;

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    cost DECIMAL(10,2),
    price DECIMAL(10,2)
);

-- Stores Table
CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    region VARCHAR(50)
);

-- Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    designation VARCHAR(50),
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

-- Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    store_id INT,
    product_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Inserting the Data
INSERT INTO products VALUES
(101,'Laptop','Electronics',40000,50000),
(102,'Mobile','Electronics',15000,20000),
(103,'Headphones','Accessories',1000,1500);

INSERT INTO stores VALUES
(1,'Hyderabad Store','South'),
(2,'Chennai Store','South'),
(3,'Mumbai Store','West');

INSERT INTO employees VALUES
(1,'Ravi','Manager',1),
(2,'Priya','Sales Executive',2),
(3,'Kiran','Cashier',3);

INSERT INTO sales VALUES
(1001,1,101,5,'2026-06-01'),
(1002,1,102,10,'2026-06-01'),
(1003,2,103,15,'2026-06-01'),
(1004,3,101,3,'2026-06-02');

-- CRUD Operations
-- CREATE
-- 1
INSERT INTO sales VALUES
(1005,2,102,8,'2026-06-03');
-- 2
INSERT INTO sales (sale_id, store_id, product_id, quantity, sale_date)
SELECT 1005, store_id, 101, 10, CURDATE() FROM stores
WHERE store_name='Hyderabad Store';
-- 3 
INSERT INTO sales VALUES
(1006,1,102,15,'2026-06-05'),
(1007,2,103,20,'2026-06-05'),
(1008,3,101,12,'2026-06-05');
-- 4
INSERT INTO products 
VALUES (104,'Smart Watch','Electronics',3000,4500);
-- 5
INSERT INTO stores
VALUES (4,'Bangalore Store','South');
-- 6
INSERT INTO employees
VALUES (4,'Anjali','Sales Executive',4);

-- READ
-- 1
SELECT * FROM sales;
-- 2
SELECT product_id, product_name, price FROM products
WHERE price >
( SELECT AVG(price) FROM products );
-- 3
SELECT store_id, store_name FROM stores
WHERE store_id =
( SELECT s.store_id FROM sales s
  JOIN products p ON s.product_id = p.product_id
  GROUP BY s.store_id
  ORDER BY SUM(s.quantity * p.price) DESC
  LIMIT 1
);
-- 4
SELECT employee_id, employee_name FROM employees
WHERE store_id IN
( SELECT DISTINCT store_id FROM sales );
-- 5
SELECT st.store_name, SUM(s.quantity * p.price) AS revenue FROM sales s
JOIN stores st ON s.store_id = st.store_id
JOIN products p ON s.product_id = p.product_id
GROUP BY st.store_name;
-- 6
SELECT s.sale_id, st.store_name, p.product_name, e.employee_name, s.quantity, s.sale_date FROM sales s
JOIN stores st ON s.store_id = st.store_id
JOIN products p ON s.product_id = p.product_id
JOIN employees e ON st.store_id = e.store_id;

-- UPDATE
-- 1
UPDATE products SET price = 5000
WHERE product_id = 104;
-- 2
UPDATE stores SET region = 'South-East'
WHERE store_id = 4;
-- 3
UPDATE employees SET designation = 'Senior Sales Executive'
WHERE employee_id = 4;
-- 4
UPDATE sales SET quantity = 15
WHERE sale_id = 1005;
-- 5
UPDATE products SET price = price * 1.10
WHERE category = 'Electronics';
-- 6
UPDATE sales SET quantity = quantity + 5
WHERE quantity < 10;

-- DELETE
-- 1
DELETE FROM sales WHERE sale_id = 1005;
-- 2
DELETE FROM employees WHERE employee_id = 4;
-- 3
DELETE FROM stores WHERE store_id = 4;
-- 4
DELETE FROM products WHERE product_id = 104;
-- 5
DELETE FROM sales WHERE quantity < 5;
-- 6
DELETE FROM products WHERE product_id NOT IN
( SELECT DISTINCT product_id FROM sales );

-- Stored Procedure
-- 1
DELIMITER //
CREATE PROCEDURE DailySales(
    IN p_store_id INT,
    IN p_date DATE
)
BEGIN
    SELECT sa.store_id, st.store_name, SUM(sa.quantity * p.price) AS total_sales FROM sales sa
    JOIN products p ON sa.product_id = p.product_id
    JOIN stores st ON sa.store_id = st.store_id
    WHERE sa.store_id = p_store_id AND sa.sale_date = p_date
    GROUP BY sa.store_id, st.store_name;
END //
DELIMITER ;
-- Execution
CALL DailySales(1,'2026-06-01');

-- 2
DELIMITER //
CREATE PROCEDURE GetProductRevenue(
    IN p_product_id INT
)
BEGIN
    SELECT p.product_id, p.product_name, SUM(s.quantity * p.price) AS total_revenue FROM sales s
    JOIN products p ON s.product_id = p.product_id
    WHERE p.product_id = p_product_id
    GROUP BY p.product_id, p.product_name;
END //
DELIMITER ;
-- Execution
CALL GetProductRevenue(101);

-- 3
DELIMITER //
CREATE PROCEDURE GetStorePerformance()
BEGIN
    SELECT st.store_id, st.store_name, st.region, COUNT(s.sale_id) AS total_transactions, COALESCE(SUM(s.quantity * p.price),0) AS total_sales
    FROM stores st
    LEFT JOIN sales s ON st.store_id = s.store_id
    LEFT JOIN products p ON s.product_id = p.product_id
    GROUP BY st.store_id, st.store_name, st.region;
END //
DELIMITER ;
-- Execution
CALL GetStorePerformance();

-- 4
DELIMITER //
CREATE PROCEDURE GetTopProducts()
BEGIN
    SELECT p.product_id,p.product_name, SUM(s.quantity) AS units_sold FROM sales s
    JOIN products p ON s.product_id = p.product_id
    GROUP BY p.product_id, p.product_name
    ORDER BY units_sold DESC
    LIMIT 5;
END //
DELIMITER ;
-- Execution
CALL GetTopProducts();

-- 5
DELIMITER //
CREATE PROCEDURE GetUnderperformingProducts(
    IN p_min_quantity INT
)
BEGIN
    SELECT p.product_id, p.product_name, SUM(s.quantity) AS total_units_sold FROM sales s
    JOIN products p ON s.product_id = p.product_id
    GROUP BY p.product_id, p.product_name
    HAVING total_units_sold < p_min_quantity;
END //
DELIMITER ;
-- Execution
CALL GetUnderperformingProducts(50);

-- 6
DELIMITER //
CREATE PROCEDURE GetSalesByRegion(
    IN p_region VARCHAR(50)
)
BEGIN
    SELECT st.region, SUM(s.quantity * p.price) AS total_sales FROM sales s
    JOIN stores st ON s.store_id = st.store_id
    JOIN products p ON s.product_id = p.product_id
    WHERE st.region = p_region
    GROUP BY st.region;
END //
DELIMITER ;
-- Execution
CALL GetSalesByRegion('South');

-- INDEXES
-- 1
CREATE INDEX idx_product
ON sales(product_id);

SHOW INDEX FROM sales
WHERE Key_name = 'idx_product';

-- 2
CREATE INDEX idx_region
ON stores(region);

SHOW INDEX FROM stores
WHERE Key_name = 'idx_region';

-- 3
CREATE INDEX idx_store
ON sales(store_id);

SHOW INDEX FROM sales
WHERE Key_name = 'idx_store';

-- 4
CREATE INDEX idx_sale_date
ON sales(sale_date);

SHOW INDEX FROM sales
WHERE Key_name = 'idx_sale_date';

-- 5
CREATE INDEX idx_employee_store
ON employees(store_id);

SHOW INDEX FROM employees
WHERE Key_name = 'idx_employee_store';

-- 6
CREATE INDEX idx_product_store
ON sales(product_id, store_id);

SHOW INDEX FROM sales
WHERE Key_name = 'idx_product_store';
