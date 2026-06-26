from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def create_department_file():
    with open("/tmp/departments.txt", "w") as f:
        f.write("""IT,45000
HR,35000
Finance,50000
IT,55000
Finance,40000
HR,30000""")

def calculate_department_salary():
    totals = {}

    with open("/tmp/departments.txt", "r") as f:
        for line in f:
            dept, salary = line.strip().split(",")
            totals[dept] = totals.get(dept, 0) + int(salary)

    with open("/tmp/department_totals.txt", "w") as f:
        for dept, total in totals.items():
            f.write(f"{dept}={total}\n")

def generate_department_report():
    with open("/tmp/department_totals.txt", "r") as src:
        data = src.read()

    with open("/tmp/department_report.txt", "w") as f:
        f.write("Department Salary Report\n")
        f.write(data)

with DAG(
    dag_id="exercise7_department_salary",
    start_date=datetime(2024,1,1),
    schedule=None,
    catchup=False
) as dag:

    t1 = PythonOperator(task_id="create_department_file", python_callable=create_department_file)
    t2 = PythonOperator(task_id="calculate_department_salary", python_callable=calculate_department_salary)
    t3 = PythonOperator(task_id="generate_department_report", python_callable=generate_department_report)

    t1 >> t2 >> t3