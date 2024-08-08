# Design Document

By Andreas Hiropedi

Video overview: https://youtu.be/bjVgjOzwL_w

## Scope

This database is designed to easily store the data monitoring different flights to/ from different destinations, similarly to how Flight Radar monitors flights worldwide.

The following items are **included** in the database:

- ** Airports **: this table stores information about the airports avialable;
- ** Airlines **: stores information about the different airlines included;
- ** Manufacturers **: this table contains information about the different airline manufacturers (such as Airbus or Boeing);
- ** Aircrafts **: in this table we store the types of aircrafts available;
- ** Flights **: this table stores information about different flights based on certain routes;

The following are **excluded** from the database:

- This database is a mock version, so not **all** existing aircrafts/ airports/ airlines were included
- Only basic information was included per table, for instance:
    - airports capacity was not included
    - maximum aircraft capacity was also omitted
    - whether the aircraft type has been retired or not has also been omitted

## Functional Requirements

Users can freely query all the data, since none of the data is meant to be confidential (similarly to how on Flight Radar users can access all data about all possible flights).

## Representation

### Entities

All tables have the <code> IF NOT EXISTS </code> conditions to avoid any issues with duplicates or any other schema problems.

**Airports**

- <code> "id" </code> indicates the unique identification number per airport. For this reason, the type is <code>INTEGER</code>. Since there will always be an unique ID of the airport, it will also be the <code> PRIMARY KEY </code>. ID value will also be added automatically using <code>AUTOINCREMENT</code>.
- <code> "airport_name" </code> every airport should have a name, hence the type is <code>TEXT</code>. Since all airports have a name, this value has the condition of <code>NOT NULL</code>.
- <code> "airport_code" </code> similarly to the name, the type will be <code>TEXT</code>, and since all airports have a code, this value has the condition of <code>NOT NULL</code>.
- <code> "country_of_origin" </code> once again, the type here will be <code>TEXT</code>, and since all airports must have a contry of origin, this value has the condition of <code>NOT NULL</code>.

**Airlines**

- <code> "id" </code> indicates the unique identification number per airline. For this reason, the type is <code>INTEGER</code>. Since there will always be an unique ID of the airline, it will also be the <code> PRIMARY KEY </code>. ID value will also be added automatically using <code>AUTOINCREMENT</code>.
- <code> "airline_name" </code> every airline should have a name, hence the type is <code>TEXT</code>. Since all airlines have a name, this value has the condition of <code>NOT NULL</code>.
- <code> "country_of_origin" </code> once again, the type here will be <code>TEXT</code>, and since all airlines must have a contry of origin, this value has the condition of <code>NOT NULL</code>.

**Manufacturers**

- <code> "id" </code> indicates the unique identification number per aircraft manufacturer. For this reason, the type is <code>INTEGER</code>. Since there will always be an unique ID of the manufacturer, it will also be the <code> PRIMARY KEY </code>. ID value will also be added automatically using <code>AUTOINCREMENT</code>.
- <code> "manufacturer_name" </code> every manufacturer should have a name, hence the type is <code>TEXT</code>. Since all manufacturers have a name, this value has the condition of <code>NOT NULL</code>.

**Aircrafts**

- <code> "id" </code> indicates the unique identification number per aircraft. For this reason, the type is <code>INTEGER</code>. Since there will always be an unique ID of the aircraft, it will also be the <code> PRIMARY KEY </code>. ID value will also be added automatically using <code>AUTOINCREMENT</code>.
- <code> "manufacturer_id" </code> specifies the ID of the manufacturer of that aircraft, hence the type is <code>INTEGER</code>. The <code>FOREIGN KEY</code> constraint applied to the 'id' column in the 'Manufacturers' table is restricted.
- <code> "aircraft_type" </code> every aircraft should have a name/ type, hence the type is <code>TEXT</code>. Since all aircrafts must have one, this value has the condition of <code>NOT NULL</code>.

**Flights**

- <code> "id" </code> indicates the unique identification number per flight. For this reason, the type is <code>INTEGER</code>. Since there will always be an unique ID of the flight, it will also be the <code> PRIMARY KEY </code>. ID value will also be added automatically using <code>AUTOINCREMENT</code>.
- - <code> "airline_id" </code> specifies the ID of the airline, hence the type is <code>INTEGER</code>. The <code>FOREIGN KEY</code> constraint applied to the 'id' column in the 'Airlines' table is restricted.
- <code> "aircraft_id" </code> specifies the ID of the aircraft, hence the type is <code>INTEGER</code>. The <code>FOREIGN KEY</code> constraint applied to the 'id' column in the 'Aircrafts' table is restricted.
- <code> "departing_airport_code" </code> indicates the code of the airport from where the flight is departing, hence the type is <code>TEXT</code>. Moreover, since the value cannot be empty, this value has the condition of <code>NOT NULL</code>.
- <code> "arrival_airport_code" </code> indicates the code of the airport where the flight is arriving at, hence the type is <code>TEXT</code>. Moreover, since the value cannot be empty, this value has the condition of <code>NOT NULL</code>.
- <code> "flight_number" </code> indicates the code (mix of letters and numbers) corresponding to the specific flight, and so the type is <code>TEXT</code>. Since each flight must have a flight number, this value has the condition of <code>NOT NULL</code>.
- <code> "original_departing_time" </code> indicates the original intended departure time for the flight (ETD, estimated time of departure). Hence, the type is <code>TIME</code>, and since each flight must have an ETD, this value has the condition of <code>NOT NULL</code>.
- <code> "original_arrival_time" </code> indicates the original intended arrival time for the flight (ETA, estimated time of arrival). Hence, the type is <code>TIME</code>, and since each flight must have an ETA, this value has the condition of <code>NOT NULL</code>.
- <code> "actual_departing_time" </code> indicates the actual departure time for the flight, and hence the type is <code>TIME</code>. Since each flight must have an actual departure time, this value has the condition of <code>NOT NULL</code>.
- <code> "actual_arrival_time" </code> indicates the actual arrival time for the flight, and hence the type is <code>TIME</code>. Since each flight must have an actual arrival time (unless it crashes), this value has the condition of <code>NOT NULL</code>.
- <code> "number_of_passengers" </code> indicates the number of passengers on that flight. The type is therefore <code>INTEGER</code>, and we enforce the <code>NOT NULL</code> condition since this value can't be <code>NULL</code>. Additionally, since a plane wouldn't normally take off without passengers (unless it is a cargo flight which is not represented here), we enforce a further check saying <code> CHECK("number_of_passengers" != 0) </code>.

### Relationships

**Relationships**

- There can be multiple flights leaving from the same airport, and multiple flights arriving at the same airport
- There can be multiple aircrats made by the same aircraft manufacturer, but no aircraft has more than one manufacturer
- There can be multiple flights operated by the same airline

## Optimizations

### Indexes

- "airport_search": for faster look-up of information about a specific airport (or all airports)
- "airline_search": for faster look-up of information about a specific airline (or all airlines)

### Views

- "aircrafts_by_manufacturer": is users wish to find out more about the fleet of aircrafts that an airline has
- "flights_by_company": if users wish to explore the routes made available by different airlines
- "punctuality_by_company": if users wish to monitor how punctual a specific airline has been based on its flights
- "flights_statistics": if users want to access all statistics (or just query for some) about specific flights

## Limitations

- scheduled versus actual departure times are hard-coded (but considered)
- whether a company chose to retire an aircraft is also not represented
- does not account for plane crashes (where the plane doesn't reach the intended destination)
- does not represent cargo flights
