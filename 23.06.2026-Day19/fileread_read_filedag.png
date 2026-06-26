from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def create_marks_file():
    with open("/tmp/marks.txt", "w") as f:
        f.write("Math,80\n")
        f.write("Science,75\n")
        f.write("English,90\n")
        f.write("Python,95\n")

def calculate_average():
    total = 0
    count = 0

    with open("/tmp/marks.txt", "r") as f:
        for line in f:
            total += int(line.strip().split(",")[1])
            count += 1

    avg = total / count

    with open("/tmp/average.txt", "w") as f:
        f.write(str(avg))

    print("Average =", avg)

def generate_result():
    with open("/tmp/average.txt", "r") as f:
        avg = float(f.read())

    with open("/tmp/result.txt", "w") as f:
        f.write(f"Average Marks = {avg}\n")
        f.write("Result = PASS")

with DAG(
    dag_id="student_marks_processing_dag",
    start_date=datetime(2024,1,1),
    schedule="@daily",
    catchup=False
) as dag:

    t1 = PythonOperator(task_id="create_marks_file", python_callable=create_marks_file)
    t2 = PythonOperator(task_id="calculate_average", python_callable=calculate_average)
    t3 = PythonOperator(task_id="generate_result", python_callable=generate_result)

    t1 >> t2 >> t3