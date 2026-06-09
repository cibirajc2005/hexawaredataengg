salaries = [45000, 55000, 65000, 75000, 85000]

print("Exercise 1")
print(salaries)

print("Exercise 2")
print(max(salaries))
print(min(salaries))

print("Exercise 3")
print(sum(salaries))

print("Exercise 4")
print(sum(salaries) / len(salaries))

print("Exercise 5")
salaries.append(95000)
salaries.append(105000)
print(salaries)

print("Exercise 6")
salaries.remove(55000)
print(salaries)

print("Exercise 7")
print(sorted(salaries))

print("Exercise 8")
print(sorted(salaries, reverse=True))

print("Exercise 9")
print(sorted(salaries, reverse=True)[1])

print("Exercise 10")
for salary in salaries:
    if salary > 70000:
        print(salary)


employee = (
    101,
    "Rahul Sharma",
    "Data Engineering",
    75000
)

print("Exercise 11")
print(employee)

print("Exercise 12")
print(employee[1])

print("Exercise 13")
print(employee[2])

print("Exercise 14")
emp_id, name, department, salary = employee
print(emp_id)
print(name)
print(department)
print(salary)

print("Exercise 15")
print(len(employee))
print(employee[0])
print(employee[-1])


batch_a = {
    "Rahul",
    "Priya",
    "Amit",
    "Sneha",
    "Farhan"
}

batch_b = {
    "Priya",
    "Sneha",
    "Neha",
    "Arjun",
    "Farhan"
}

print("Exercise 16")
print(batch_a.intersection(batch_b))

print("Exercise 17")
print(batch_a.difference(batch_b))

print("Exercise 18")
print(batch_b.difference(batch_a))

print("Exercise 19")
print(batch_a.union(batch_b))

print("Exercise 20")
print(batch_a.symmetric_difference(batch_b))


employee_info = {
    "employee_id": 101,
    "name": "Rahul Sharma",
    "department": "Data Engineering",
    "salary": 75000,
    "city": "Hyderabad"
}

print("Exercise 21")
print(employee_info["name"])

print("Exercise 22")
print(employee_info["department"])
print(employee_info["city"])

print("Exercise 23")
employee_info["experience"] = 5
print(employee_info)

print("Exercise 24")
employee_info["salary"] = 85000
print(employee_info)

print("Exercise 25")
employee_info.pop("city")
print(employee_info)

print("Exercise 26")
print(employee_info.keys())

print("Exercise 27")
print(employee_info.values())

print("Exercise 28")
print(employee_info.items())


employees = [
    {
        "id": 101,
        "name": "Rahul",
        "department": "IT",
        "salary": 50000
    },
    {
        "id": 102,
        "name": "Priya",
        "department": "HR",
        "salary": 70000
    },
    {
        "id": 103,
        "name": "Amit",
        "department": "IT",
        "salary": 60000
    },
    {
        "id": 104,
        "name": "Sneha",
        "department": "Finance",
        "salary": 80000
    },
    {
        "id": 105,
        "name": "Farhan",
        "department": "IT",
        "salary": 90000
    }
]

print("Exercise 29")
for emp in employees:
    print(emp["name"])

print("Exercise 30")
for emp in employees:
    if emp["department"] == "IT":
        print(emp)

print("Exercise 31")
print(max(employees, key=lambda x: x["salary"]))

print("Exercise 32")
print(min(employees, key=lambda x: x["salary"]))

print("Exercise 33")
total_salary = sum(emp["salary"] for emp in employees)
print(total_salary / len(employees))

print("Exercise 34")
print(total_salary)

print("Exercise 35")
for emp in employees:
    if emp["salary"] > 70000:
        print(emp)

print("Exercise 36")
count = 0
for emp in employees:
    if emp["department"] == "IT":
        count += 1
print(count)

print("Exercise 37")
sorted_employees = sorted(employees, key=lambda x: x["salary"], reverse=True)
for emp in sorted_employees:
    print(emp["name"])

print("Exercise 38")
print(sorted_employees[1])

print("Exercise 39")
departments = set()
for emp in employees:
    departments.add(emp["department"])
print(departments)
