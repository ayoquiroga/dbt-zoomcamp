
SELECT DISTINCT 
    service_type

FROM {{ ref('fact_trips') }}
