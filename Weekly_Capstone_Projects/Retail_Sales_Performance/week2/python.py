import pandas as pd
import numpy as np

# LOAD DATA
df = pd.read_csv("retail_sales.csv")

# DATA CLEANING
df.drop_duplicates(inplace=True)
df["store_name"] = df["store_name"].astype(str).str.strip()
df["store_name"] = df["store_name"].replace(r'^\s*$', "Unknown Store", regex=True)
df["region"] = df["region"].astype(str).str.strip().str.title()
df["selling_price"] = df["selling_price"].astype(str).str.replace(",", "", regex=False)

numeric_cols = ["quantity", "selling_price", "cost_price", "discount_percent", "returns", "customer_rating"]

for col in numeric_cols:
    df[col] = pd.to_numeric(df[col], errors="coerce")

# VALIDATIONS
df.loc[df["quantity"] < 0, "quantity"] = np.nan
df.loc[(df["discount_percent"] < 0) | (df["discount_percent"] > 100), "discount_percent"] = np.nan
df.loc[(df["customer_rating"] < 1) | (df["customer_rating"] > 5), "customer_rating"] = np.nan

# HANDLE MISSING VALUES
df["quantity"] = df["quantity"].fillna(df["quantity"].median()).astype(int)
df["selling_price"] = df["selling_price"].fillna(df["selling_price"].median())
df["cost_price"] = df["cost_price"].fillna(df["cost_price"].median())
df["discount_percent"] = df["discount_percent"].fillna(df["discount_percent"].median())
df["returns"] = df["returns"].fillna(0)
df["customer_rating"] = df["customer_rating"].fillna(df["customer_rating"].mean())

# DATE CONVERSION
df["sale_date"] = pd.to_datetime(df["sale_date"], errors="coerce")
df = df.dropna(subset=["sale_date"])

# CALCULATIONS
df["revenue"] = df["quantity"] * df["selling_price"]
df["discount_amount"] = df["revenue"] * df["discount_percent"] / 100
df["net_revenue"] = df["revenue"] - df["discount_amount"]
df["total_cost"] = df["quantity"] * df["cost_price"]
df["profit"] = df["net_revenue"] - df["total_cost"]
df["profit_margin"] = np.where(df["net_revenue"] > 0, np.round((df["profit"] / df["net_revenue"]) * 100, 2), 0)

# REVENUE BY PRODUCT SUMMARY
product_summary = df.groupby("product_name")["net_revenue"].sum().sort_values(ascending=False)
print("\n========== REVENUE BY PRODUCT ==========")
print(product_summary)

# REVENUE BY STORE SUMMARY
store_summary = df.groupby("store_name")["net_revenue"].sum().sort_values(ascending=False)
print("\n========== REVENUE BY STORE ==========")
print(store_summary)

# KPI SUMMARY
print("\n========== KPI SUMMARY ==========")
print("Total Revenue :", round(df["net_revenue"].sum(), 2))
print("Total Profit  :", round(df["profit"].sum(), 2))
print("Average Margin :", round(df["profit_margin"].mean(), 2), "%")

# SAVE OUTPUT
df.to_csv("retail_sales_cleaned.csv", index=False)
print("\nCleaned file created successfully.")
