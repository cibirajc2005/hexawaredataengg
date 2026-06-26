from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def create_file():
    with open("/tmp/message.txt", "w") as f:
        f.write("Welcome to Apache Airflow\n")
        f.write("Learning DAGs\n")
        f.write("Learning Task Dependencies\n")

def read_file():
    with open("/tmp/message.txt", "r") as f:
        print(f.read())

with DAG(
    dag_id="exercise1_file_read_dag",
    start_date=datetime(2024,1,1),
    schedule="@daily",
    catchup=False
) as dag:

    task1 = PythonOperator(
        task_id="create_file",
        python_callable=create_file
    )

    task2 = PythonOperator(
        task_id="read_file",
        python_callable=read_file
    )

    task1 >> task2