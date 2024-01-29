-- Question 3. Count records
-- This query counts the number of records (trips) in the "green_tripdata" table
-- where both pickup and dropoff dates are '2019-09-18'.
select count(*)
from "green_tripdata"
where lpep_pickup_datetime::date = '2019-09-18'::date
and lpep_dropoff_datetime::date = '2019-09-18'::date;

-- Question 4. Largest trip for each day
-- This query calculates the total trip distance for each day, summing up all the distances
-- recorded in the "green_tripdata" table, and then orders the results by this sum in descending order.
select lpep_pickup_datetime::date, sum(trip_distance)
from "green_tripdata"
group by 1
order by 2 desc;

-- Question 5. Three biggest pickups
-- This query sums the total amount spent for trips and groups them by the Borough of pickup location.
-- It filters for trips on '2019-09-18' and then orders the results by the sum of total_amount in descending order.
select sum(total_amount), pu_t."Borough"
from "green_tripdata"
left join taxi_zone_lookup pu_t on pu_t."LocationID" = "green_tripdata"."PULocationID"
where lpep_pickup_datetime::date = '2019-09-18'::date
group by 2
order by 1 desc;

-- Question 6. Largest tip
-- This query finds the maximum tip amount for trips starting in the 'Astoria' zone in September 2019.
-- It joins with the "taxi_zone_lookup" table twice to get the pickup and dropoff location details.
-- Results are grouped by the dropoff zone and ordered by the maximum tip amount in descending order.
select max(tip_amount), do_t."Zone"
from "green_tripdata"
left join taxi_zone_lookup pu_t on pu_t."LocationID" = "green_tripdata"."PULocationID"
left join taxi_zone_lookup do_t on do_t."LocationID" = "green_tripdata"."DOLocationID"
where pu_t."Zone" = 'Astoria'
and date_trunc('month', lpep_pickup_datetime)::date = '2019-09-01'::date
group by 2
order by 1 desc;
