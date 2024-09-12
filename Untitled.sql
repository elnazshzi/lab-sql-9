-- 1,2. Create the rentals_may Table:

create table rentals_may as 
select * from rental
where extract(month from rental_date) = 5;

-- 3,4. Create the rentals_june Table:

CREATE TABLE rentals_june AS
SELECT * FROM rental
WHERE EXTRACT(MONTH FROM rental_date) = 6;

-- 5. The number of rentals for each customer for May:

select customer_id, count(*) as rentals_may_count
from sakila.rentals_may
group by customer_id;

-- 6. The number of rentals for each customer for June:

select customer_id, count(*) as rentals_june_count
from sakila.rentals_june
group by customer_id;



-- 7. Write a function that checks if customer borrowed more or less films in the month of June as compared to May.

SELECT 
    m.customer_id,
    m.rentals_may_count,
    j.rentals_june_count,
    CASE 
        WHEN j.rentals_june_count > m.rentals_may_count THEN 'More'
        WHEN j.rentals_june_count < m.rentals_may_count THEN 'Less'
        ELSE 'Same'
    END AS status
FROM 
    (SELECT customer_id, COUNT(*) AS rentals_may_count
     FROM rentals_may
     GROUP BY customer_id) AS m
INNER JOIN 
    (SELECT customer_id, COUNT(*) AS rentals_june_count
     FROM rentals_june
     GROUP BY customer_id) AS j
ON m.customer_id = j.customer_id;


