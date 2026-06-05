CREATE DATABASE hospital_db;
USE hospital_db;

CREATE TABLE patients
(
 patient_id INT PRIMARY KEY,
 patient_name VARCHAR(100),
 gender VARCHAR(10),
 age INT,
 city VARCHAR(50),
 phone VARCHAR(15)
);

CREATE TABLE departments
(
 department_id INT PRIMARY KEY,
 department_name VARCHAR(100)
);

CREATE TABLE doctors
(
 doctor_id INT PRIMARY KEY,
 doctor_name VARCHAR(100),
 specialization VARCHAR(100),
 department_id INT,
 consultation_fee DECIMAL(10,2)
);

CREATE TABLE appointments
(
 appointment_id INT PRIMARY KEY,
 patient_id INT,
 doctor_id INT,
 appointment_date DATE,
 appointment_status VARCHAR(30)
);

CREATE TABLE treatments
(
 treatment_id INT PRIMARY KEY,
 appointment_id INT,
 treatment_name VARCHAR(100),
 treatment_cost DECIMAL(10,2)
);

CREATE TABLE bills
(
 bill_id INT PRIMARY KEY,
 patient_id INT,
 appointment_id INT,
 bill_date DATE,
 total_amount DECIMAL(10,2),
 bill_status VARCHAR(30)
);

CREATE TABLE payments
(
 payment_id INT PRIMARY KEY,
 bill_id INT,
 payment_mode VARCHAR(30),
 paid_amount DECIMAL(10,2),
 payment_status VARCHAR(30)
);

SELECT * FROM patients;

SELECT * FROM doctors;

SELECT * FROM patients
WHERE city='Hyderabad';

SELECT d.*
FROM doctors d
JOIN departments dp
ON d.department_id=dp.department_id
WHERE dp.department_name='Cardiology';

SELECT * FROM appointments
WHERE appointment_date>'2026-01-01';

SELECT * FROM appointments
WHERE appointment_status='Cancelled';

SELECT * FROM bills
WHERE total_amount>5000;

SELECT * FROM payments
WHERE payment_mode='UPI';

SELECT * FROM patients
WHERE age BETWEEN 30 AND 50;

SELECT * FROM doctors
WHERE consultation_fee>800;

SELECT COUNT(*) AS total_patients
FROM patients;

SELECT COUNT(*) AS total_doctors
FROM doctors;

SELECT COUNT(*) AS total_appointments
FROM appointments;

SELECT AVG(consultation_fee) AS avg_fee
FROM doctors;

SELECT MAX(treatment_cost) AS highest_treatment_cost
FROM treatments;

SELECT SUM(total_amount) AS total_billing
FROM bills;

SELECT SUM(paid_amount) AS total_paid
FROM payments;

SELECT city,COUNT(*) AS patient_count
FROM patients
GROUP BY city;

SELECT specialization,COUNT(*) AS doctor_count
FROM doctors
GROUP BY specialization;

SELECT appointment_status,COUNT(*) AS total
FROM appointments
GROUP BY appointment_status;

SELECT p.patient_name,a.appointment_date,a.appointment_status
FROM patients p
JOIN appointments a
ON p.patient_id=a.patient_id;

SELECT d.doctor_name,dp.department_name
FROM doctors d
JOIN departments dp
ON d.department_id=dp.department_id;

SELECT p.patient_name,d.doctor_name,a.appointment_date
FROM appointments a
JOIN patients p
ON a.patient_id=p.patient_id
JOIN doctors d
ON a.doctor_id=d.doctor_id;

SELECT a.appointment_id,t.treatment_name,t.treatment_cost
FROM appointments a
JOIN treatments t
ON a.appointment_id=t.appointment_id;

SELECT b.bill_id,p.patient_name,b.total_amount
FROM bills b
JOIN patients p
ON b.patient_id=p.patient_id;

SELECT b.bill_id,p.payment_mode,p.paid_amount,p.payment_status
FROM bills b
JOIN payments p
ON b.bill_id=p.bill_id;

SELECT p.patient_name,
       d.doctor_name,
       dp.department_name,
       a.appointment_date,
       a.appointment_status,
       t.treatment_name,
       t.treatment_cost,
       b.total_amount,
       py.payment_status
FROM appointments a
JOIN patients p ON a.patient_id=p.patient_id
JOIN doctors d ON a.doctor_id=d.doctor_id
JOIN departments dp ON d.department_id=dp.department_id
LEFT JOIN treatments t ON a.appointment_id=t.appointment_id
LEFT JOIN bills b ON a.appointment_id=b.appointment_id
LEFT JOIN payments py ON b.bill_id=py.bill_id;

SELECT doctor_id,COUNT(*) AS total_appointments
FROM appointments
GROUP BY doctor_id;

SELECT dp.department_name,COUNT(*) AS total_appointments
FROM appointments a
JOIN doctors d ON a.doctor_id=d.doctor_id
JOIN departments dp ON d.department_id=dp.department_id
GROUP BY dp.department_name;

SELECT dp.department_name,SUM(b.total_amount) AS revenue
FROM bills b
JOIN appointments a ON b.appointment_id=a.appointment_id
JOIN doctors d ON a.doctor_id=d.doctor_id
JOIN departments dp ON d.department_id=dp.department_id
GROUP BY dp.department_name;

SELECT treatment_name,SUM(treatment_cost) AS total_cost
FROM treatments
GROUP BY treatment_name;

SELECT p.city,SUM(b.total_amount) AS total_billing
FROM bills b
JOIN patients p ON b.patient_id=p.patient_id
GROUP BY p.city;

SELECT doctor_id,COUNT(*) AS total_appointments
FROM appointments
GROUP BY doctor_id
HAVING COUNT(*)>2;

SELECT dp.department_name,SUM(b.total_amount) AS revenue
FROM bills b
JOIN appointments a ON b.appointment_id=a.appointment_id
JOIN doctors d ON a.doctor_id=d.doctor_id
JOIN departments dp ON d.department_id=dp.department_id
GROUP BY dp.department_name
HAVING SUM(b.total_amount)>20000;

SELECT city,COUNT(*) AS total_patients
FROM patients
GROUP BY city
HAVING COUNT(*)>2;

SELECT *
FROM patients
WHERE patient_id IN
(
 SELECT patient_id
 FROM appointments
);

SELECT *
FROM patients
WHERE patient_id NOT IN
(
 SELECT patient_id
 FROM appointments
);

SELECT *
FROM doctors
WHERE doctor_id NOT IN
(
 SELECT doctor_id
 FROM appointments
);

SELECT *
FROM bills
WHERE total_amount>
(
 SELECT AVG(total_amount)
 FROM bills
);

SELECT *
FROM patients
WHERE patient_id=
(
 SELECT patient_id
 FROM bills
 ORDER BY total_amount DESC
 LIMIT 1
);

SELECT *
FROM doctors
WHERE consultation_fee>
(
 SELECT AVG(consultation_fee)
 FROM doctors
);

SELECT DISTINCT p.*
FROM patients p
JOIN appointments a ON p.patient_id=a.patient_id
JOIN doctors d ON a.doctor_id=d.doctor_id
JOIN departments dp ON d.department_id=dp.department_id
WHERE dp.department_name='Cardiology';

SELECT *
FROM bills
WHERE bill_status='Unpaid';

SELECT *
FROM appointments
WHERE appointment_id IN
(
 SELECT appointment_id
 FROM treatments
);

SELECT *
FROM patients
WHERE patient_id IN
(
 SELECT patient_id
 FROM bills
 GROUP BY patient_id
 HAVING SUM(total_amount)>
 (
  SELECT AVG(total_bill)
  FROM
  (
   SELECT SUM(total_amount) AS total_bill
   FROM bills
   GROUP BY patient_id
  ) x
 )
);

SELECT a.*
FROM appointments a
LEFT JOIN treatments t
ON a.appointment_id=t.appointment_id
WHERE t.treatment_id IS NULL;

SELECT b.*
FROM bills b
LEFT JOIN payments p
ON b.bill_id=p.bill_id
WHERE p.payment_id IS NULL;

SELECT *
FROM payments
WHERE paid_amount IS NULL
OR paid_amount=0;

SELECT a.*,b.bill_id
FROM appointments a
JOIN bills b
ON a.appointment_id=b.appointment_id
WHERE a.appointment_status='Cancelled';

SELECT b.bill_id,b.total_amount,p.paid_amount
FROM bills b
JOIN payments p
ON b.bill_id=p.bill_id
WHERE b.bill_status='Paid'
AND p.paid_amount<b.total_amount;

SELECT *
FROM doctors
WHERE department_id NOT IN
(
 SELECT department_id
 FROM departments
);

SELECT *
FROM appointments
WHERE patient_id NOT IN
(
 SELECT patient_id
 FROM patients
)
OR doctor_id NOT IN
(
 SELECT doctor_id
 FROM doctors
);

SELECT p.patient_name,
       p.city,
       COUNT(DISTINCT a.appointment_id) AS total_appointments,
       COALESCE(SUM(b.total_amount),0) AS total_bill_amount,
       COALESCE(SUM(py.paid_amount),0) AS total_paid_amount,
       COALESCE(SUM(b.total_amount),0)-COALESCE(SUM(py.paid_amount),0) AS pending_amount
FROM patients p
LEFT JOIN appointments a ON p.patient_id=a.patient_id
LEFT JOIN bills b ON p.patient_id=b.patient_id
LEFT JOIN payments py ON b.bill_id=py.bill_id
GROUP BY p.patient_id,p.patient_name,p.city;
