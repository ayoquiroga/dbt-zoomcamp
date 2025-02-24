{{ config(materialized='table') }}

SELECT  EXTRACT(YEAR FROM pickup_datetime) AS year,
EXTRACT(QUARTER FROM pickup_datetime) AS quarter,
service_type, 
SUM(total_amount) AS total_amount_totals,
ROUND(((((SUM(total_amount)-LAG(SUM(total_amount)) OVER (ORDER BY 1)))/ LAG(SUM(total_amount)) OVER (ORDER BY 1))*100), 2) as YoY_rev_percent
FROM {{ ref('fact_trips') }}
WHERE EXTRACT(YEAR FROM pickup_datetime) in (2019,2020)
GROUP BY EXTRACT(YEAR FROM pickup_datetime) , EXTRACT(QUARTER FROM pickup_datetime) , service_type
ORDER BY EXTRACT(YEAR FROM pickup_datetime)  ASC, EXTRACT(QUARTER FROM pickup_datetime)