# Sylvia Guzikowski
# IS362, Assignment 1

# 1) How many airplanes have listed speeds? 
# 	 What is the minimum listed speed and the maximum listed speed?

# How many airplanes have listed speeds? 23
SELECT COUNT(*) FROM PLANES 
WHERE speed IS NOT NULL;

# What is the minimum listed speed and the maximum listed speed? min: 90, max: 432
SELECT max(speed) FROM PLANES;
SELECT min(speed) FROM PLANES;

# 2) What is the total distance flown by all of the planes in January 2013? 
#    What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?

# What is the total distance flown by all of the planes in January 2013? 2718805
SELECT sum(distance) FROM flights 
WHERE year=2013 AND month=1;

# What is the total distance flown by all of the planes in January 2013 where the tailnum is missing? 81763
SELECT sum(distance) FROM flights 
WHERE year=2013 AND month=1 AND tailnum IS NULL;

# 3) What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? 
#    Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?

# What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer?  Write this statement first using an INNER JOIN
SELECT sum(distance), manufacturer FROM flights 
INNER JOIN planes on flights.tailnum = planes.tailnum 
WHERE month=7 AND day=5 AND flights.year=2013 GROUP BY manufacturer;

# ...using a LEFT OUTER JOIN. 
SELECT sum(distance), manufacturer FROM planes 
LEFT OUTER JOIN flights on flights.tailnum = planes.tailnum 
WHERE month=7 AND day=5 AND flights.year=2013 GROUP BY manufacturer;

# How do your results compare?
# The results themselves seem the same, however the run time for the left outer join took much longer.

# 4) Write and answer at least one question of your own choosing that joins information from at least three of the tables in the flights database.

# Find the top 5 distinct flights that covered the most distance, where they originated from, where they landed, and the destination airport name.
SELECT DISTINCT 
f.distance, LEAST(f.origin, f.dest) AS origination, GREATEST(f.origin, f.dest) AS destination 
FROM flights as f
INNER JOIN airports ON f.dest = airports.faa
ORDER BY distance DESC LIMIT 5;