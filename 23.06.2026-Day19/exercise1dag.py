from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime


def create_csv():
    with open("/tmp/sales.csv", "w") as f:
        f.write("product,quantity,price\n")
        f.write("Laptop,2,70000\n")
        f.write("Mouse,5,500\n")
        f.write("Keyboard,3,1200\n")


def read_csv():
    with open("/tmp/sales.csv", "r") as f:
        print(f.read())


def calculate_revenue():
    total_revenue = 0

    with open("/tmp/sales.csv", "r") as f:
        next(f)  # Skip header

        for line in f:
            product, quantity, price = line.strip().split(",")

            revenue = int(quantity) * int(price)

            print(f"{product} = {revenue}")

            total_revenue += revenue

    with open("/tmp/revenue.txt", "w") as f:
        f.write(str(total_revenue))


def create_summary():
    with open("/tmp/revenue.txt", "r") as f:
        total = f.read()

    with open("/tmp/summary.txt", "w") as f:
        f.write("Laptop = 140000\n")
        f.write("Mouse = 2500\n")
        f.write("Keyboard = 3600\n")
        f.write(f"Total Revenue = {total}\n")


with DAG(
    dag_id="csv_processing_dag",
    start_date=datetime(2024, 1, 1),
    schedule="@daily",
    catchup=False
) as dag:

    create_csv_task = PythonOperator(
        task_id="create_csv",
        python_callable=create_csv
    )

    read_csv_task = PythonOperator(
        task_id="read_csv",
        python_callable=read_csv
    )

    calculate_revenue_task = PythonOperator(
        task_id="calculate_revenue",
        python_callable=calculate_revenue
    )

    create_summary_task = PythonOperator(
        task_id="create_summary",
        python_callable=create_summary
    )

    create_csv_task >> read_csv_task >> calculate_revenue_task >> create_summary_task