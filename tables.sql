-- Assumes there is an existing database which we create the following tables in
CREATE TABLE operators (
    operator_number CHAR(8) PRIMARY KEY,
    name_of_operator VARCHAR(50) NOT NULL,
    address VARCHAR(30) NOT NULL,
    occupation CHAR(15) NOT NULL,
    no_of_operational_units INT NOT NULL,
    age SMALLINT CHECK (age >= 0) NOT NULL,
    contact_Number CHAR(10) NOT NULL
);

CREATE TABLE routes (
    route_ID CHAR(8) PRIMARY KEY,
    start_route VARCHAR(40) NOT NULL,
    end_Route VARCHAR(40) NOT NULL, -- Had to increase to 40
    route_length DECIMAL(3, 0) CHECK (route_length >= 0),
    base_fare SMALLINT CHECK (base_fare >= 0) NOT NULL
);

CREATE TABLE components (
    model VARCHAR(10) PRIMARY KEY,
    brake_system DECIMAL(6, 2) CHECK (brake_system >= 0),
    clutch DECIMAL(6, 2) CHECK (clutch >= 0),
    tires DECIMAL(6, 2) CHECK (tires >= 0),
    battery DECIMAL(6, 2) CHECK (battery >= 0),
    bearings DECIMAL(6, 2) CHECK (bearings >= 0),
    belt DECIMAL(6, 2) CHECK (belt >= 0),
    fuel_filter DECIMAL(6, 2) CHECK (fuel_filter >= 0),
    piston_ring DECIMAL(6, 2) CHECK (piston_ring >= 0),
    lights DECIMAL(6, 2) CHECK (lights >= 0),
    body DECIMAL(6, 2) CHECK (body >= 0),
    electrical_system DECIMAL(6, 2) CHECK (electrical_system >= 0)
);


CREATE TABLE vehicles (
    plate_number CHAR(8) PRIMARY KEY,
    vehicle_type CHAR(3) CHECK (vehicle_type IN ('Bus', 'PUJ', 'UV')) NOT NULL,
    manufacturer VARCHAR(30) NOT NULL,
    model VARCHAR(30) NOT NULL REFERENCES components,
    year SMALLINT CHECK (year BETWEEN 0 AND 2024) NOT NULL, -- DATE type in Postgres has day/minute resolutoin which we will never make use of
    revenue DECIMAL(6, 2) CHECK (revenue >= 0) NOT NULL,
    engine_condition CHAR CHECK (engine_condition IN ('Good', 'Bad')) NOT NULL,
    seat_capacity INT CHECK (seat_capacity BETWEEN 0 AND 999),
    operation_times CHAR(12) NOT NULL,
    operator_number CHAR(8) NOT NULL REFERENCES operators,
    route_id CHAR(8) NOT NULL REFERENCES routes
);