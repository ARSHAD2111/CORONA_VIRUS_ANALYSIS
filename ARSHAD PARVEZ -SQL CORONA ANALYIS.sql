SELECT * FROM corona_virus_dataset;

-- Step 1: Add a new DATE column
ALTER TABLE corona_virus_dataset ADD COLUMN Date_converted DATE;

-- Step 2: Update the new column with converted dates
UPDATE corona_virus_dataset 
SET Date_converted = STR_TO_DATE(Date_s, '%m/%d/%Y');

-- Step 3: Verify the conversion (optional)
SELECT Date_s, Date_converted 
FROM corona_virus_dataset 
LIMIT 10;

-- Step 4: Drop the old column (optional)
ALTER TABLE corona_virus_dataset DROP COLUMN Date_s;

-- Step 5: Rename the new column to the original column name
ALTER TABLE corona_virus_dataset 
CHANGE  COLUMN Date_converted  Date_s DATE;


DESCRIBE corona_virus_dataset;


-- Q1. Write a code to check NULL values
SELECT * FROM corona_virus_dataset
WHERE Province IS NULL OR 
'Country/Region' IS NULL OR
Latitude IS NULL OR
Longitude IS NULL OR
Date_s IS NULL OR
Confirmed IS NULL OR
Deaths IS NULL OR
Recovered IS NULL;


-- Q2. If NULL values are present, update them with zeros for all columns. 


-- Q3. check total number of rows
SELECT COUNT(*) AS TOTAL_NO_OF_ROWS
FROM corona_virus_dataset;


-- Q4. Check what is start_date and end_date
SELECT MIN(DATE_S) as START_DATE,max(Date_s) AS END_DATE
FROM corona_virus_dataset;


-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT EXTRACT(MONTH FROM DATE_S)) AS NO_OF_MONTHS_IN_DATASET,
extract(year from date_s)as year
FROM corona_virus_dataset
group by year;


-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT EXTRACT(MONTH FROM DATE_S) AS MONTH,
EXTRACT(YEAR FROM date_s) AS year,
AVG(Confirmed) AS AVERAGE,
AVG(Recovered) AS RECOVERED,
AVG(Deaths) AS DEATHS
FROM corona_virus_dataset
GROUP BY month,year
ORDER BY MONTH;


-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
SELECT 
    EXTRACT(MONTH FROM Date_s) AS MONTH,EXTRACT(year FROM Date_s) AS YEAR,
    max(Confirmed) AS most_frequent_confirmed,
    max(Deaths) AS most_frequent_deaths,
    max(Recovered) AS most_frequent_recovered
FROM 
    corona_virus_dataset
GROUP BY 
    EXTRACT(MONTH FROM Date_s),extract(year from date_s);


-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT 
    EXTRACT(year FROM Date_s) AS year,
    min(Confirmed) AS min_confirmed,
    min(Deaths) AS min_deaths,
    min(Recovered) AS min_recovered
FROM 
    corona_virus_dataset
GROUP BY 
    EXTRACT(year FROM Date_s);
    
    
-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    EXTRACT(year FROM Date_s) AS year,
    max(Confirmed) AS max_confirmed,
    max(Deaths) AS max_deaths,
    max(Recovered) AS max_recovered
FROM 
    corona_virus_dataset
GROUP BY 
    EXTRACT(year FROM Date_s);
    
    
-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT 
    EXTRACT(month FROM Date_s) AS month,
    EXTRACT(year FROM Date_s) AS year,
    sum(Confirmed) AS total_confirmed,
    sum(Deaths) AS total_deaths,
    sum(Recovered) AS total_recovered
FROM 
    corona_virus_dataset
GROUP BY 
    EXTRACT(month FROM Date_s),EXTRACT(year FROM Date_s) ;
    

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

-- Calculate total confirmed cases
SELECT SUM(Confirmed) AS total_confirmed_cases
FROM corona_virus_dataset;

-- Calculate average confirmed cases
SELECT AVG(Confirmed) AS average_confirmed_cases
FROM corona_virus_dataset;

-- Calculate variance of confirmed cases
SELECT VARIANCE(Confirmed) AS variance_confirmed_cases
FROM corona_virus_dataset;

-- Calculate standard deviation of confirmed cases
SELECT STDDEV(Confirmed) AS stdev_confirmed_cases
FROM corona_virus_dataset;


-- Q12. Check how corona virus spread out with respect to death case per month
-- (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    EXTRACT(YEAR FROM date_s) AS year,
    EXTRACT(MONTH FROM date_s) AS month,
    SUM(deaths) AS total_deaths,
    AVG(deaths) AS avg_deaths,
    VARIANCE(deaths) AS variance_deaths,
    STDDEV(deaths) AS stdev_deaths
FROM corona_virus_dataset
GROUP BY EXTRACT(YEAR FROM date_s), EXTRACT(MONTH FROM date_s);


-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

-- Calculate total recovered cases
SELECT SUM(Recovered) AS total_recovered_cases
FROM corona_virus_dataset;

-- Calculate average recovered cases
SELECT AVG(Recovered) AS average_recovered_cases
FROM corona_virus_dataset;

-- Calculate variance of recovered cases
SELECT VARIANCE(Recovered) AS variance_recovered_cases
FROM corona_virus_dataset;

-- Calculate standard deviation of recovered cases
SELECT STDDEV(Recovered) AS stdev_recovered_cases
FROM corona_virus_dataset;


-- Q14. Find Country having highest number of the Confirmed case
SELECT `Country/Region`, max(Confirmed) as max_confirmed_case
FROM corona_virus_dataset
GROUP BY `Country/Region`
order by max(Confirmed) DESC
limit 1;


-- Q15. Find Country having lowest number of the death case
SELECT `Country/Region`, SUM(Deaths)
FROM corona_virus_dataset
GROUP BY `Country/Region`
ORDER BY SUM(Deaths)
LIMIT 1;


-- Q16. Find top 5 countries having highest recovered case
SELECT `Country/Region`, SUM(Recovered) as highest_recorded
FROM corona_virus_dataset
GROUP BY `Country/Region`
ORDER BY SUM(Recovered) DESC
LIMIT 5;




