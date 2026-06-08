create database day2;
use day2;
CREATE TABLE customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    phone VARCHAR(15)
);

CREATE TABLE orders
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    order_amount DECIMAL(10,2),
    order_status VARCHAR(30)
);

INSERT INTO customers VALUES
(1, 'Rahul Sharma', 'Hyderabad', '9876543210'),
(2, 'Priya Reddy', 'Bangalore', '9876543211'),
(3, 'Amit Kumar', 'Mumbai', NULL),
(4, 'Sneha Patel', 'Chennai', '9876543213'),
(5, 'Arjun Verma', NULL, '9876543214'),
(6, 'Neha Singh', 'Delhi', '9876543215');

INSERT INTO orders VALUES
(101, 1, 'Laptop', 55000, 'Delivered'),
(102, 1, 'Mouse', 700, 'Delivered'),
(103, 2, 'Mobile', 25000, 'Shipped'),
(104, 3, 'Keyboard', NULL, 'Pending'),
(105, 7, 'Printer', 18000, 'Delivered'),
(106, NULL, 'Office Chair', 7500, 'Pending'),
(107, 4, NULL, 12000, 'Cancelled'),
(108, 8, 'Monitor', 15000, NULL);

select c.customer_id, c.customer_name, c.city,o.customer_id, o.order_id, o.product_name, o.order_amount 
from customers c inner join orders o on c.customer_id=o.customer_id;

select c.customer_id, c.customer_name, c.city,o.customer_id as order_customer_id, o.order_id, o.product_name, o.order_amount 
from customers c left join orders o on c.customer_id=o.customer_id
UNION
select c.customer_id, c.customer_name, c.city,o.customer_id as order_customer_id, o.order_id, o.product_name, o.order_amount 
from customers c right join orders o on c.customer_id=o.customer_id;

select c.customer_id, c.customer_name
from customers c left join orders o on c.customer_id=o.customer_id where o.order_id is null;

select * from customers where customer_id in (
select customer_id from orders);

select customer_name from customers where customer_id not in (
select customer_id from orders where customer_id is not null);

select * from orders where order_amount<(select avg(order_amount) from orders);

select * from orders where order_amount=(select max(order_amount) from orders);