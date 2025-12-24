DROP TABLE IF EXISTS uber_table;

CREATE TABLE uber_table (
	Date DATE,
	Time TIME,
	Booking_ID VARCHAR(50),
	Booking_Status VARCHAR(50),
	Customer_ID VARCHAR(50),
	Vehicle_Type VARCHAR(50),
	Pickup_Location VARCHAR(50),
	Drop_Location VARCHAR(50),
	V_TAT INT,
	C_TAT INT,
	Canceled_Rides_by_Customer VARCHAR(150),
	Canceled_Rides_by_Driver VARCHAR(150),
	Incomplete_Rides VARCHAR(50),
	Incomplete_Rides_Reason VARCHAR(150),
	Booking_Value INT,
	Payment_Method VARCHAR(50),
	Ride_Distance INT,
	Driver_Ratings FLOAT,
	Customer_Rating FLOAT
);

SELECT * FROM uber_table LIMIT 10;

--1) Retrieve all successfull bookings

CREATE VIEW Successfull_Booking AS
SELECT * FROM uber_table
WHERE Booking_Status = 'Success';

--1) Retrieve all successfull bookings
SELECT * FROM Successfull_Booking;

--2) Find average ride distance for each vehicle type

CREATE VIEW avg_ride_distance_for_each_vehicle AS
SELECT Vehicle_Type, ROUND(AVG(Ride_Distance),2) AS avg_ride_distance
FROM uber_table
GROUP BY Vehicle_Type
ORDER BY avg_ride_distance DESC;

--2) Find average ride distance for each vehicle type
SELECT * FROM avg_ride_distance_for_each_vehicle;


--3) Get the total number of cancelled rides by customers.

CREATE VIEW Number_Of_Cancelled_Rides AS
SELECT COUNT(Booking_ID) as total_no_cancelled_rides
FROM uber_table
WHERE Booking_Status = 'Canceled by Customer';


--3) Get the total number of cancelled rides by customers.
SELECT * FROM Number_Of_Cancelled_Rides ;


--4) List the top 5 customers who booked the highest number of rides

CREATE VIEW Top_5_Customers AS
SELECT Customer_ID,COUNT(Booking_ID) AS ride_bookings
FROM uber_table
GROUP BY Customer_ID
ORDER BY ride_bookings DESC
LIMIT 5;

--4) List the top 5 customers who booked the highest number of rides
SELECT * FROM Top_5_Customers;

-- 5) Get the number of rides canceled by drivers due to personal and car-related issues:

CREATE VIEW cancelled_rides_by_drivers_P_C_issues AS
SELECT COUNT(Booking_ID) AS cancelled_rides_drivers FROM uber_table
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';

-- 5) Get the number of rides canceled by drivers due to personal and car-related issues:
SELECT * FROM cancelled_rides_by_drivers_P_C_issues;


-- 6) Find the maximum and minimum driver ratings for prime sedan bookings

CREATE VIEW Max_Min_Driver_Ratings_For_Prime_Sedan AS
SELECT Vehicle_Type,MAX(Driver_Ratings) AS maximum_rating,MIN(Driver_Ratings) AS minimum_rating
FROM uber_table
WHERE Vehicle_Type = 'Prime Sedan'
GROUP BY Vehicle_Type;

-- 6) Find the maximum and minimum driver ratings for prime sedan bookings
SELECT * FROM Max_Min_Driver_Ratings_For_Prime_Sedan;


-- 7) Retrieve all rides  where payment was made using UPI

CREATE VIEW UPI_Payments AS
SELECT * FROM uber_table
WHERE Payment_Method= 'UPI'

-- 7) Retrieve all rides  where payment was made using UPI
SELECT * FROM UPI_payments;

--8) Find the average customer rating per vehicle type:

CREATE VIEW Avg_Customer_Rating_Per_Vehicle_Type AS
SELECT Vehicle_Type, ROUND(AVG(Customer_Rating)::NUMERIC,2) AS avg_customer_rating
FROM uber_table
GROUP BY Vehicle_Type;

--8) Find the average customer rating per vehicle type:
SELECT * FROM Avg_Customer_Rating_Per_Vehicle_Type;


--9) Calculate the total booking value of rides completed successfully

CREATE VIEW total_successful_ride_value AS
SELECT SUM(Booking_Value) AS total_booking_value
FROM uber_table
WHERE Booking_Status = 'Success';

--9) Calculate the total booking value of rides completed successfully
SELECT * FROM total_successful_ride_value;


--10) List all incomplete rides along with the reason

CREATE VIEW Incomplete_rides_With_reasons AS
SELECT Booking_ID,Incomplete_Rides,Incomplete_Rides_Reason
FROM uber_table
WHERE Incomplete_Rides = 'Yes';

--10) List all incomplete rides along with the reason
SELECT * FROM Incomplete_rides_With_reasons;





