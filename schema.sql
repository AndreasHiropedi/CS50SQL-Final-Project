--To enable foreign key
PRAGMA foreign_keys = ON;

-- Represent airport info
CREATE TABLE IF NOT EXISTS Airports (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "airport_name" TEXT NOT NULL,
    "airport_code" TEXT NOT NULL,
    "country_of_origin" TEXT NOT NULL
);

-- Represent airline info
CREATE TABLE IF NOT EXISTS Airlines (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "airline_name" TEXT NOT NULL,
    "country_of_origin" TEXT NOT NULL
);

-- Represents aircraft manufacturers info
CREATE TABLE IF NOT EXISTS Manufacturers (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "manufacturer_name" TEXT NOT NULL
);

-- Represents aircraft info
CREATE TABLE IF NOT EXISTS Aircrafts (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "manufacturer_id" INTEGER,
    "aircraft_type" TEXT NOT NULL,
    FOREIGN KEY ("manufacturer_id") REFERENCES Manufacturers("id")
);

-- Represent flight info
CREATE TABLE IF NOT EXISTS Flights (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "airline_id" INTEGER,
    "aircraft_id" INTEGER,
    "departing_airport_code" TEXT,
    "arrival_airport_code" TEXT,
    "flight_number" TEXT NOT NULL,
    "original_departing_time" TIME NOT NULL,
    "original_arrival_time" TIME NOT NULL,
    "actual_departing_time" TIME NOT NULL,
    "actual_arrival_time" TIME NOT NULL,
    "number_of_passengers" INTEGER NOT NULL CHECK("number_of_passengers" != 0),
    FOREIGN KEY ("airline_id") REFERENCES Airlines("id"),
    FOREIGN KEY ("aircraft_id") REFERENCES Aircrafts("id")
);


-- Indexes
CREATE INDEX IF NOT EXISTS "airport_search" ON "Airports"("airport_name", "airport_code", "country_of_origin");
CREATE INDEX IF NOT EXISTS "airline_search" ON "Airlines"("airline_name", "country_of_origin");


-- Views

-- view aircraft manufacturers and their respective aircrafts
CREATE VIEW IF NOT EXISTS "aircrafts_by_manufacturer" AS
SELECT "manufacturer_name", "Aircrafts"."aircraft_type"
FROM "Manufacturers" JOIN "Aircrafts" ON "Aircrafts"."manufacturer_id" = "Manufacturers"."id"
ORDER BY "manufacturer_name" ASC;

-- view flights by company
CREATE VIEW IF NOT EXISTS "flights_by_company" AS
SELECT "Airlines"."airline_name", "flight_number", "number_of_passengers", "departing_airport_code", "arrival_airport_code", "Aircrafts"."aircraft_type"
FROM "Flights" JOIN "Airlines" ON "Flights"."airline_id" = "Airlines"."id"
JOIN "Aircrafts" ON "Flights"."aircraft_id" = "Aircrafts"."id";

-- view to determine punctuality of flights by company
CREATE VIEW IF NOT EXISTS "punctuality_by_company" AS
SELECT "Airlines"."airline_name", "flight_number", "original_departing_time", "actual_departing_time", "original_arrival_time", "actual_arrival_time"
FROM "Flights" JOIN "Airlines" ON "Flights"."airline_id" = "Airlines"."id"
JOIN "Aircrafts" ON "Flights"."aircraft_id" = "Aircrafts"."id";

-- view flights with all statistics (aircraft type, departure time (scheduled vs actual), arrival time, etc.)
CREATE VIEW IF NOT EXISTS "flights_statistics" AS
SELECT "Airlines"."airline_name", "flight_number", "departing_airport_code", "arrival_airport_code", "Aircrafts"."aircraft_type", "original_departing_time", "actual_departing_time", "original_arrival_time", "actual_arrival_time"
FROM "Flights" JOIN "Airlines" ON "Flights"."airline_id" = "Airlines"."id"
JOIN "Aircrafts" ON "Flights"."aircraft_id" = "Aircrafts"."id";
