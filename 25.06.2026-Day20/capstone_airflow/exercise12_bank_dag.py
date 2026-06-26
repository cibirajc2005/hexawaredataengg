from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def create_transactions():
    with open("/tmp/transactions.txt", "w") as f:
        f.write("""Deposit,10000
Withdraw,2500
Deposit,4000
Withdraw,1500
Deposit,2000""")

def calculate_balance():
    deposit = 0
    withdrawal = 0

    with open("/tmp/transactions.txt", "r") as f:
        for line in f:
            action, amount = line.strip().split(",")

            if action == "Deposit":
                deposit += int(amount)
            else:
                withdrawal += int(amount)

    balance = deposit - withdrawal

    with open("/tmp/account_stats.txt", "w") as f:
        f.write(f"{deposit},{withdrawal},{balance}")

def generate_account_report():
    with open("/tmp/account_stats.txt", "r") as f:
        deposit, withdrawal, balance = f.read().split(",")

    with open("/tmp/account_report.txt", "w") as f:
        f.write(f"Total Deposit = {deposit}\n")
        f.write(f"Total Withdrawal = {withdrawal}\n")
        f.write(f"Final Balance = {balance}\n")

with DAG(
    dag_id="exercise12_bank_transaction",
    start_date=datetime(2024,1,1),
    schedule=None,
    catchup=False
) as dag:

    t1 = PythonOperator(task_id="create_transactions", python_callable=create_transactions)
    t2 = PythonOperator(task_id="calculate_balance", python_callable=calculate_balance)
    t3 = PythonOperator(task_id="generate_account_report", python_callable=generate_account_report)

    t1 >> t2 >> t3