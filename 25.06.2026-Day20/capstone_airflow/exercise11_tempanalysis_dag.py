from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def create_temperature_file():
    with open("/tmp/temperature.txt", "w") as f:
        f.write("""Monday,34
Tuesday,36
Wednesday,31
Thursday,38
Friday,35
Saturday,33
Sunday,32""")

def find_highest_temperature():
    temps = []

    with open("/tmp/temperature.txt", "r") as f:
        for line in f:
            _, temp = line.strip().split(",")
            temps.append(int(temp))

    highest = max(temps)
    avg = sum(temps) / len(temps)

    with open("/tmp/weather_stats.txt", "w") as f:
        f.write(f"{highest},{avg}")

def generate_weather_report():
    with open("/tmp/weather_stats.txt", "r") as f:
        highest, avg = f.read().split(",")

    with open("/tmp/weather_report.txt", "w") as f:
        f.write(f"Highest Temperature = {highest}\n")
        f.write(f"Average Temperature = {avg}\n")

with DAG(
    dag_id="exercise11_temperature_analysis",
    start_date=datetime(2024,1,1),
    schedule=None,
    catchup=False
) as dag:

    t1 = PythonOperator(task_id="create_temperature_file", python_callable=create_temperature_file)
    t2 = PythonOperator(task_id="find_highest_temperature", python_callable=find_highest_temperature)
    t3 = PythonOperator(task_id="generate_weather_report", python_callable=generate_weather_report)

    t1 >> t2 >> t3