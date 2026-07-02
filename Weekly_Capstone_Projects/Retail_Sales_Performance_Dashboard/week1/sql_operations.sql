CREATE DATABASE IF NOT EXISTS retail_dashboard;
USE retail_dashboard;

CREATE TABLE stores (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    opened_date DATE
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2) NOT NULL
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    store_id INT NOT NULL,
    role VARCHAR(50),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    employee_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    discount_percent DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO stores (store_name, region, city, opened_date)
VALUES
('Downtown Retail', 'South', 'Chennai', '2020-05-10'),
('Mall Outlet', 'West', 'Mumbai', '2019-11-02'),
('Highway Store', 'North', 'Delhi', '2021-08-15');

INSERT INTO products (product_name, category, price, cost)
VALUES
('Wireless Mouse', 'Electronics', 599.00, 350.00),
('Cotton T-Shirt', 'Apparel', 499.00, 220.00),
('Ceramic Mug', 'Home', 299.00, 120.00);

INSERT INTO employees (first_name, last_name, store_id, role)
VALUES
('Priya', 'Nair', 1, 'Store Manager'),
('Rahul', 'Verma', 2, 'Sales Associate'),
('Sneha', 'Iyer', 3, 'Cashier');

INSERT INTO sales (store_id, product_id, employee_id, sale_date, quantity, discount_percent)
VALUES
(1, 1, 1, '2026-06-01', 10, 5.00),
(2, 2, 2, '2026-06-01', 4, 0.00),
(3, 3, 3, '2026-06-01', 20, 10.00);

SELECT * FROM sales;

SELECT s.store_name, p.product_name, sa.quantity, sa.discount_percent
FROM sales sa
JOIN stores s ON sa.store_id = s.store_id
JOIN products p ON sa.product_id = p.product_id;

UPDATE sales
SET quantity = 12
WHERE sale_id = 1;

DELETE FROM sales
WHERE quantity = 0;

DELIMITER //

CREATE PROCEDURE GetDailySales(IN in_store_id INT, IN in_date DATE)
BEGIN
    SELECT
        s.store_id,
        s.store_name,
        SUM(sa.quantity * p.price * (1 - sa.discount_percent / 100)) AS daily_sales
    FROM sales sa
    JOIN stores s ON sa.store_id = s.store_id
    JOIN products p ON sa.product_id = p.product_id
    WHERE sa.store_id = in_store_id AND sa.sale_date = in_date
    GROUP BY s.store_id, s.store_name;
END //

DELIMITER ;

CALL GetDailySales(1, '2026-06-01');

CREATE INDEX idx_product_id ON sales(product_id);
CREATE INDEX idx_store_region ON stores(region);
