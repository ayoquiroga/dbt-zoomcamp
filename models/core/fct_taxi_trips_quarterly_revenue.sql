{{ config(materialized='table') }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
)
    select 
    -- Reveneue grouping 
    {{ dbt.date_trunc("year", "pickup_datetime") }} as revenue_year, 
    {{ dbt.date_trunc("quarter", "pickup_datetime") }} as revenue_quarter, 
    service_type, 
    -- Revenue calculation 
    sum(total_amount) as revenue_monthly_total_amount,
    from trips_data
    where EXTRACT(YEAR FROM pickup_datetime) in (2019, 2020)
    group by 1,2,3
    order by 1,2,3 desc