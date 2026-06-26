from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def create_attendance():
    with open("/tmp/attendance.txt", "w") as f:
        f.write("Rahul,Present\n")
        f.write("Priya,Present\n")
        f.write("Amit,Absent\n")
        f.write("Sneha,Present\n")
        f.write("Kiran,Absent\n")

def count_present():
    present = 0

    with open("/tmp/attendance.txt", "r") as f:
        for line in f:
            if "Present" in line:
                present += 1

    with open("/tmp/present.txt", "w") as f:
        f.write(str(present))

def count_absent():
    absent = 0

    with open("/tmp/attendance.txt", "r") as f:
        for line in f:
            if "Absent" in line:
                absent += 1

    with open("/tmp/absent.txt", "w") as f:
        f.write(str(absent))

def generate_summary():
    with open("/tmp/present.txt") as f:
        present = f.read()

    with open("/tmp/absent.txt") as f:
        absent = f.read()

    with open("/tmp/attendance_report.txt", "w") as f:
        f.write("Total Students = 5\n")
        f.write(f"Present = {present}\n")
        f.write(f"Absent = {absent}")

with DAG(
    dag_id="attendance_report_dag",
    start_date=datetime(2024,1,1),
    schedule="@daily",
    catchup=False
) as dag:

    t1 = PythonOperator(task_id="create_attendance", python_callable=create_attendance)
    t2 = PythonOperator(task_id="count_present", python_callable=count_present)
    t3 = PythonOperator(task_id="count_absent", python_callable=count_absent)
    t4 = PythonOperator(task_id="generate_summary", python_callable=generate_summary)

    t1 >> t2 >> t3 >> t4