-- Create Database
create database myDB;
use myDB;
-- drop database myDB;

-- Edit DB  
alter database myDB read only =1; -- make databse read only
drop database myDB; -- this will not work because the DB is read only
alter database myDB read only =0; -- reverse read only

-- Create table
create table employees(
	employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay decimal(5,2),  
    hire_date date
);

-- edit table
-- drop table employees; 
select * from employees;
rename table employees to workers;
rename table workers to employees;

-- ADD column
alter table employees
add phone_number varchar(10);

-- rename column
alter table employees
rename column phone_number to email; -- this will not change the data type
select * from employees;

-- modify the datatype
use myDB;
alter table employees
modify column email varchar(100);

-- change variable with data type
alter table employees 
change column last_name surname varchar(60);

-- describe function
desc employees; 

-- reposition of column

-- after keyword used to put var next to the given var

alter table  employees  
	modify email varchar(100) 
	after surname; 
	select * from employees;

-- using position number to reposition
alter table employees modify email varchar(100) first;
select * from employees;

-- delete the column
alter table employees
drop column email;
-- drop column email and hire date -- this will not work 
select * from employees;

-- insert rows
insert into employees
values(1, "Shivam", 'Baharwani', 25.50, "2023-01-02");
insert into employees
value(2,'Spongebob', 'Tentacles', 15.00, '2023-01-04'),
	(3,'Jatin', 'kamra',12.50,'2023-01-04'),
    (4,'Yash', 'Baharwani', 12.50,'23-01-05');
select * from employees;

-- insert into employees 
-- normal insert will not work if all values is not entered 
insert into employees (employee_id, first_name, surname)	
-- use brackets and enter the values column name
values(6,'Sheldon','Plankton');
select * from employees;

-- WHERE : conditional
SELECT employee_id, first_name FROM employees WHERE employee_id = 1 OR employee_id = 2;
-- print in order
SELECT * FROM employees ORDER BY first_name;
SELECT * FROM employees order by hourly_pay;
-- select perticular column
SELECT surname, first_name FROM employees;
-- create new column using exesting one's data
SELECT first_name, hourly_pay, hourly_pay + 10 FROM employees;
-- give column an allias using AS keyword
SELECT first_name, hourly_pay, hourly_pay + 10 AS extra_time FROM employees;
-- Use couts to insert space in allias
SELECT first_name, hourly_pay, hourly_pay + 10 AS 'extra time' FROM employees;

-- DISTINCT : avoid duplicate values
SELECT DISTINCT first_name from employees;

/*
		EX 1
Return all the employees
	INCLUDE COLUMNS :
	-name
	-hourly pay
	-extra time
*/
-- Query
SELECT DISTINCT first_name,hourly_pay,hourly_pay+10 AS 'Extra time pay' from employees;

SELECT * from employees;

-- ADDING a column
alter table employees 
add(working_hours numeric);

/* 
To insert values into specific columns of a row where some columns already have data,
 UPDATE statement
 UPDATE statement is used to modify existing records in a table. */
UPDATE employees
SET hourly_pay = 17.20,  
    hire_date = '2023-01-10'   
WHERE employee_id=6;

-- Conditionl update value's of a column
UPDATE employees
SET working_hours = 20 WHERE hourly_pay<=15;
UPDATE employees
SET working_hours =25 WHERE hourly_pay>15;

-- DELETING raw where first_name column contains NULL value
DELETE FROM employees 
WHERE first_name IS NULL;


-- DELETING duplicate raw using duplicate table
CREATE TABLE new_employees AS
SELECT DISTINCT * FROM employees;
SELECT * FROM new_employees;
-- DELETING og table 
DROP TABLE employees;
-- RENAMING duplicate table to og table
ALTER TABLE new_employees RENAME to employees;
SELECT * FROM employees;  
-- Duplicate raws deleted

/*
EX : 2
GET emloyees details whose salary >15
AND
hire_date >= '2023-01-04'
*/
-- Query
SELECT * FROM employees
-- OR/AND can be used based on the task
WHERE (hourly_pay>15 AND hire_date >='2023-01-04');
 
 -- NOT used to give apposite output(1->0, 0->1)
 SELECT * FROM employees
 WHERE NOT (hourly_pay>15 AND hire_date >= '2023-01-04');
 


DROP DATABASE IF EXISTS `sql_invoicing`;
CREATE DATABASE `sql_invoicing`; 
USE `sql_invoicing`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `payment_methods` (
  `payment_method_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `payment_methods` VALUES (1,'Credit Card');
INSERT INTO `payment_methods` VALUES (2,'Cash');
INSERT INTO `payment_methods` VALUES (3,'PayPal');
INSERT INTO `payment_methods` VALUES (4,'Wire Transfer');

CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` char(2) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `clients` VALUES (1,'Vinte','3 Nevada Parkway','Syracuse','NY','315-252-7305');
INSERT INTO `clients` VALUES (2,'Myworks','34267 Glendale Parkway','Huntington','WV','304-659-1170');
INSERT INTO `clients` VALUES (3,'Yadel','096 Pawling Parkway','San Francisco','CA','415-144-6037');
INSERT INTO `clients` VALUES (4,'Kwideo','81674 Westerfield Circle','Waco','TX','254-750-0784');
INSERT INTO `clients` VALUES (5,'Topiclounge','0863 Farmco Road','Portland','OR','971-888-9129');

CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `number` varchar(50) NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_total` decimal(9,2) NOT NULL,
  `payment_total` decimal(9,2) NOT NULL DEFAULT '0.00',
  `invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_date` date DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `FK_client_id` (`client_id`),
  CONSTRAINT `FK_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `invoices` VALUES (1,'91-953-3396',2,101.79,0.00,'2019-03-09','2019-03-29',NULL);
INSERT INTO `invoices` VALUES (2,'03-898-6735',5,175.32,8.18,'2019-06-11','2019-07-01','2019-02-12');
INSERT INTO `invoices` VALUES (3,'20-228-0335',5,147.99,0.00,'2019-07-31','2019-08-20',NULL);
INSERT INTO `invoices` VALUES (4,'56-934-0748',3,152.21,0.00,'2019-03-08','2019-03-28',NULL);
INSERT INTO `invoices` VALUES (5,'87-052-3121',5,169.36,0.00,'2019-07-18','2019-08-07',NULL);
INSERT INTO `invoices` VALUES (6,'75-587-6626',1,157.78,74.55,'2019-01-29','2019-02-18','2019-01-03');
INSERT INTO `invoices` VALUES (7,'68-093-9863',3,133.87,0.00,'2019-09-04','2019-09-24',NULL);
INSERT INTO `invoices` VALUES (8,'78-145-1093',1,189.12,0.00,'2019-05-20','2019-06-09',NULL);
INSERT INTO `invoices` VALUES (9,'77-593-0081',5,172.17,0.00,'2019-07-09','2019-07-29',NULL);
INSERT INTO `invoices` VALUES (10,'48-266-1517',1,159.50,0.00,'2019-06-30','2019-07-20',NULL);
INSERT INTO `invoices` VALUES (11,'20-848-0181',3,126.15,0.03,'2019-01-07','2019-01-27','2019-01-11');
INSERT INTO `invoices` VALUES (13,'41-666-1035',5,135.01,87.44,'2019-06-25','2019-07-15','2019-01-26');
INSERT INTO `invoices` VALUES (15,'55-105-9605',3,167.29,80.31,'2019-11-25','2019-12-15','2019-01-15');
INSERT INTO `invoices` VALUES (16,'10-451-8824',1,162.02,0.00,'2019-03-30','2019-04-19',NULL);
INSERT INTO `invoices` VALUES (17,'33-615-4694',3,126.38,68.10,'2019-07-30','2019-08-19','2019-01-15');
INSERT INTO `invoices` VALUES (18,'52-269-9803',5,180.17,42.77,'2019-05-23','2019-06-12','2019-01-08');
INSERT INTO `invoices` VALUES (19,'83-559-4105',1,134.47,0.00,'2019-11-23','2019-12-13',NULL);


CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `fk_client_id_idx` (`client_id`),
  KEY `fk_invoice_id_idx` (`invoice_id`),
  KEY `fk_payment_payment_method_idx` (`payment_method`),
  CONSTRAINT `fk_payment_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_payment_method` FOREIGN KEY (`payment_method`) REFERENCES `payment_methods` (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `payments` VALUES (1,5,2,'2019-02-12',8.18,1);
INSERT INTO `payments` VALUES (2,1,6,'2019-01-03',74.55,1);
INSERT INTO `payments` VALUES (3,3,11,'2019-01-11',0.03,1);
INSERT INTO `payments` VALUES (4,5,13,'2019-01-26',87.44,1);
INSERT INTO `payments` VALUES (5,3,15,'2019-01-15',80.31,1);
INSERT INTO `payments` VALUES (6,3,17,'2019-01-15',68.10,1);
INSERT INTO `payments` VALUES (7,5,18,'2019-01-08',32.77,1);
INSERT INTO `payments` VALUES (8,5,18,'2019-01-08',10.00,2);


DROP DATABASE IF EXISTS `sql_store`;
CREATE DATABASE `sql_store`;
USE `sql_store`;

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `quantity_in_stock` int(11) NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `products` VALUES (1,'Foam Dinner Plate',70,1.21);
INSERT INTO `products` VALUES (2,'Pork - Bacon,back Peameal',49,4.65);
INSERT INTO `products` VALUES (3,'Lettuce - Romaine, Heart',38,3.35);
INSERT INTO `products` VALUES (4,'Brocolinni - Gaylan, Chinese',90,4.53);
INSERT INTO `products` VALUES (5,'Sauce - Ranch Dressing',94,1.63);
INSERT INTO `products` VALUES (6,'Petit Baguette',14,2.39);
INSERT INTO `products` VALUES (7,'Sweet Pea Sprouts',98,3.29);
INSERT INTO `products` VALUES (8,'Island Oasis - Raspberry',26,0.74);
INSERT INTO `products` VALUES (9,'Longan',67,2.26);
INSERT INTO `products` VALUES (10,'Broom - Push',6,1.09);


CREATE TABLE `shippers` (
  `shipper_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`shipper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `shippers` VALUES (1,'Hettinger LLC');
INSERT INTO `shippers` VALUES (2,'Schinner-Predovic');
INSERT INTO `shippers` VALUES (3,'Satterfield LLC');
INSERT INTO `shippers` VALUES (4,'Mraz, Renner and Nolan');
INSERT INTO `shippers` VALUES (5,'Waters, Mayert and Prohaska');


CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` char(2) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `customers` VALUES (1,'Babara','MacCaffrey','1986-03-28','781-932-9754','0 Sage Terrace','Waltham','MA',2273);
INSERT INTO `customers` VALUES (2,'Ines','Brushfield','1986-04-13','804-427-9456','14187 Commercial Trail','Hampton','VA',947);
INSERT INTO `customers` VALUES (3,'Freddi','Boagey','1985-02-07','719-724-7869','251 Springs Junction','Colorado Springs','CO',2967);
INSERT INTO `customers` VALUES (4,'Ambur','Roseburgh','1974-04-14','407-231-8017','30 Arapahoe Terrace','Orlando','FL',457);
INSERT INTO `customers` VALUES (5,'Clemmie','Betchley','1973-11-07',NULL,'5 Spohn Circle','Arlington','TX',3675);
INSERT INTO `customers` VALUES (6,'Elka','Twiddell','1991-09-04','312-480-8498','7 Manley Drive','Chicago','IL',3073);
INSERT INTO `customers` VALUES (7,'Ilene','Dowson','1964-08-30','615-641-4759','50 Lillian Crossing','Nashville','TN',1672);
INSERT INTO `customers` VALUES (8,'Thacher','Naseby','1993-07-17','941-527-3977','538 Mosinee Center','Sarasota','FL',205);
INSERT INTO `customers` VALUES (9,'Romola','Rumgay','1992-05-23','559-181-3744','3520 Ohio Trail','Visalia','CA',1486);
INSERT INTO `customers` VALUES (10,'Levy','Mynett','1969-10-13','404-246-3370','68 Lawn Avenue','Atlanta','GA',796);


CREATE TABLE `order_statuses` (
  `order_status_id` tinyint(4) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`order_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `order_statuses` VALUES (1,'Processed');
INSERT INTO `order_statuses` VALUES (2,'Shipped');
INSERT INTO `order_statuses` VALUES (3,'Delivered');


CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `comments` varchar(2000) DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  `shipper_id` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_customers_idx` (`customer_id`),
  KEY `fk_orders_shippers_idx` (`shipper_id`),
  KEY `fk_orders_order_statuses_idx` (`status`),
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_order_statuses` FOREIGN KEY (`status`) REFERENCES `order_statuses` (`order_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shippers` FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`shipper_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `orders` VALUES (1,6,'2019-01-30',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (2,7,'2018-08-02',2,NULL,'2018-08-03',4);
INSERT INTO `orders` VALUES (3,8,'2017-12-01',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (4,2,'2017-01-22',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (5,5,'2017-08-25',2,'','2017-08-26',3);
INSERT INTO `orders` VALUES (6,10,'2018-11-18',1,'Aliquam erat volutpat. In congue.',NULL,NULL);
INSERT INTO `orders` VALUES (7,2,'2018-09-22',2,NULL,'2018-09-23',4);
INSERT INTO `orders` VALUES (8,5,'2018-06-08',1,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',NULL,NULL);
INSERT INTO `orders` VALUES (9,10,'2017-07-05',2,'Nulla mollis molestie lorem. Quisque ut erat.','2017-07-06',1);
INSERT INTO `orders` VALUES (10,6,'2018-04-22',2,NULL,'2018-04-23',2);


CREATE TABLE `order_items` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_order_items_products_idx` (`product_id`),
  CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `order_items` VALUES (1,4,4,3.74);
INSERT INTO `order_items` VALUES (2,1,2,9.10);
INSERT INTO `order_items` VALUES (2,4,4,1.66);
INSERT INTO `order_items` VALUES (2,6,2,2.94);
INSERT INTO `order_items` VALUES (3,3,10,9.12);
INSERT INTO `order_items` VALUES (4,3,7,6.99);
INSERT INTO `order_items` VALUES (4,10,7,6.40);
INSERT INTO `order_items` VALUES (5,2,3,9.89);
INSERT INTO `order_items` VALUES (6,1,4,8.65);
INSERT INTO `order_items` VALUES (6,2,4,3.28);
INSERT INTO `order_items` VALUES (6,3,4,7.46);
INSERT INTO `order_items` VALUES (6,5,1,3.45);
INSERT INTO `order_items` VALUES (7,3,7,9.17);
INSERT INTO `order_items` VALUES (8,5,2,6.94);
INSERT INTO `order_items` VALUES (8,8,2,8.59);
INSERT INTO `order_items` VALUES (9,6,5,7.28);
INSERT INTO `order_items` VALUES (10,1,10,6.01);
INSERT INTO `order_items` VALUES (10,9,9,4.28);

CREATE TABLE `sql_store`.`order_item_notes` (
  `note_id` INT NOT NULL,
  `order_Id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `note` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`note_id`));

INSERT INTO `order_item_notes` (`note_id`, `order_Id`, `product_id`, `note`) VALUES ('1', '1', '2', 'first note');
INSERT INTO `order_item_notes` (`note_id`, `order_Id`, `product_id`, `note`) VALUES ('2', '1', '2', 'second note');


DROP DATABASE IF EXISTS `sql_hr`;
CREATE DATABASE `sql_hr`;
USE `sql_hr`;

CREATE TABLE `offices` (
  `office_id` int(11) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  PRIMARY KEY (`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `offices` VALUES (1,'03 Reinke Trail','Cincinnati','OH');
INSERT INTO `offices` VALUES (2,'5507 Becker Terrace','New York City','NY');
INSERT INTO `offices` VALUES (3,'54 Northland Court','Richmond','VA');
INSERT INTO `offices` VALUES (4,'08 South Crossing','Cincinnati','OH');
INSERT INTO `offices` VALUES (5,'553 Maple Drive','Minneapolis','MN');
INSERT INTO `offices` VALUES (6,'23 North Plaza','Aurora','CO');
INSERT INTO `offices` VALUES (7,'9658 Wayridge Court','Boise','ID');
INSERT INTO `offices` VALUES (8,'9 Grayhawk Trail','New York City','NY');
INSERT INTO `offices` VALUES (9,'16862 Westend Hill','Knoxville','TN');
INSERT INTO `offices` VALUES (10,'4 Bluestem Parkway','Savannah','GA');



CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `job_title` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `reports_to` int(11) DEFAULT NULL,
  `office_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `fk_employees_offices_idx` (`office_id`),
  KEY `fk_employees_employees_idx` (`reports_to`),
  CONSTRAINT `fk_employees_managers` FOREIGN KEY (`reports_to`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_employees_offices` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `employees` VALUES (37270,'Yovonnda','Magrannell','Executive Secretary',63996,NULL,10);
INSERT INTO `employees` VALUES (33391,'D\'arcy','Nortunen','Account Executive',62871,37270,1);
INSERT INTO `employees` VALUES (37851,'Sayer','Matterson','Statistician III',98926,37270,1);
INSERT INTO `employees` VALUES (40448,'Mindy','Crissil','Staff Scientist',94860,37270,1);
INSERT INTO `employees` VALUES (56274,'Keriann','Alloisi','VP Marketing',110150,37270,1);
INSERT INTO `employees` VALUES (63196,'Alaster','Scutchin','Assistant Professor',32179,37270,2);
INSERT INTO `employees` VALUES (67009,'North','de Clerc','VP Product Management',114257,37270,2);
INSERT INTO `employees` VALUES (67370,'Elladine','Rising','Social Worker',96767,37270,2);
INSERT INTO `employees` VALUES (68249,'Nisse','Voysey','Financial Advisor',52832,37270,2);
INSERT INTO `employees` VALUES (72540,'Guthrey','Iacopetti','Office Assistant I',117690,37270,3);
INSERT INTO `employees` VALUES (72913,'Kass','Hefferan','Computer Systems Analyst IV',96401,37270,3);
INSERT INTO `employees` VALUES (75900,'Virge','Goodrum','Information Systems Manager',54578,37270,3);
INSERT INTO `employees` VALUES (76196,'Mirilla','Janowski','Cost Accountant',119241,37270,3);
INSERT INTO `employees` VALUES (80529,'Lynde','Aronson','Junior Executive',77182,37270,4);
INSERT INTO `employees` VALUES (80679,'Mildrid','Sokale','Geologist II',67987,37270,4);
INSERT INTO `employees` VALUES (84791,'Hazel','Tarbert','General Manager',93760,37270,4);
INSERT INTO `employees` VALUES (95213,'Cole','Kesterton','Pharmacist',86119,37270,4);
INSERT INTO `employees` VALUES (96513,'Theresa','Binney','Food Chemist',47354,37270,5);
INSERT INTO `employees` VALUES (98374,'Estrellita','Daleman','Staff Accountant IV',70187,37270,5);
INSERT INTO `employees` VALUES (115357,'Ivy','Fearey','Structural Engineer',92710,37270,5);


DROP DATABASE IF EXISTS `sql_inventory`;
CREATE DATABASE `sql_inventory`;
USE `sql_inventory`;


CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `quantity_in_stock` int(11) NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `products` VALUES (1,'Foam Dinner Plate',70,1.21);
INSERT INTO `products` VALUES (2,'Pork - Bacon,back Peameal',49,4.65);
INSERT INTO `products` VALUES (3,'Lettuce - Romaine, Heart',38,3.35);
INSERT INTO `products` VALUES (4,'Brocolinni - Gaylan, Chinese',90,4.53);
INSERT INTO `products` VALUES (5,'Sauce - Ranch Dressing',94,1.63);
INSERT INTO `products` VALUES (6,'Petit Baguette',14,2.39);
INSERT INTO `products` VALUES (7,'Sweet Pea Sprouts',98,3.29);
INSERT INTO `products` VALUES (8,'Island Oasis - Raspberry',26,0.74);
INSERT INTO `products` VALUES (9,'Longan',67,2.26);
INSERT INTO `products` VALUES (10,'Broom - Push',6,1.09);


/* EX:3
FROM the order_items table, get the items
for order #6
where the total price is greater than 30
*/

-- Query
USE sql_store;
SHOW TABLES;
SELECT * from order_items
WHERE order_id = 6 AND unit_price*quantity > 30;

-- Orders from state = VA, GA, FL
SELECT * from customers
WHERE state ='VA' or state ='GA' or state ='FL';

-- IN operator (checks into the tuple)
SELECT * FROM customers
WHERE state IN ('VA', 'GA', 'FL'); -- customers from these states 

SELECT * FROM customers 
WHERE state NOT IN ('VA', 'GA', 'FL'); -- customers not from these states 

SHOW TABLES;
SELECT * FROM products
WHERE quantity_in_stock IN (49,38,72);


SELECT * FROM customers
WHERE points >=1000 AND points <= 3000;

-- BETWEEN Operator
SELECT * FROM customers
WHERE points BETWEEN 1000 AND 3000;

/*
EX : 4
Return customers born 
between 1/1/1990 and 1/1/2000
*/
SELECT * FROM customers 
WHERE birth_date BETWEEN '1990-1-1' and '2000-1-1';


-- LIKE operator , % operator (anything after it)
SELECT * FROM customers
WHERE last_name LIKE 'b%'; -- last name starts with b

SELECT * FROM customers
WHERE last_name LIKE '%b%'; -- last name contains b

SELECT * FROM customers
WHERE last_name LIKE '%y'; -- last name ends with b

SELECT * FROM customers
WHERE last_name LIKE '_____y'; -- number of underscore shows the same number of elements before y


/*
EX : 5
Get the customers whose addresses contains TRAIL or AVENUE
phone numbers ends with 9
*/
-- Query 1
SELECT * FROM customers
WHERE address LIKE ('%trail%') or address LIKE ('%avenue%');
-- Query 2
SELECT * FROM customers
WHERE phone LIKE '%9';

use sql_store;

-- REGEXP works like 'LIKE' Operator
SELECT * From customers
WHERE last_name REGEXP 'field';  -- does't require % persenatage sign before and after the name

-- ^ starts with
SELECT * FROM customers
WHERE last_name REGEXP '^mac'; 

-- $ ends with
SELECT * FROM customers
WHERE last_name REGEXP 'field$';

-- | (or)
SELECT * FROM customers 
WHERE last_name REGEXP 'field|mac|rose';

-- EITHER starts from field or may contain mac and rose
SELECT * FROM customers 
WHERE last_name REGEXP '^field|mac|rose';

-- list sqaure brackets [] can be used to elementory search (each element in the list will be searched in the data). 
-- in this example it tells which element comes before or after the element e
-- in the result last name either contains ge, ie, me
SELECT * FROM customers
WHERE last_name REGEXP '[gim]e';

-- or it can used like 'field|mac|rose' where we want to search elements individually
SELECT * FROM customers
WHERE last_name REGEXP '[gim]'; -- shows last_name with g,i,m in it

-- hyphen - can be used for the range (to)
-- results last_name which contain any alphabet from a to h then e.
SELECT * FROM customers
WHERE last_name REGEXP '[a-h]e';

/*
REGEXP operators recap
^ : beginning
$ : ending 
| : logical or
[abcd] : match any character 
[a-f] : range
*/

/*
EX : 6
Get the customers whose
	first name are elka or ambur
    last name ends with ey or on
    last names start with my or contains se
    last names contains b followed by r or u
*/
-- Query 1
SELECT * FROM customers 
WHERE first_name REGEXP ('elka|ambur');
-- Query 2
SELECT * FROM customers 
WHERE last_name REGEXP 'ey$|on$';
-- Query 3
SELECT * FROM customers 
WHERE last_name REGEXP '^my|se';
-- Query 4
SELECT * FROM customers 
WHERE last_name REGEXP 'b[ru]';-- 'br|bu'


-- NULL

-- Select attribute with Missing values
-- This query returns the raw in which the phone number column has NULL value
SELECT * FROM customers
WHERE phone IS NULL;

-- returns raws in which the number calumn contains data
SELECT * FROM customers
WHERE phone IS NOT NULL;

-- Get the order details that are not shipped yet
SELECT * FROM orders
WHERE shipped_date IS NULL;

-- ORDER BY
-- Used for sorting
SELECT * FROM customers
ORDER BY first_name;
-- Descending
SELECT * FROM customers
ORDER BY first_name DESC;

SELECT * FROM customers
ORDER BY birth_date DESC;

-- Sorting by multiple attributes
-- 1st attribute shorted then 2nd one
SELECT * FROM customers
ORDER BY state, first_name;

-- Sorting multiple attributes differently
SELECT * FROM customers
ORDER BY state DESC, first_name;


SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY points, first_name;

SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY 1,2;

/*
EX : 7
select order id 2 and sort their order price in desc order
*/
-- Query
SELECT * FROM order_items
WHERE order_id=2
ORDER BY unit_price*quantity DESC;
-- Another method
SELECT *, unit_price*quantity AS total_price
FROM order_items
WHERE order_id=2
ORDER BY total_price DESC;

-- LIMIT 
-- limit the number of output
SELECT * FROM customers
LIMIT 3;

-- escap first 6 raws then returns 3 raws
SELECT * FROM customers
LIMIT 6,3;

/*
Top 3 loyal customers
*/
SELECT * FROM customers
ORDER BY points DESC
LIMIT 3;

-- Working with multiple tables

-- INNER JOINS
SELECT * FROM orders
JOIN customers  -- INNER JOIN can also be written but 'INNER' is default 
	ON orders.customer_id = customers.customer_id;
    
-- SELECT order_id, customer_id , first_name, last_name FROM orders  
-- this will through an error because its available in both the tables and mysql is not sure where to select this column
SELECT order_id, orders.customer_id , first_name, last_name FROM orders
-- prefixing it with the table name
JOIN customers
	ON orders.customer_id = customers.customer_id;
    
-- giving allias to avoid repitation
SELECT order_id, o.customer_id , first_name, last_name 
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;
    
/*
EX : 7
JOIN order_items and products 
show order_id, product_id, quantity, unit_price, name
*/
SELECT order_id, o.product_id, quantity, o.unit_price, name FROM order_items o
JOIN products p
	ON o.product_id = p.product_id;
    
-- Joining across database
use sql_inventory;
SELECT * FROM sql_store.order_items oi  -- prefix should be written while using data from different databases
JOIN products p
	ON oi.product_id=p.product_id;

-- Self Joins (Joining table to it self to get data)

-- in this table each employee is assinged to a manager
-- and in table there is only manager_id is written so we can get the details of the manager because he or she is also an employee
USE sql_hr;
SELECT * FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;

-- return only names and id
SELECT e.employee_id, e.first_name, m.first_name AS manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;
    
-- JOINING multiple tables

USE sql_store;

SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
/*
EX : 9
Join payments, clients, payments_method
*/
-- Query
USE sql_invoicing;
SELECT p.date, p.invoice_id, p.amount, c.name, pm.name AS 'payment method'
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;
    

-- Compund join condition
-- Joining the table whose primary keys are 2 or more
USE sql_store;
SELECT oi.order_id, oi.product_id, oi.quantity, oin.note_id, oin.note 
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id=oin.order_id
    AND oi.product_id = oin.product_id;
-- This AND used to check both the condition is true

-- Explicit join syntex
SELECT * FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;
    
-- Implicit join syntex
SELECT * FROM orders o, customers c
WHERE o.customer_id = c.customer_id;

-- INNER Joins
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id -- returns only those raws which match the condition
    ORDER BY c.customer_id;

-- OUTER JOINS (LEFT And RIGHT), OUTER keyword is optional just right left and right
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o -- returns all the values present in the left table
	ON c.customer_id = o.customer_id 
    ORDER BY c.customer_id;

SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
RIGHT JOIN orders o -- returns all the values present in the right table
	ON c.customer_id = o.customer_id 
    ORDER BY c.customer_id;

/*
EX : 10
display all porducts by merging the prduct and order table even if have't ordered
*/
SELECT p.product_id, p.name, oi.quantity FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id;

-- Outer JOIN between multiple tables
SELECT c.customer_id, c.first_name, o.order_id, s.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers s
	ON o.shipper_id = s.shipper_id
ORDER BY c.customer_id;

/*
EX: 11
*/
SELECT 
	o.order_date, 
	o.order_id, 
	c.first_name, 
	s.name AS shipper, 
    os.name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers s
	ON o.shipper_id = s.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
-- SELF OUTER JOINS
USE sql_hr;
SELECT e.employee_id, e.first_name, m.first_name AS manager
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id;

-- The USING clause
-- used instate of ON keyword
-- and can only used where column name of both the table are same
USE sql_store;
SELECT o.order_id, c.first_name, s.name AS shipper
FROM orders o
JOIN customers c
		-- ON o.customer_id = c.customer_id;
        USING (customer_id)
LEFT JOIN shippers s
	USING(shipper_id);
    
-- USING keyword with Compund join condition
SELECT * 
FROM order_items oi
LEFT JOIN order_item_notes oin
	USING(order_id, product_id);

/*
EX : 12

*/
USE sql_invoicing;
SELECT p.date, c.name AS client, p.amount, pm.name AS payment_menthod
FROM payments p
JOIN clients c
	USING (client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;

-- Natural Joins
