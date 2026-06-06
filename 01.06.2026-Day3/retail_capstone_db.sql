create database retail_capstone_db;

use retail_capstone_db;

create table customers
(
    customer_id int primary key,
    customer_name varchar(100),
    city varchar(50),
    state varchar(50),
    gender varchar(10),
    membership_type varchar(30)
);

create table products
(
    product_id int primary key,
    product_name varchar(100),
    category varchar(50),
    price decimal(10,2)
);

create table orders
(
    order_id int primary key,
    customer_id int,
    order_date date,
    order_status varchar(30),
    foreign key (customer_id) references customers(customer_id)
);

create table order_items
(
    item_id int primary key,
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

create table payments
(
    payment_id int primary key,
    order_id int,
    payment_mode varchar(30),
    payment_status varchar(30),
    amount decimal(10,2),
    foreign key (order_id) references orders(order_id)
);

create table deliveries
(
    delivery_id int primary key,
    order_id int,
    delivery_partner varchar(50),
    delivery_status varchar(30),
    delivery_city varchar(50),
    foreign key (order_id) references orders(order_id)
);

insert into customers values
(1,'Arjun Kumar','Chennai','Tamil Nadu','Male','Gold'),
(2,'Priya Sharma','Hyderabad','Telangana','Female','Silver'),
(3,'Rahul Verma','Bangalore','Karnataka','Male','Gold'),
(4,'Sneha Reddy','Hyderabad','Telangana','Female','Platinum'),
(5,'Vikram Singh','Mumbai','Maharashtra','Male','Silver'),
(6,'Anjali Gupta','Delhi','Delhi','Female','Gold'),
(7,'Karan Mehta','Pune','Maharashtra','Male','Silver'),
(8,'Neha Joshi','Chennai','Tamil Nadu','Female','Gold'),
(9,'Rohit Das','Kolkata','West Bengal','Male','Platinum'),
(10,'Meera Nair','Hyderabad','Telangana','Female','Gold');

insert into products values
(101,'Laptop','Electronics',55000),
(102,'Smartphone','Electronics',25000),
(103,'Headphones','Electronics',2000),
(104,'T-Shirt','Fashion',800),
(105,'Jeans','Fashion',1500),
(106,'Shoes','Fashion',2500),
(107,'Mixer Grinder','Home Appliances',3500),
(108,'Watch','Accessories',5000),
(109,'Backpack','Accessories',1200),
(110,'Tablet','Electronics',18000);

insert into orders values
(1001,1,'2026-01-05','Delivered'),
(1002,2,'2026-01-08','Delivered'),
(1003,3,'2026-01-10','Pending'),
(1004,4,'2026-01-12','Cancelled'),
(1005,5,'2026-01-15','Delivered'),
(1006,1,'2026-01-18','Pending'),
(1007,6,'2026-01-20','Delivered'),
(1008,7,'2026-01-22','Delivered'),
(1009,8,'2026-01-25','Pending'),
(1010,9,'2026-01-28','Delivered'),
(1011,10,'2026-02-01','Pending'),
(1012,2,'2026-02-03','Delivered'),
(1013,3,'2026-02-05','Cancelled'),
(1014,4,'2026-02-08','Delivered'),
(1015,5,'2026-02-10','Pending');

insert into order_items values
(1,1001,101,1),
(2,1001,103,2),
(3,1002,102,1),
(4,1002,104,3),
(5,1003,105,2),
(6,1003,106,1),
(7,1004,107,1),
(8,1005,108,2),
(9,1005,109,1),
(10,1006,110,1),
(11,1007,101,1),
(12,1008,102,1),
(13,1009,103,2),
(14,1010,104,4),
(15,1011,105,2),
(16,1012,106,1),
(17,1013,107,1),
(18,1014,108,1),
(19,1015,109,2),
(20,1015,110,1);

insert into payments values
(1,1001,'UPI','Successful',59000),
(2,1002,'Card','Successful',27400),
(3,1003,'UPI','Pending',5500),
(4,1004,'Net Banking','Successful',3500),
(5,1005,'Card','Successful',11200),
(6,1006,'UPI','Pending',18000),
(7,1007,'Card','Successful',55000),
(8,1008,'UPI','Successful',25000),
(9,1009,'Wallet','Pending',4000),
(10,1010,'UPI','Successful',3200),
(11,1011,'Card','Pending',3000),
(12,1012,'UPI','Successful',2500),
(13,1013,'Card','Failed',3500),
(14,1014,'Net Banking','Successful',5000),
(15,1015,'UPI','Pending',20400);

insert into deliveries values
(1,1001,'Delhivery','Delivered','Chennai'),
(2,1002,'BlueDart','Delivered','Hyderabad'),
(3,1003,'Ecom Express','Pending','Bangalore'),
(4,1004,'Delhivery','Cancelled','Hyderabad'),
(5,1005,'BlueDart','Delivered','Mumbai'),
(6,1006,'Ecom Express','Pending','Chennai'),
(7,1007,'Delhivery','Delivered','Delhi'),
(8,1008,'BlueDart','Delivered','Pune'),
(9,1009,'Ecom Express','Pending','Chennai'),
(10,1010,'Delhivery','Delivered','Kolkata'),
(11,1011,'BlueDart','Pending','Hyderabad'),
(12,1012,'Ecom Express','Delivered','Hyderabad'),
(13,1013,'Delhivery','Cancelled','Bangalore'),
(14,1014,'BlueDart','Delivered','Hyderabad'),
(15,1015,'Ecom Express','Pending','Mumbai');


SELECT * FROM customers;

SELECT customer_name, city, membership_type
FROM customers;

SELECT *
FROM products
ORDER BY price DESC;

SELECT *
FROM customers
WHERE city = 'Hyderabad';

SELECT *
FROM customers
WHERE membership_type = 'Gold';

SELECT *
FROM products
WHERE price BETWEEN 500 AND 5000;

SELECT *
FROM products
WHERE category IN ('Electronics','Fashion');

SELECT *
FROM orders
WHERE order_date > '2026-01-01';

SELECT *
FROM payments
WHERE payment_mode = 'UPI';

SELECT *
FROM deliveries
WHERE delivery_status = 'Pending';

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(*) AS total_products
FROM products;

SELECT SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'Successful';

SELECT AVG(amount) AS avg_payment
FROM payments;

SELECT MAX(amount) AS highest_payment
FROM payments;

SELECT MIN(amount) AS lowest_payment
FROM payments;

SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city;

SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY category;

SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY order_status;

SELECT c.customer_name, o.order_id, o.order_date
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

SELECT oi.order_id, p.product_name, oi.quantity, p.price
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id;

SELECT c.customer_name, p.product_name, oi.quantity, o.order_date
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id;

SELECT o.order_id, p.payment_mode, p.payment_status, p.amount
FROM orders o
JOIN payments p
ON o.order_id = p.order_id;

SELECT o.order_id, d.delivery_partner, d.delivery_status
FROM orders o
JOIN deliveries d
ON o.order_id = d.order_id;

SELECT c.customer_name,
       c.city,
       o.order_id,
       o.order_date,
       p.product_name,
       p.category,
       oi.quantity,
       p.price,
       pay.payment_status,
       d.delivery_status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN payments pay ON o.order_id = pay.order_id
JOIN deliveries d ON o.order_id = d.order_id;

SELECT c.city,
       SUM(pay.amount) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments pay ON o.order_id = pay.order_id
WHERE pay.payment_status = 'Successful'
GROUP BY c.city;

SELECT c.customer_name,
       SUM(pay.amount) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments pay ON o.order_id = pay.order_id
WHERE pay.payment_status = 'Successful'
GROUP BY c.customer_name;

SELECT p.product_name,
       SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name;

SELECT p.category,
       SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category;

SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1;

SELECT p.category,
       SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category
HAVING SUM(oi.quantity * p.price) > 10000;

SELECT city,
       COUNT(*) AS customer_count
FROM customers
GROUP BY city
HAVING COUNT(*) > 2;

SELECT p.product_name,
       SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
HAVING SUM(oi.quantity) > 3;

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);

SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

SELECT *
FROM products
WHERE product_id NOT IN (
    SELECT product_id
    FROM order_items
);

SELECT *
FROM payments
WHERE amount > (
    SELECT AVG(amount)
    FROM payments
);

SELECT *
FROM customers
WHERE customer_id = (
    SELECT o.customer_id
    FROM orders o
    JOIN payments p
    ON o.order_id = p.order_id
    ORDER BY p.amount DESC
    LIMIT 1
);

SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.category = 'Electronics';

SELECT *
FROM orders
WHERE order_id IN (
    SELECT order_id
    FROM payments
    WHERE payment_status = 'Successful'
);

SELECT *
FROM orders
WHERE order_id IN (
    SELECT order_id
    FROM deliveries
    WHERE delivery_status <> 'Delivered'
);

SELECT c.customer_id,
       c.customer_name,
       SUM(pay.amount) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments pay ON o.order_id = pay.order_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(pay.amount) >
(
    SELECT AVG(total_spent)
    FROM
    (
        SELECT SUM(pay.amount) AS total_spent
        FROM customers c
        JOIN orders o ON c.customer_id = o.customer_id
        JOIN payments pay ON o.order_id = pay.order_id
        GROUP BY c.customer_id
    ) x
);

SELECT o.*
FROM orders o
LEFT JOIN payments p
ON o.order_id = p.order_id
WHERE p.order_id IS NULL;

SELECT o.*
FROM orders o
LEFT JOIN deliveries d
ON o.order_id = d.order_id
WHERE d.order_id IS NULL;

SELECT *
FROM payments
WHERE amount IS NULL
OR amount = 0;

SELECT o.*
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
WHERE o.order_status = 'Cancelled'
AND p.payment_status = 'Successful';

SELECT o.*
FROM orders o
JOIN deliveries d
ON o.order_id = d.order_id
JOIN payments p
ON o.order_id = p.order_id
WHERE d.delivery_status = 'Delivered'
AND p.payment_status = 'Failed';

SELECT oi.*
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT o.*
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
