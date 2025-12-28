-- Exploratory Data Analysis on Wine dataset --

-- 1) Query columns from the wine table with a limit of getting only 20 records.
SELECT*
FROM wine_schema.wine_table
LIMIT 20

-- 2) What are the distinct wine types ?
SELECT DISTINCT type
FROM wine_schema.wine_table

-- 3) Calculate the number of distinct wine types.
SELECT COUNT(DISTINCT type) AS Num_wine_types
FROM wine_schema.wine_table

-- 4) Calculate the number of distinct countries producing Sparkling wines.
SELECT COUNT(DISTINCT Country) AS distinct_countries
FROM wine_schema.wine_table
WHERE type ='Sparkling'

-- 5) List the number of wines produced per country in descending order.
SELECT Country, COUNT(DISTINCT Name) AS distinct_wines  
FROM wine_schema.wine_table  
GROUP BY 1 
ORDER BY 2 DESC 

-- 6) What is the average price per each wine type? Round the number to 2 decimal places and order the average price result in ascending order.  
SELECT type, ROUND(AVG(Price),2) AS avg_price 
FROM wine_schema.wine_table  
GROUP BY 1 
ORDER BY 2

-- 7) What is the average price by year? Order the result in ascending order based on the Year. Exclude NULL values in the Year column from the group-level result.   
SELECT Year, ROUND(AVG(Price),2) AS avg_price 
FROM wine_schema.wine_table  
GROUP BY 1 
HAVING Year IS NOT NULL
ORDER BY 1 

-- 8) What are the average price and average rating by country? Order by the Country name.  
SELECT Country, ROUND(AVG(Price),2) AS avg_price , ROUND(AVG(Rating),2) AS avg_rating  
FROM wine_schema.wine_table  
GROUP BY 1 
ORDER BY 1 

-- 9) What are the average price and average rating by year for Italy? Exclude NULL values in the Year column from the raw table before grouping.   
SELECT Year, ROUND(AVG(Price),2) AS avg_price , ROUND(AVG(Rating),2) AS avg_rating  
FROM wine_schema.wine_table  
WHERE Country = 'Italy' 
GROUP BY 1 
ORDER BY 1 

-- 10) What is the average price by country and by region in each country for the following countries: Argentina, Canada, Italy, Greece? Order the result based on the Country ascending and secondly based on the average price in a region descending.   
SELECT Country, Region, ROUND(AVG(Price),2) AS avg_price_region   
FROM wine_schema.wine_table  
WHERE Country IN ('Argentina', 'Canada', 'Italy', 'Greece') 
GROUP BY 1, 2 
ORDER BY 1, 3 DESC 

-- 11) How many wines are available per each rating? 
SELECT Rating, COUNT(DISTINCT Name) AS amount_wines  
FROM wine_schema.wine_table  
GROUP BY 1 
ORDER BY 1 

-- 12) How many wines of each wine type were produced in each country? 
SELECT Country, Type, COUNT(DISTINCT Name) AS amount_wines  
FROM wine_schema.wine_table  
GROUP BY 1, 2  
ORDER BY 1, 2 

-- 13) What is the maximum price per each wine type excluding the following years – 2011, 2013, 2015, 2018)? Order by maximum price in descending order.  
SELECT Type, MAX(Price) AS max_price 
FROM wine_schema.wine_table  
WHERE Year NOT IN ('2011','2013','2015','2018') 
GROUP BY 1  
	ORDER BY 2 DESC 	 

-- 14) What are the names and country locations of the top 10 red wines with the highest rating? 
SELECT Type, Name, Country, Rating  
FROM wine_schema.wine_table  
WHERE Type = 'Red' 
ORDER BY Rating DESC 
LIMIT 10 

-- 15) List the 10 top Wineries in France that have the highest rating excluding wines with a number of reviews below 200.  
SELECT Winery, Rating   
FROM wine_schema.wine_table  
WHERE (Country = 'France' AND numofrating >= 200) 
ORDER BY Rating DESC 
LIMIT 10 

-- 16) Which group of wine types has the highest average rating for wines that were produced between 2000 and 2010 or between 2015 and 2020. 
SELECT Type, ROUND(AVG(Rating),2) AS avg_rating 
FROM wine_schema.wine_table  
WHERE (Year BETWEEN 2000 AND 2010) OR (Year BETWEEN 2015 AND 2020) 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 1 
 	 
-- 17) What are the five top countries with the highest average rating for wines that are above the price of 20 Euro? 
SELECT Country, ROUND(AVG(Rating),2) AS avg_rating 
FROM wine_schema.wine_table  
WHERE PRICE > 20 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 5 
-- 18) What are the top 20 regions that produce the highest number of wines with a minimum of 50 wines, where the price of a wine is below 300 EURO, and the number of rating reviews for the wine is more than 100?  
SELECT Region, COUNT(Name) AS amount_wines 
FROM wine_schema.wine_table 
WHERE Price < 300 AND numofrating > 100 
GROUP BY 1 
HAVING COUNT(Name) > 100 
ORDER BY 2 DESC 
LIMIT 20 
