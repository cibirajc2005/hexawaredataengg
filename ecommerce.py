import csv
import numpy as np
import pandas as pd
from collections import defaultdict

orders = []

def read_orders_file(filename):

    try:
        with open(filename, mode='r', newline='', encoding='utf-8') as file:

            reader = csv.DictReader(file)

            for row in reader:

                try:
                    row['quantity'] = int(str(row['quantity']).strip())
                    row['price'] = float(str(row['price']).strip())

                    row['revenue'] = row['quantity'] * row['price']

                    orders.append(row)

                except:
                    print("Invalid row found")
                    print(row)

        print("CSV File Loaded Successfully")

    except FileNotFoundError:
        print("orders.csv file not found")

read_orders_file("orders.csv")

def display_all_orders():
    for order in orders:
        print(order)

def count_total_orders():
    return len(orders)

def calculate_total_revenue():
    return sum(order['revenue'] for order in orders)

def highest_order_value():
    return max(order['revenue'] for order in orders)

def lowest_order_value():
    return min(order['revenue'] for order in orders)

def find_average_order_value():
    if count_total_orders() == 0:
        return 0

    return calculate_total_revenue() / count_total_orders()

def display_unique_customers():
    customers = set()

    for order in orders:
        customers.add(order['customer_name'])

    for customer in customers:
        print(customer)

def count_unique_customers():
    customers = set()

    for order in orders:
        customers.add(order['customer_name'])

    return len(customers)

def customer_with_highest_purchase():
    customer_revenue = defaultdict(float)

    for order in orders:
        customer_revenue[order['customer_name']] += order['revenue']

    top_customer = max(customer_revenue, key=customer_revenue.get)

    return top_customer, customer_revenue[top_customer]

def count_orders_by_product():
    product_count = defaultdict(int)

    for order in orders:
        product_count[order['product']] += 1

    return dict(product_count)

def revenue_by_product():
    product_revenue = defaultdict(float)

    for order in orders:
        product_revenue[order['product']] += order['revenue']

    return dict(product_revenue)

def find_top_product():
    quantity_dict = defaultdict(int)

    for order in orders:
        quantity_dict[order['product']] += order['quantity']

    top_product = max(quantity_dict, key=quantity_dict.get)

    return top_product, quantity_dict[top_product]

def find_least_sold_product():
    quantity_dict = defaultdict(int)

    for order in orders:
        quantity_dict[order['product']] += order['quantity']

    least_product = min(quantity_dict, key=quantity_dict.get)

    return least_product, quantity_dict[least_product]

def revenue_by_category():
    category_revenue = defaultdict(float)

    for order in orders:
        category_revenue[order['category']] += order['revenue']

    return dict(category_revenue)

def count_orders_by_city():
    city_count = defaultdict(int)

    for order in orders:
        city_count[order['city']] += 1

    return dict(city_count)

def revenue_by_city():
    city_revenue = defaultdict(float)

    for order in orders:
        city_revenue[order['city']] += order['revenue']

    return dict(city_revenue)

def find_top_city():
    city_revenue = revenue_by_city()

    top_city = max(city_revenue, key=city_revenue.get)

    return top_city, city_revenue[top_city]

def product_list():
    products = [order['product'] for order in orders]
    products.sort()

    return products

def unique_cities():
    return {order['city'] for order in orders}

def city_revenue_dictionary():
    return revenue_by_city()

def product_quantity_dictionary():
    product_quantity = defaultdict(int)

    for order in orders:
        product_quantity[order['product']] += order['quantity']

    return dict(product_quantity)

def numpy_analysis():
    order_values = np.array([order['revenue'] for order in orders])

    print("Total Revenue:", np.sum(order_values))
    print("Average Revenue:", np.mean(order_values))
    print("Maximum Revenue:", np.max(order_values))
    print("Minimum Revenue:", np.min(order_values))
    print("Standard Deviation:", np.std(order_values))

def pandas_analysis():
    try:
        df = pd.read_csv("orders.csv")

        df['Revenue'] = df['quantity'] * df['price']

        print("\nTop 5 Highest Value Orders")
        print(df.sort_values(by='Revenue', ascending=False).head())

        print("\nRevenue By City")
        print(df.groupby('city')['Revenue'].sum())

        print("\nRevenue By Product")
        print(df.groupby('product')['Revenue'].sum())

        print("\nTop Selling Products")
        print(df.groupby('product')['quantity'].sum().sort_values(ascending=False))

        print("\nCity Wise Order Count")
        print(df.groupby('city')['order_id'].count())

    except FileNotFoundError:
        print("orders.csv file not found")

def generate_report():
    with open("sales_summary_report.txt", "w") as file:

        file.write(f"Total Orders: {count_total_orders()}\n")
        file.write(f"Total Revenue: {calculate_total_revenue()}\n")
        file.write(f"Average Order Value: {find_average_order_value()}\n")
        file.write(f"Highest Order Value: {highest_order_value()}\n")
        file.write(f"Lowest Order Value: {lowest_order_value()}\n")

        file.write("\nRevenue By City\n")

        for city, revenue in revenue_by_city().items():
            file.write(f"{city}: {revenue}\n")

        file.write("\nRevenue By Category\n")

        for category, revenue in revenue_by_category().items():
            file.write(f"{category}: {revenue}\n")

        top_product, qty = find_top_product()
        file.write(f"\nTop Selling Product: {top_product} ({qty})\n")

        top_city, revenue = find_top_city()
        file.write(f"Top Revenue City: {top_city} ({revenue})\n")

    print("sales_summary_report.txt generated")

def generate_high_value_orders():
    try:
        df = pd.read_csv("orders.csv")

        df['Revenue'] = df['quantity'] * df['price']

        high_value = df[df['Revenue'] > 50000]

        high_value.to_csv("high_value_orders.csv", index=False)

        print("high_value_orders.csv generated")

    except FileNotFoundError:
        print("orders.csv file not found")

def generate_electronics_orders():
    try:
        df = pd.read_csv("orders.csv")

        electronics = df[df['category'] == 'Electronics']

        electronics.to_csv("electronics_orders.csv", index=False)

        print("electronics_orders.csv generated")

    except FileNotFoundError:
        print("orders.csv file not found")

def revenue_analysis_menu():
    print("Total Revenue:", calculate_total_revenue())
    print("Highest Order Value:", highest_order_value())
    print("Lowest Order Value:", lowest_order_value())
    print("Average Order Value:", find_average_order_value())

def product_analysis_menu():
    print("Orders By Product")
    print(count_orders_by_product())

    print("Revenue By Product")
    print(revenue_by_product())

    print("Top Product")
    print(find_top_product())

    print("Least Sold Product")
    print(find_least_sold_product())

def city_analysis_menu():
    print("Orders By City")
    print(count_orders_by_city())

    print("Revenue By City")
    print(revenue_by_city())

    print("Top Revenue City")
    print(find_top_city())

def export_reports_menu():
    generate_report()
    generate_high_value_orders()
    generate_electronics_orders()

def main():

    while True:

        print("\nE-COMMERCE ORDER ANALYTICS SYSTEM")
        print("1. View Orders")
        print("2. Revenue Analysis")
        print("3. Product Analysis")
        print("4. City Analysis")
        print("5. Export Reports")
        print("6. Pandas Analysis")
        print("7. NumPy Analysis")
        print("8. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            display_all_orders()

        elif choice == '2':
            revenue_analysis_menu()

        elif choice == '3':
            product_analysis_menu()

        elif choice == '4':
            city_analysis_menu()

        elif choice == '5':
            export_reports_menu()

        elif choice == '6':
            pandas_analysis()

        elif choice == '7':
            numpy_analysis()

        elif choice == '8':
            print("Program Ended")
            break

        else:
            print("Invalid Choice")

main()