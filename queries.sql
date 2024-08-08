-- Data insertions

-- manufacturers
INSERT INTO Manufacturers("manufacturer_name") VALUES ("Airbus");
INSERT INTO Manufacturers("manufacturer_name") VALUES ("Boeing");
INSERT INTO Manufacturers("manufacturer_name") VALUES ("Embraer");
INSERT INTO Manufacturers("manufacturer_name") VALUES ("McDonell-Douglas");

-- aircrafts
INSERT INTO Aircrafts("manufacturer_id", "aircraft_type") VALUES (1, "A320");
INSERT INTO Aircrafts("manufacturer_id", "aircraft_type") VALUES (1, "A321");
INSERT INTO Aircrafts("manufacturer_id", "aircraft_type") VALUES (1, "A350");
INSERT INTO Aircrafts("manufacturer_id", "aircraft_type") VALUES (1, "A380");
INSERT INTO Aircrafts("manufacturer_id", "aircraft_type") VALUES (2, "B737");
INSERT INTO Aircrafts("manufacturer_id", "aircraft_type") VALUES (2, "B747");
INSERT INTO Aircrafts("manufacturer_id", "aircraft_type") VALUES (2, "B777");
INSERT INTO Aircrafts("manufacturer_id", "aircraft_type") VALUES (2, "B787");
INSERT INTO Aircrafts("manufacturer_id", "aircraft_type") VALUES (3, "E170");
INSERT INTO Aircrafts("manufacturer_id", "aircraft_type") VALUES (3, "E195");
INSERT INTO Aircrafts("manufacturer_id", "aircraft_type") VALUES (4, "MD11");

-- airlines
INSERT INTO Airlines("airline_name", "country_of_origin") VALUES ("United", "USA");
INSERT INTO Airlines("airline_name", "country_of_origin") VALUES ("Delta", "USA");
INSERT INTO Airlines("airline_name", "country_of_origin") VALUES ("Emirates", "UAE");
INSERT INTO Airlines("airline_name", "country_of_origin") VALUES ("Etihad", "UAE");
INSERT INTO Airlines("airline_name", "country_of_origin") VALUES ("KLM", "Netherlands");
INSERT INTO Airlines("airline_name", "country_of_origin") VALUES ("Ryainair", "Ireland");
INSERT INTO Airlines("airline_name", "country_of_origin") VALUES ("British Airways", "UK");
INSERT INTO Airlines("airline_name", "country_of_origin") VALUES ("Qatar Airways", "Qatar");
INSERT INTO Airlines("airline_name", "country_of_origin") VALUES ("Air France", "France");
INSERT INTO Airlines("airline_name", "country_of_origin") VALUES ("EasyJet", "UK");

-- airports
INSERT INTO Airports("airport_name", "airport_code", "country_of_origin") VALUES ("London Heathrow", "LHR", "UK");
INSERT INTO Airports("airport_name", "airport_code", "country_of_origin") VALUES ("London Stansted", "LST", "UK");
INSERT INTO Airports("airport_name", "airport_code", "country_of_origin") VALUES ("London Luton", "LTN", "UK");
INSERT INTO Airports("airport_name", "airport_code", "country_of_origin") VALUES ("Edinburgh Airport", "EDI", "UK");
INSERT INTO Airports("airport_name", "airport_code", "country_of_origin") VALUES ("Bucharest Otopeni", "OTP", "Romania");
INSERT INTO Airports("airport_name", "airport_code", "country_of_origin") VALUES ("Hamad Airport", "DOH", "Qatar");
INSERT INTO Airports("airport_name", "airport_code", "country_of_origin") VALUES ("Milano Malpensa", "MLP", "Italy");
INSERT INTO Airports("airport_name", "airport_code", "country_of_origin") VALUES ("Amsterdam Schipol", "AMS", "Netherlands");
INSERT INTO Airports("airport_name", "airport_code", "country_of_origin") VALUES ("Dubai Airport", "DXB", "UAE");
INSERT INTO Airports("airport_name", "airport_code", "country_of_origin") VALUES ("John F Kennedy Airport", "JFK", "USA");

-- flights
INSERT INTO Flights("airline_id", "aircraft_id", "departing_airport_code", "arrival_airport_code", "flight_number", "original_departing_time", "original_arrival_time", "actual_departing_time", "actual_arrival_time", "number_of_passengers") VALUES
(3, 4, "DXB", "LHR", "EK8644", '10:00:00', '18:00:00', '12:00:00', '19:45:00', 500),
(3, 3, "DXB", "MLP", "EK8644", '14:00:00', '19:00:00', '14:30:00', '19:25:00', 370),
(3, 8, "DXB", "EDI", "EK8644", '12:00:00', '20:00:00', '12:00:00', '20:00:00', 430),
(6, 5, "LST", "EDI", "FR5341", '12:00:00', '13:00:00', '13:00:00', '13:50:00', 200),
(10, 2, "LTN", "EDI", "EZ5141", '12:00:00', '13:00:00', '13:00:00', '13:50:00', 190),
(10, 1, "LTN", "MLP", "EZ5361", '17:00:00', '18:40:00', '17:00:00', '18:40:00', 180),
(7, 1, "LHR", "OTP", "BA1261", '19:00:00', '22:50:00', '20:00:00', '23:40:00', 210),
(5, 7, "AMS", "EDI", "KL8644", '14:00:00', '16:30:00', '14:30:00', '17:00:00', 270),
(5, 7, "AMS", "LHR", "KL8644", '14:00:00', '15:30:00', '14:30:00', '16:00:00', 270),
(6, 5, "EDI", "MLP", "FR5753", '16:00:00', '18:30:00', '16:00:00', '18:25:00', 180);

-- Viewing queries

-- view all Airbus aircrafts
SELECT * FROM "aircrafts_by_manufacturer" WHERE "manufacturer_name" = 'Airbus';

-- view all airlines where the country of origin begins with the letter U
SELECT * FROM "Airlines" WHERE "country_of_origin" LIKE 'U%';

-- view all flights going through Edinburgh airport (either leaving from or arriving at)
SELECT "airline_name", "flight_number", "departing_airport_code", "arrival_airport_code", "aircraft_type" FROM "flights_statistics" WHERE "departing_airport_code" = 'EDI' OR "arrival_airport_code" = 'EDI';

-- view punctuality of A380 flights that left Dubai airport
SELECT "airline_name", "flight_number", "original_departing_time", "actual_departing_time" FROM "punctuality_by_company" WHERE "aircraft_type" = 'A380';
