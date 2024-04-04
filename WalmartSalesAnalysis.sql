 Create  DATABASE IF NOT EXISTS salesdatawalmart;
 
 CREATE TABLE IF NOT EXISTS sales(
 invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
 branch VARCHAR (5) NOT NULL ,
  city VARCHAR (30) NOT NULL ,
  customer_type VARCHAR(30) NOT NULL ,
  gender VARCHAR (10) NOT NULL ,
  Product_line	VARCHAR (100) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
  vat FLOAT(6,4) NOT NULL,
  total DECIMAL(12,4) NOT NULL,
  date DATETIME NOT NULL,
  time TIME NOT NULL,
  payment_method VARCHAR(15) NOT NULL,
  cogs DECIMAL(10,2) NOT NULL,
  gross_margin_percentage FLOAT(11,9) NOT NULL,
  gross_income DECIMAL(12,2) NOT NULL,
  rating DECIMAL(2,1) NOT NULL
 );
 
 SELECT * FROM salesdatawalmart.sales;
SELECT 
 time,
 (
 CASE 
  WHEN  `time` BETWEEN  "00:00:00"  AND "12:00:00" THEN  "Morning"
  WHEN  `time` BETWEEN  "12:01:00"  AND "16:00:00" THEN  "Afternoon"
ELSE "Evening"
 END  ) AS time_of_date
FROM sales;
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20) NOT NULL;

SELECT * FROM salesdatawalmart.sales;

UPDATE sales 
SET time_of_day = (
CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END);
    SELECT
    date,
    DAYNAME(date)
    FROM sales;
    
     ALTER TABLE sales ADD COLUMN day_name VARCHAR(10) NOT NULL ;
     UPDATE sales
SET day_name = DAYNAME(date) ;

SELECT
	date,
	MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);


SELECT 
	DISTINCT city
FROM sales;

SELECT 
	DISTINCT city,
    branch
FROM sales;

SELECT
	DISTINCT product_line
FROM sales;

		SELECT 
        payment_method,
        COUNT(payment_method) AS cnt
        FROM sales
        GROUP BY payment_method
        ORDER BY cnt DESC;
        
        
        SELECT 
        Product_line,
        COUNT(Product_line) AS prd
        FROM sales
        GROUP BY Product_line
        ORDER BY prd DESC;
        
        SELECT
	SUM(total) AS total_revenue
FROM sales;

SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM sales
GROUP BY month_name 
ORDER BY cogs;

SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue DESC;

        SELECT
	product_line,
	AVG(vat) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

