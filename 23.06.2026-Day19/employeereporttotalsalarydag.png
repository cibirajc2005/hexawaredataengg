from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def create_salary_file():
    with open("/tmp/employees.txt", "w") as f:
        f.write("Rahul,45000\n")
        f.write("Priya,52000\n")
        f.write("Amit,61000\n")
        f.write("Sneha,48000\n")

def calculate_total_salary():
    total = 0

    with open("/tmp/employees.txt", "r") as f:
        for line in f:
            total += int(line.strip().split(",")[1])

    with open("/tmp/total_salary.txt", "w") as f:
        f.write(str(total))

    print("Total Salary =", total)

def generate_report():
    with open("/tmp/total_salary.txt", "r") as f:
        total = f.read()

    with open("/tmp/report.txt", "w") as f:
        f.write("Salary Report\n")
        f.write("Employees = 4\n")
        f.write(f"Total Salary = {total}")

with DAG(
    dag_id="employee_salary_report_dag",
    start_date=datetime(2024,1,1),
    schedule="@daily",
    catchup=False
) as dag:

    t1 = PythonOperator(task_id="create_salary_file", python_callable=create_salary_file)
    t2 = PythonOperator(task_id="calculate_total_salary", python_callable=calculate_total_salary)
    t3 = PythonOperator(task_id="generate_report", python_callable=generate_report)

    t1 >> t2 >> t3