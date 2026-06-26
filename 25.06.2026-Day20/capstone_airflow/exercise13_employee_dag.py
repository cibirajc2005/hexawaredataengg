from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def create_employee_file():
    with open("/tmp/employees.txt", "w") as f:
        f.write("""Rahul,28
Priya,31
Amit,42
Sneha,26
Kiran,38""")

def calculate_average_age():
    employees = []

    with open("/tmp/employees.txt", "r") as f:
        for line in f:
            name, age = line.strip().split(",")
            employees.append((name, int(age)))

    youngest = min(employees, key=lambda x: x[1])
    oldest = max(employees, key=lambda x: x[1])
    avg = sum(age for _, age in employees) / len(employees)

    with open("/tmp/age_stats.txt", "w") as f:
        f.write(f"{youngest[0]},{oldest[0]},{avg}")

def generate_age_report():
    with open("/tmp/age_stats.txt", "r") as f:
        youngest, oldest, avg = f.read().split(",")

    with open("/tmp/age_report.txt", "w") as f:
        f.write(f"Youngest Employee = {youngest}\n")
        f.write(f"Oldest Employee = {oldest}\n")
        f.write(f"Average Age = {avg}\n")

with DAG(
    dag_id="exercise13_employee_age",
    start_date=datetime(2024,1,1),
    schedule=None,
    catchup=False
) as dag:

    t1 = PythonOperator(task_id="create_employee_file", python_callable=create_employee_file)
    t2 = PythonOperator(task_id="calculate_average_age", python_callable=calculate_average_age)
    t3 = PythonOperator(task_id="generate_age_report", python_callable=generate_age_report)

    t1 >> t2 >> t3