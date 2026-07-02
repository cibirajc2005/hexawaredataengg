import pandas as pd
import numpy as np

df = pd.read_csv("attendance.csv")

df = df.dropna(subset=["clockin", "clockout"])
df = df[df["employeeid"].notnull()]

df["clockin"] = pd.to_datetime(df["clockin"])
df["clockout"] = pd.to_datetime(df["clockout"])

df["workhours"] = (df["clockout"] - df["clockin"]).dt.total_seconds() / 3600
df["breaktime"] = np.where(df["workhours"] > 8, df["workhours"] - 8, 0)
df["productivityscore"] = df["taskscompleted"] / df["workhours"]

summary = df.groupby("employeeid")["workhours", "productivityscore"].mean()
print(summary)

top_performers = df.groupby("employeeid")["productivityscore"].mean().sort_values(ascending=False).head(5)
print(top_performers)

frequent_absentees = df[df["status"] == "Absent"].groupby("employeeid").size().sort_values(ascending=False)
print(frequent_absentees)

df.to_csv("cleaned_attendance.csv", index=False)
summary.to_csv("performance_report.csv")
