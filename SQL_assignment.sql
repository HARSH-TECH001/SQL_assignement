#. Q1:  Create a table called employees with the following structure
#ANS:

CREATE DATABASE company;
USE company;


CREATE TABLE employees ( 
emp_id INT PRIMARY KEY NOT NULL,
emp_name TEXT  NOT NULL, 
age INT check (age >= 18), 
email VARCHAR(100) UNIQUE,
salary DECIMAL(10, 2) DEFAULT 30000
);


#Q2 : Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
#     examples of common types of constraints.

-- Purpose of Constraints in a Database

-- Constraints are rules applied to table columns to ensure correctness, consistency, and reliability of the data. They act like guardrails that prevent invalid or inconsistent data from entering the database.

-- By enforcing constraints, databases maintain data integrity — meaning the data stays accurate, consistent, and trustworthy over time.

--  How Constraints Help Maintain Data Integrity

-- Prevent invalid data entry
-- Example: If age must be >= 18, a constraint stops you from inserting a value like 15.

-- Avoid duplication
-- Example: A UNIQUE constraint on email ensures no two employees register with the same email.

-- Maintain consistency between tables
-- Example: A FOREIGN KEY ensures an order is linked only to an existing customer.

-- Provide default values
-- Example: If no salary is given, the DEFAULT constraint ensures it gets set to 30,000.


-- Common Types of Constraints with Examples

-- PRIMARY KEY
-- Ensures each row is uniquely identifiable and not NULL.

-- emp_id INT PRIMARY KEY
-- → No duplicate IDs, and no null values.

-- NOT NULL
-- Ensures a column must always have a value.

-- emp_name TEXT NOT NULL


-- → Prevents saving a record without a name.

-- UNIQUE
-- Ensures all values in a column are distinct.

-- email TEXT UNIQUE


-- → No two employees can share the same email.

-- CHECK
-- Restricts values in a column to meet a condition.

-- age INT CHECK (age >= 18)


-- → Prevents storing underage employees.

-- DEFAULT
-- Provides a default value if none is supplied.

-- salary DECIMAL(10,2) DEFAULT 30000


-- → If salary is not entered, it defaults to 30,000.

-- FOREIGN KEY
-- Ensures data in one table refers to valid data in another.

-- dept_id INT REFERENCES departments(dept_id)


-- → Prevents assigning an employee to a department that doesn’t exist.


#Q3: Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.

-- Why Apply the NOT NULL Constraint?

-- The NOT NULL constraint ensures that a column must always have a value — it can never store NULL (missing/unknown) data.

-- ✅ Reasons to use NOT NULL:

-- Essential information → Some data is mandatory (e.g., emp_name, date_of_birth).

-- Prevent incomplete records → Ensures no empty fields for critical columns.

-- Improve data integrity → Guarantees every record has valid and usable information.

-- emp_name TEXT NOT NULL
-- This ensures that every employee must have a name in the database.

-- 🔹 Can a Primary Key Contain NULL Values?
-- No. A primary key cannot contain NULL values.

-- ✅ Justification:
-- Uniqueness requirement → A primary key uniquely identifies each row.

-- If NULL were allowed, multiple rows could have NULL, which breaks uniqueness (because NULL means "unknown," and two unknowns cannot be guaranteed as different).

-- Identification → Primary keys are meant to uniquely identify each record. A NULL value would mean the record has no identifier, defeating the purpose.

-- 📌 Example:

-- sql
-- Copy code
-- emp_id INT PRIMARY KEY
-- Every employee must have a unique ID.

-- NULL is not allowed because then the employee wouldn’t be identifiable.

-- ✅ Summary:

-- Use NOT NULL to ensure critical columns always have a value.

-- A primary key cannot contain NULLs because it must uniquely and reliably identify each row in the table.


# Q4:  Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.

-- ANS: 

-- Add a Constraint

-- Use ALTER TABLE ... ADD CONSTRAINT.

ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

-- Remove a Constraint

-- Use ALTER TABLE ... DROP CONSTRAINT.

ALTER TABLE employees
DROP CONSTRAINT unique_email;


# Q5 :   Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.

-- ANS: 
-- Constraint Violations & Consequences

-- NOT NULL → Inserting NULL → ❌ Row rejected.
-- Error: ERROR: null value in column "emp_name" violates not-null constraint

-- PRIMARY KEY → Duplicate/NULL key → ❌ Row rejected.
-- Error: ERROR: duplicate key value violates primary key constraint "employees_pkey"

-- UNIQUE → Duplicate value → ❌ Row rejected.
-- Error: ERROR: duplicate key value violates unique constraint "unique_email"

-- CHECK → Condition fails (e.g., age < 18) → ❌ Row rejected.
-- Error: ERROR: new row violates check constraint "check_age"

-- FOREIGN KEY → Missing parent record or restricted delete → ❌ Action blocked.
-- Error: ERROR: insert or update violates foreign key constraint "fk_dept"

#Q6: You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price 	 DECIMAL(10, 2));
    
    
-- Now, you realise that?
-- : The product_id should be a primary keyQ
-- : The price should have a default value of 50.00


-- ANS:

ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id) ; 

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

Drop table classes;

# Q7: You have two tables:

CREATE TABLE classes ( 
class_id INT PRIMARY KEY,
class_name VARCHAR(100) NOT NULL
);

CREATE TABLE students ( 
student_id INT PRIMARY KEY,
student_name VARCHAR(100),
class_id INT,
FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

INSERT INTO Classes (class_id, class_name)
VALUES
(101, 'Math'),
(102, 'Science'),
(103, 'History');

INSERT INTO students (student_id, student_name, class_id) VALUES 
(1, "Alice", 101),
(2, "Bob", 102),
(3, "Charlie", 101);


SELECT 
    Students.student_name,
    Classes.class_name
FROM 
    Students
INNER JOIN 
    Classes ON Students.class_id = Classes.class_id;
    
    
#Q8 : Consider the following three tables:

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

INSERT INTO Customers (customer_id, customer_name) VALUES
(101, 'Alice'),
(102, 'Bob');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-01', 101),
(2, '2024-01-03', 102);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Products (product_id, product_name, order_id) VALUES
(1, 'Laptop', 1),
(2, 'Phone', NULL);



-- ANS:
SELECT 
    o.order_id,
    c.customer_name,
    p.product_name
FROM Products p
LEFT JOIN Orders o ON p.order_id = o.order_id
LEFT JOIN Customers c ON o.customer_id = c.customer_id;


#Q9:  

-- Ans:

-- SQL:
-- SELECT o.order_id, c.customer_name, p.product_name
-- FROM products p
-- LEFT JOIN orders o ON p.product_id = o.product_id
-- LEFT JOIN customers c ON o.customer_id = c.customer_id;



-- Q10:  

-- Ans:

-- SELECT p.product_name, SUM(o.quantity * p.price) AS total_sales
-- FROM products p
-- INNER JOIN orders o ON p.product_id = o.product_id
-- GROUP BY p.product_name;



-- SQL 

-- Conceptual SQL Tasks

-- Identify Primary Keys and Foreign Keys in Maven Movies DB.

-- Primary Key (PK): Uniquely identifies each record.

-- Foreign Key (FK): Links two tables together.

-- Discuss differences in terms of constraint and referential integrity.

-- 🧑‍💼 Actor/Customer Data Queries

-- List all details of actors

-- SELECT * FROM actor;


-- List all customer information from DB

-- SELECT * FROM customer;


-- List different countries

-- SELECT DISTINCT country FROM country;


-- Display all active customers

-- SELECT * FROM customer WHERE active = 1;


-- List all rental IDs for customer with ID 1

-- SELECT rental_id FROM rental WHERE customer_id = 1;

-- 🎬 Film Data Queries

-- Display all the films whose rental duration is greater than 5

-- SELECT * FROM film WHERE rental_duration > 5;


-- Total number of films with replacement cost > $15 and < $20

-- SELECT COUNT(*) FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;

-- 🔢 Counts and Filtering

-- Count of unique first names of actors

-- SELECT COUNT(DISTINCT first_name) FROM actor;


-- First 10 records from customer table

-- SELECT * FROM customer LIMIT 10;


-- First 3 customers with first name starting with 'b'

-- SELECT * FROM customer 
-- WHERE LOWER(first_name) LIKE 'b%' 
-- LIMIT 3;

-- 🔤 Name-Based Filters

-- Names of first 5 movies rated 'G'

-- SELECT title FROM film 
-- WHERE rating = 'G' 
-- LIMIT 5;


-- Customers whose first name starts with 'a'

-- SELECT * FROM customer 
-- WHERE first_name LIKE 'A%';


-- Customers whose first name ends with 'a'

-- SELECT * FROM customer 
-- WHERE first_name LIKE '%a';


-- First 4 cities starting and ending with 'a'

-- SELECT * FROM city 
-- WHERE city LIKE 'a%' AND city LIKE '%a' 
-- LIMIT 4;


-- Customers whose first name has 'ni' in any position

-- SELECT * FROM customer 
-- WHERE first_name LIKE '%ni%';


-- Customers with 'r' as 2nd letter in first name

-- SELECT * FROM customer 
-- WHERE first_name LIKE '_r%';


-- Customers whose first name starts with 'a' and has at least 5 characters

-- SELECT * FROM customer 
-- WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;


-- Customers whose first name starts with 'a' and ends with 'o'

-- SELECT * FROM customer 
-- WHERE first_name LIKE 'a%o';

-- 🎞️ Film Filters and Operators

-- Films with PG and PG-13 rating using IN

-- SELECT * FROM film 
-- WHERE rating IN ('PG', 'PG-13');


-- Films with length between 50 and 100

-- SELECT * FROM film 
-- WHERE length BETWEEN 50 AND 100;


-- Top 50 films using LIMIT

-- SELECT * FROM film 
-- LIMIT 50;


-- Distinct film IDs from inventory

-- SELECT DISTINCT film_id FROM inventory;


-- Basic Aggregate Functions
-- Question 1:

-- Retrieve the total number of rentals made in the Sakila database

-- SELECT COUNT(*) AS total_rentals
-- FROM rental;

-- Question 2:

-- Find the average rental duration (in days) of movies rented

-- SELECT AVG(rental_duration) AS average_rental_duration
-- FROM film;


-- Note: rental_duration is stored in the film table, not rental, as it defines how long a movie is allowed to be rented.

-- 🔤 String Functions
-- Question 3:

-- Display the first name and last name of customers in uppercase

-- SELECT UPPER(first_name) AS first_name_upper,
--        UPPER(last_name) AS last_name_upper
-- FROM customer;

-- Question 4:

-- Extract the month from the rental date and display it with rental ID

-- SELECT rental_id,
--        MONTH(rental_date) AS rental_month
-- FROM rental;

-- 🧮 GROUP BY Functions
-- Question 5:

-- Retrieve the count of rentals for each customer

-- SELECT customer_id,
--        COUNT(*) AS rental_count
-- FROM rental
-- GROUP BY customer_id;

-- Question 6:

-- Find the total revenue generated by each store

-- You need to sum payments joined with staff and store info:

-- SELECT s.store_id,
--        SUM(p.amount) AS total_revenue
-- FROM payment p
-- JOIN staff s ON p.staff_id = s.staff_id
-- GROUP BY s.store_id;

-- Question 7:

-- Determine the total number of rentals for each category

-- You need to join film_category, inventory, and rental:

-- SELECT c.name AS category,
--        COUNT(r.rental_id) AS total_rentals
-- FROM category c
-- JOIN film_category fc ON c.category_id = fc.category_id
-- JOIN film f ON fc.film_id = f.film_id
-- JOIN inventory i ON f.film_id = i.film_id
-- JOIN rental r ON i.inventory_id = r.inventory_id
-- GROUP BY c.name;

-- Question 8:

-- Find the average rental rate of movies in each language

-- SELECT l.name AS language,
--        AVG(f.rental_rate) AS avg_rental_rate
-- FROM film f
-- JOIN language l ON f.language_id = l.language_id
-- GROUP BY l.name;


-- JOINS
-- Question 9:

-- Display the title of the movie, and customer’s first and last name who rented it

-- SELECT f.title,
--        c.first_name,
--        c.last_name
-- FROM rental r
-- JOIN inventory i ON r.inventory_id = i.inventory_id
-- JOIN film f ON i.film_id = f.film_id
-- JOIN customer c ON r.customer_id = c.customer_id;

-- Question 10:

-- Retrieve the names of all actors who appeared in the film "Gone with the Wind"

-- SELECT a.first_name,
--        a.last_name
-- FROM film f
-- JOIN film_actor fa ON f.film_id = fa.film_id
-- JOIN actor a ON fa.actor_id = a.actor_id
-- WHERE f.title = 'Gone with the Wind';

-- Question 11:

-- Retrieve the customer names along with the total amount they've spent on rentals

-- SELECT c.first_name,
--        c.last_name,
--        SUM(p.amount) AS total_spent
-- FROM customer c
-- JOIN payment p ON c.customer_id = p.customer_id
-- GROUP BY c.customer_id, c.first_name, c.last_name;

-- Question 12:

-- List the titles of movies rented by each customer in a particular city (e.g., 'London')

-- SELECT c.first_name,
--        c.last_name,
--        f.title
-- FROM customer c
-- JOIN address a ON c.address_id = a.address_id
-- JOIN city ci ON a.city_id = ci.city_id
-- JOIN rental r ON c.customer_id = r.customer_id
-- JOIN inventory i ON r.inventory_id = i.inventory_id
-- JOIN film f ON i.film_id = f.film_id
-- WHERE ci.city = 'London';

-- 📊 Advanced Joins + Aggregation
-- Question 13:

-- Display the top 5 rented movies along with number of times they’ve been rented

-- SELECT f.title,
--        COUNT(r.rental_id) AS times_rented
-- FROM film f
-- JOIN inventory i ON f.film_id = i.film_id
-- JOIN rental r ON i.inventory_id = r.inventory_id
-- GROUP BY f.film_id, f.title
-- ORDER BY times_rented DESC
-- LIMIT 5;

-- Question 14:

-- Determine customers who rented movies from both store 1 and store 2

-- We'll use a HAVING clause to ensure the customer rented from both stores.

-- SELECT r.customer_id
-- FROM rental r
-- JOIN inventory i ON r.inventory_id = i.inventory_id
-- JOIN customer c ON r.customer_id = c.customer_id
-- GROUP BY r.customer_id
-- HAVING COUNT(DISTINCT i.store_id) = 2;


-- To include names:

-- SELECT c.first_name,
--        c.last_name
-- FROM customer c
-- WHERE c.customer_id IN (
--     SELECT r.customer_id
--     FROM rental r
--     JOIN inventory i ON r.inventory_id = i.inventory_id
--     GROUP BY r.customer_id
--     HAVING COUNT(DISTINCT i.store_id) = 2
-- );



 