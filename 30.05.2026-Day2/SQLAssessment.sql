CREATE DATABASE training_sql_db;
USE training_sql_db;
CREATE TABLE books
(
 book_id INT PRIMARY KEY,
 book_title VARCHAR(100),
 category VARCHAR(50),
 author VARCHAR(50),
 price DECIMAL(10,2),
 stock INT,
 published_year INT
);
INSERT INTO books VALUES
(1, 'Python Basics', 'Programming', 'Ravi Kumar', 550, 30, 2021),
(2, 'Advanced SQL', 'Database', 'Priya Sharma', 750, 15, 2020),
(3, 'Data Engineering Guide', 'Data', 'Amit Verma', 1200, 10, 2023),
(4, 'Machine Learning Start', 'AI', 'Neha Reddy', 950, 8, 2022),
(5, 'Excel for Business', 'Business', 'Kiran Rao', 400, 50, 2019),
(6, 'Power BI Reports', 'Data', 'Sneha Patel', 850, 12, 2021),
(7, 'Java Fundamentals', 'Programming', 'Arjun Mehta', 600, 20, 2018),
(8, 'Cloud Basics', 'Cloud', 'Rahul Nair', 700, 18, 2022),
(9, 'SQL Interview Prep', 'Database', 'Farhan Ali', 500, 25, 2024),
(10, 'AI for Beginners', 'AI', 'Meera Singh', 650, 5, 2023);

select * from books;
select book_title,category,price from books;

select distinct category from books;
select * from books where category='Programming';
select * from books where price>700;
select * from books where stock<15;
select * from books where category in ('Programming','Database','AI');
select * from books where price between 500 and 900;
select * from books where book_title like '%SQL%';
select * from books where book_title like 'Data%';
select * from books order by price desc;
select * from books order by category asc, price desc;

-- aggregate

select count(*) as TotalBooks from books;
select MAX(price) as Highestprice from books;
select MIN(price) as Lowestprice from books;
select avg(price) as Averageprice from books;
select sum(stock) as Totalstock from books;
select category,count(*) as TotalBooks from books group by category;
select category,avg(price) as Averagepricebycategory from books group by category;
select category,sum(stock) as Totalstockbycategory from books group by category;
select category,count(*) as numberofbooks from books group by category having count(*)>1;
select category,avg(price) as Averageprice from books group by category having avg(price)>700;
CREATE TABLE departments
(
 department_id INT PRIMARY KEY,
 department_name VARCHAR(50),
 location VARCHAR(50)
);
CREATE TABLE employees
(
 employee_id INT PRIMARY KEY,
 employee_name VARCHAR(50),
 department_id INT,
 salary DECIMAL(10,2),
 city VARCHAR(50),
 manager_id INT
);
INSERT INTO departments VALUES
(10, 'IT', 'Hyderabad'),
(20, 'HR', 'Bangalore'),
(30, 'Finance', 'Mumbai'),
(40, 'Sales', 'Delhi'),
(50, 'Marketing', NULL);
INSERT INTO employees VALUES
(101, 'Rahul Sharma', 10, 75000, 'Hyderabad', 201),
(102, 'Priya Reddy', 10, 85000, 'Bangalore', 201),
(103, 'Amit Kumar', 20, 55000, NULL, 202),
(104, 'Sneha Patel', 30, 65000, 'Mumbai', 203),
(105, 'Arjun Verma', NULL, 60000, 'Chennai', 204),
(106, 'Neha Singh', 60, 50000, 'Delhi', NULL),
(107, 'Farhan Ali', 40, NULL, 'Hyderabad', 205),
(108, 'Meera Nair', 10, 90000, 'Pune', 201);
select employees.employee_name,employees.salary,departments.department_name,departments.location from employees inner join departments on employees.department_id=departments.department_id;
select e.employee_id,e.employee_name,e.salary,d.department_name,d.location from employees e left join departments d on e.department_id=d.department_id;
select e.employee_name from employees e left join departments d on e.department_id=d.department_id where d.department_id is null;
select d.department_name,e.employee_name,e.salary from employees e right join departments d on e.department_id=d.department_id;
select d.department_name from departments d left join employees e on d.department_id=e.department_id where e.employee_id is null;
select * from employees where salary is null;
select * from employees where city is null;
select * from departments where location is null;
select d.department_name,count(e.employee_id) as employee_count from departments d left join employees e on d.department_id=e.department_id group by d.department_name;
select d.department_name,avg(e.salary) as average_salary from departments d left join employees e on d.department_id=e.department_id group by d.department_name;
select d.department_name,count(e.employee_id) as employee_count from departments d join employees e on d.department_id=e.department_id group by d.department_name having count(e.employee_id)>2;
select d.department_name,max(e.salary) as highest_salary from departments d left join employees e on d.department_id=e.department_id group by d.department_name;

CREATE TABLE customers_new
(
 customer_id INT PRIMARY KEY,
 customer_name VARCHAR(50),
 city VARCHAR(50),
 membership_type VARCHAR(30)
);
CREATE TABLE payments
(
 payment_id INT PRIMARY KEY,
 customer_id INT,
 amount DECIMAL(10,2),
 payment_mode VARCHAR(30),
 payment_status VARCHAR(30)
);
INSERT INTO customers_new VALUES
(1, 'Ramesh Gupta', 'Hyderabad', 'Gold'),
(2, 'Sana Khan', 'Bangalore', 'Silver'),
(3, 'John Mathew', 'Mumbai', 'Gold'),
(4, 'Ayesha Begum', 'Chennai', 'Bronze'),
(5, 'Vikram Rao', 'Delhi', 'Silver'),
(6, 'Divya Sharma', 'Pune', NULL);
INSERT INTO payments VALUES
(1001, 1, 15000, 'UPI', 'Success'),
(1002, 1, 8000, 'Card', 'Success'),
(1003, 2, 5000, 'Cash', 'Pending'),
(1004, 3, 22000, 'UPI', 'Success'),
(1005, 7, 12000, 'Card', 'Failed'),
(1006, NULL, 3000, 'Cash', 'Pending'),
(1007, 4, NULL, 'UPI', 'Success'),
(1008, 5, 7000, NULL, 'Success');

select * from customers_new where customer_id in(select customer_id from payments where customer_id is not null);
select * from customers_new c where not exists(select 1 from payments p where p.customer_id=c.customer_id);
select * from payments where amount>(select avg(amount) from payments);
select c.customer_name,p.amount from customers_new c join payments p on c.customer_id=p.customer_id where p.amount=(select max(amount) from payments);
select * from customers_new where membership_type='Gold' and customer_id in(select customer_id from payments);
select c.customer_id,c.customer_name from customers_new c join payments p on c.customer_id=p.customer_id group by c.customer_id,c.customer_name having sum(p.amount)>10000;
select payment_id from payments p where not exists(select 1 from customers_new c where c.customer_id=p.customer_id);
select * from customers_new c where exists(select 1 from payments p where p.customer_id=c.customer_id);
select * from customers_new c where not exists(select 1 from payments p where p.customer_id=c.customer_id);
select distinct c.customer_name,p.amount from customers_new c join payments p on c.customer_id=p.customer_id where p.amount>all(select amount from payments where customer_id=2);