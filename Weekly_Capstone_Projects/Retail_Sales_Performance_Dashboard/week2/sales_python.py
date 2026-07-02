import pandas as pd
import numpy as np

df = pd.read_csv("sales.csv")

df = df.dropna(subset=["store_id", "product_id", "quantity", "price"])
df["quantity"] = df["quantity"].astype(int)
df["price"] = df["price"].astype(float)
df["cost"] = df["cost"].astype(float)
df["discount_percent"] = df["discount_percent"].fillna(0)

df["revenue"] = df["quantity"] * df["price"] * (1 - df["discount_percent"] / 100)
df["profit"] = df["revenue"] - (df["quantity"] * df["cost"])
df["profit_margin"] = np.where(df["revenue"] > 0, df["profit"] / df["revenue"] * 100, 0)

product_summary = df.groupby("product_id")[["revenue", "profit"]].sum()
store_summary = df.groupby("store_id")[["revenue", "profit"]].sum()

print(product_summary)
print(store_summary)

df.to_csv("cleaned_sales.csv", index=False)
product_summary.to_csv("product_revenue_summary.csv")
store_summary.to_csv("store_revenue_summary.csv")
