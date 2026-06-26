from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def create_inventory():
    with open("/tmp/inventory.txt", "w") as f:
        f.write("Rice,50\n")
        f.write("Oil,7\n")
        f.write("Soap,35\n")
        f.write("Sugar,10\n")
        f.write("Tea,5\n")

def find_low_stock():
    low_stock = []

    with open("/tmp/inventory.txt", "r") as f:
        for line in f:
            item, qty = line.strip().split(",")

            if int(qty) < 15:
                low_stock.append(item)

    with open("/tmp/alerts.txt", "w") as f:
        for item in low_stock:
            f.write(item + "\n")

def generate_alert():
    with open("/tmp/alerts.txt", "r") as f:
        print(f.read())

with DAG(
    dag_id="stock_alert_dag",
    start_date=datetime(2024,1,1),
    schedule="@daily",
    catchup=False
) as dag:

    t1 = PythonOperator(task_id="create_inventory", python_callable=create_inventory)
    t2 = PythonOperator(task_id="find_low_stock", python_callable=find_low_stock)
    t3 = PythonOperator(task_id="generate_alert", python_callable=generate_alert)

    t1 >> t2 >> t3