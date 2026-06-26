from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def create_enrollment_file():
    with open("/tmp/enrollments.txt", "w") as f:
        f.write("""Python,Rahul
Python,Priya
SQL,Amit
Python,Sneha
Power BI,Kiran
SQL,Megha
Power BI,Arjun""")

def count_students():
    courses = {}

    with open("/tmp/enrollments.txt", "r") as f:
        for line in f:
            course, _ = line.strip().split(",")
            courses[course] = courses.get(course, 0) + 1

    with open("/tmp/course_counts.txt", "w") as f:
        for course, count in courses.items():
            f.write(f"{course}={count}\n")

def generate_course_report():
    with open("/tmp/course_counts.txt", "r") as src:
        data = src.read()

    with open("/tmp/course_report.txt", "w") as f:
        f.write("Course Enrollment Report\n")
        f.write(data)

with DAG(
    dag_id="exercise14_course_enrollment",
    start_date=datetime(2024,1,1),
    schedule=None,
    catchup=False
) as dag:

    t1 = PythonOperator(task_id="create_enrollment_file", python_callable=create_enrollment_file)
    t2 = PythonOperator(task_id="count_students", python_callable=count_students)
    t3 = PythonOperator(task_id="generate_course_report", python_callable=generate_course_report)

    t1 >> t2 >> t3