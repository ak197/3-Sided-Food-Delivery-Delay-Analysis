-- Project 3: 3-Sided Food Delivery Analysis
-- Tools: SQLite, DB Browser | Dataset: 25,100 orders
-- Focus: Customer, Restaurant, Courier side delays

-- ===== DAY 1 =====
-- Q1. Customer: Which Weather + Traffic_Level combo causes max delays?
SELECT Weather, Traffic_Level, ROUND(AVG(Delivery_Time_min),1) as Avg_Delivery_Time
FROM Delivery_Orders_3Sided
WHERE Weather IS NOT NULL AND Traffic_Level IS NOT NULL
GROUP BY Weather, Traffic_Level
ORDER BY Avg_Delivery_Time DESC;

-- Q2. Restaurant: Does kitchen slow down in Evening vs Morning?
SELECT Time_of_Day, ROUND(AVG(Preparation_Time_min), 1) as Avg_Prep_Time
FROM Delivery_Orders_3Sided  
GROUP BY Time_of_Day
ORDER BY Avg_Prep_Time DESC;

-- Q3. Courier: Do experienced couriers deliver faster?
SELECT 
  CASE 
    WHEN Courier_Experience_yrs <= 2 THEN '0-2 yrs'
    WHEN Courier_Experience_yrs <= 5 THEN '3-5 yrs' 
    ELSE '6+ yrs'
  END as Experience_Bucket,
  ROUND(AVG(Delivery_Time_min), 1) as Avg_Delivery_Time
FROM Delivery_Orders_3Sided
GROUP BY Experience_Bucket
ORDER BY Avg_Delivery_Time;

-- ===== DAY 2 =====
-- Q4. Top 10 slowest Rainy deliveries
SELECT o.Order_ID, o.Weather, o.Delivery_Time_min, r.Vehicle_Type, COUNT(*) as Order_Count
FROM orders o
JOIN restaurants r ON o.Order_ID = r.Order_ID
WHERE o.Weather = 'Rainy'
GROUP BY o.Order_ID, o.Weather, o.Delivery_Time_min, r.Vehicle_Type
ORDER BY o.Delivery_Time_min DESC
LIMIT 10;

-- ===== DAY 3 =====
-- Q5. Avg delivery time by vehicle type
SELECT r.Vehicle_Type, ROUND(AVG(o.Delivery_Time_min), 2) as Avg_Delivery_Time, COUNT(*) as Order_Count
FROM orders o
JOIN restaurants r ON o.Order_ID = r.Order_ID
GROUP BY r.Vehicle_Type;

-- Q6. Peak vs NonPeak delivery time
SELECT Traffic_Type,
       ROUND(AVG(Delivery_Time_min), 2) as Avg_Delivery_Time,
       COUNT(*) as Order_Count
FROM (
  SELECT o.Delivery_Time_min,
  CASE 
    WHEN o.Time_of_Day IN ('Morning', 'Evening') THEN 'Peak'
    ELSE 'NonPeak'
  END AS Traffic_Type
  FROM orders o
)
GROUP BY Traffic_Type
ORDER BY Avg_Delivery_Time DESC;

-- Q7. Traffic buckets using existing Traffic_Level
SELECT 
    o.Traffic_Level, 
    ROUND(AVG(o.Delivery_Time_min), 2) as Avg_Delivery_Time, 
    COUNT(*) as Order_Count
FROM orders o
GROUP BY o.Traffic_Level;