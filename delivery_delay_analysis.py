"""
Project: 3-Sided Food Delivery Delay Analysis
Tools: Python, Pandas, NumPy
Goal: Identify key factors causing delivery delays > 45 mins
"""

import pandas as pd
import numpy as np

orders = pd.read_csv('orders.csv')
restaurants = pd.read_csv('restaurants.csv') 
couriers = pd.read_csv('couriers.csv')

# This is your SQL JOIN ON Order_ID
df = pd.merge(orders, restaurants, on='Order_ID', how='left')
df = pd.merge(df, couriers, on='Order_ID', how='left')

print("--- Full Dataset Back Together ---")
print(df.head())


# Let’s say > 45 mins = Delayed, like your project
df['delay_status'] = np.where(df['Delivery_Time_min'] > 45, 'Delayed', 'On Time')

print("\n--- Delay Split ---")
print(df['delay_status'].value_counts())


# 1. Weather impact
print("\n--- Delays by Weather ---")

print(df.groupby('Weather')['delay_status'].value_counts())

# 2. Traffic impact  
print("\n--- Delays by Traffic_Level ---")
print(df.groupby('Traffic_Level')['delay_status'].value_counts())

# 3. Courier Experience impact
print("\n--- Avg Delivery Time by Courier Experience ---")
print(df.groupby('Courier_Experience_yrs')['Delivery_Time_min'].mean())


# Export final dataset for dashboard/Excel
df.to_csv('delivery_analysis_results.csv', index=False)
print("\n--- Exported to delivery_analysis_results.csv ---")



import matplotlib.pyplot as plt

# 1. Delays by Weather
delay_by_weather = df.groupby(['Weather','delay_status']).size().unstack()
delay_by_weather.plot(kind='bar', figsize=(8,5), title='Delivery Delays by Weather')
plt.ylabel('Number of Orders')
plt.xticks(rotation=0)
plt.tight_layout()
plt.savefig('chart_weather.png')
plt.show()

# 2. Delays by Traffic 
delay_by_traffic = df.groupby(['Traffic_Level','delay_status']).size().unstack()
delay_by_traffic.plot(kind='bar', figsize=(8,5), title='Delivery Delays by Traffic Level')
plt.ylabel('Number of Orders')
plt.xticks(rotation=0)
plt.tight_layout()
plt.savefig('chart_traffic.png')
plt.show()

# 3. Avg Delivery Time by Courier Experience
df.groupby('Courier_Experience_yrs')['Delivery_Time_min'].mean().plot(
    kind='line', marker='o', figsize=(8,5), title='Avg Delivery Time vs Courier Experience'
)
plt.ylabel('Avg Delivery Time (min)')
plt.xlabel('Courier Experience (years)')
plt.grid(True)
plt.tight_layout()
plt.savefig('chart_experience.png')
plt.show()