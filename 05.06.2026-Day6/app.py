file = open("employees.txt", "r")
data = file.read()
print("Exercise 1 - Entire File")
print(data)
file.close()

print("\nExercise 2 - Line by Line")

file = open("employees.txt", "r")

for line in file:
    print(line.strip())

file.close()

employees = []

file = open("employees.txt", "r")

for line in file:
    emp = line.strip().split(",")

    emp_data = {
        "id": emp[0],
        "name": emp[1],
        "department": emp[2],
        "salary": int(emp[3]),
        "city": emp[4]
    }

    employees.append(emp_data)

file.close()

print("\nExercise 3")
print("Total Employees =", len(employees))

print("\nExercise 4 - Employee Names")

for emp in employees:
    print(emp["name"])

print("\nExercise 5 - Hyderabad Employees")

for emp in employees:
    if emp["city"] == "Hyderabad":
        print(emp["name"])

print("\nExercise 6 - Bangalore Employees")

for emp in employees:
    if emp["city"] == "Bangalore":
        print(emp["name"])

print("\nExercise 7 - Salary > 80000")

for emp in employees:
    if emp["salary"] > 80000:
        print(emp["name"], emp["salary"])

highest_salary = max(emp["salary"] for emp in employees)

print("\nExercise 8")
print("Highest Salary =", highest_salary)

lowest_salary = min(emp["salary"] for emp in employees)

print("\nExercise 9")
print("Lowest Salary =", lowest_salary)

total_salary = sum(emp["salary"] for emp in employees)
average_salary = total_salary / len(employees)

print("\nExercise 10")
print("Average Salary =", average_salary)

print("\nExercise 11")
print("Total Salary Payout =", total_salary)

ai_count = 0

for emp in employees:
    if emp["department"] == "AI Engineering":
        ai_count += 1

print("\nExercise 12")
print("AI Engineering Employees =", ai_count)

data_eng_count = 0

for emp in employees:
    if emp["department"] == "Data Engineering":
        data_eng_count += 1

print("\nExercise 13")
print("Data Engineering Employees =", data_eng_count)

print("\nExercise 14 - AI Engineering Employees")

for emp in employees:
    if emp["department"] == "AI Engineering":
        print(emp["name"])

file = open("high_salary_employees.txt", "w")

for emp in employees:
    if emp["salary"] > 80000:
        line = f"{emp['id']},{emp['name']},{emp['department']},{emp['salary']},{emp['city']}\n"
        file.write(line)

file.close()

print("\nExercise 15")
print("high_salary_employees.txt created")

file = open("hyderabad_employees.txt", "w")

for emp in employees:
    if emp["city"] == "Hyderabad":
        line = f"{emp['id']},{emp['name']},{emp['department']},{emp['salary']},{emp['city']}\n"
        file.write(line)

file.close()

print("\nExercise 16")
print("hyderabad_employees.txt created")

cities = set()

for emp in employees:
    cities.add(emp["city"])

print("\nExercise 17 - Unique Cities")

for city in cities:
    print(city)

department_count = {}

for emp in employees:
    dept = emp["department"]

    if dept in department_count:
        department_count[dept] += 1
    else:
        department_count[dept] = 1

print("\nExercise 18 - Employees by Department")

for dept, count in department_count.items():
    print(dept, "=", count)

highest_employee = max(employees, key=lambda x: x["salary"])

print("\nExercise 19")
print(highest_employee["name"])
print(highest_employee["salary"])

report = open("employee_report.txt", "w")

report.write("EMPLOYEE REPORT\n")
report.write("====================\n")
report.write(f"Total Employees : {len(employees)}\n")
report.write(f"Highest Salary  : {highest_salary}\n")
report.write(f"Lowest Salary   : {lowest_salary}\n")
report.write(f"Average Salary  : {average_salary}\n")
report.write(f"Total Salary    : {total_salary}\n")

report.close()

print("\nExercise 20")
print("employee_report.txt created")