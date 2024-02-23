{{ config(materialized='table') }}


with trips_data as (
    select * from {{ ref('fact_trips') }}
),
trips_data_fhv as (
    select 'FHV' as service_type, * from {{ ref('fact_trips_fhv') }}
),
trips_unioned as (
    select service_type, pickup_datetime from trips_data
    union all 
    select service_type, pickup_datetime from trips_data_fhv
)
    select 
    service_type,
    {{ dbt.date_trunc("month", "pickup_datetime") }} as _month, 
    count(*) as ride_count

    from trips_unioned
    where {{ dbt.date_trunc("month", "pickup_datetime") }} = '2019-07-01'
    group by 1, 2