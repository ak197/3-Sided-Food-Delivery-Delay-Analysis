# 3-Sided Food Delivery Performance Dashboard

**Analyzed 25,100 orders across Customer, Restaurant, and Courier to find delivery delay drivers**

### Tech Stack
Excel, Python Scripts(Pandas, NumPy, Matplotlib), SQL

### Key Insights
- Rainy + High traffic = 77 min avg delivery vs Clear + Medium = 49.9 min → 27.1 min delay spike
- Kitchen timing shows only a 0.6-0.8 min difference → kitchen NOT the main bottleneck  
- Courier time 38.5 min, the highest variation driver

### Files
- `delivery_delay_analysis.py` - Python analysis: Pandas merge, NumPy logic, Matplotlib charts
- `queries_project3.sql` - 7 SQL queries with GROUP BY, JOIN, CASE
- `chart_q1_weather.png`, `chart_q2_kitchen.png`, `chart_q3_courier.png` - Excel charts from initial EDA
- `chart_weather.png`, `chart_traffic.png`, `chart_experience.png` - Matplotlib charts from Python analysis
- `delivery_analysis_results.csv` - Final dataset exported from Python
- `Ankita_Kundu_DataAnalyst_Jun2026.pdf` - Updated resume

### Business Impact
Findings recommend traffic-based dispatch and weather-surge pricing to reduce delays.
