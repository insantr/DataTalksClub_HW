-- Question 3. Count records
select count(*)
from "green_tripdata"
where lpep_pickup_datetime::date = '2019-09-18'::date
and lpep_dropoff_datetime::date = '2019-09-18'::date;


-- Question 4. Largest trip for each day
select lpep_pickup_datetime::date, sum(trip_distance)
from "green_tripdata"
group by 1
order by 2 desc ;


-- Question 5. Three biggest pickups
select sum(total_amount), pu_t."Borough"
from "green_tripdata"
left join taxi_zone_lookup pu_t on pu_t."LocationID" = "green_tripdata"."PULocationID"
where lpep_pickup_datetime::date = '2019-09-18'::date
group by 2
order by 1 desc;


-- Question 6. Largest tip
select max(tip_amount), do_t."Zone"
from "green_tripdata"
left join taxi_zone_lookup pu_t on pu_t."LocationID" = "green_tripdata"."PULocationID"
left join taxi_zone_lookup do_t on do_t."LocationID" = "green_tripdata"."DOLocationID"
where pu_t."Zone" = 'Astoria'
and date_trunc('month', lpep_pickup_datetime)::date = '2019-09-01'::date
group by 2
order by 1 desc
;


