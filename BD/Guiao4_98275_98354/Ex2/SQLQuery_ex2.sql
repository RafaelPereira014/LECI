CREATE SCHEMA voos
go

CREATE TABLE voos.flight(
    number INT NOT NULL PRIMARY KEY,
    weekdays varchar(30),
    airline TINYINT
);

CREATE TABLE voos.fare(
    code INT NOT NULL PRIMARY KEY,
    amoutn INT,
    restrictions varchar(30),
    flight_number INT NOT NULL REFERENCES voos.flight(number)
);

CREATE TABLE voos.airport(
    airport_code INT NOT NULL PRIMARY KEY,
    city varchar(20),
    state varchar(20),
    name varchar(20)
);

CREATE TABLE voos.airplane_type(
    type_name varchar(20) NOT NULL PRIMARY KEY,
    max_seats INT NOT NULL,
    company varchar(20)
);

CREATE TABLE voos.airplane(
    airplane_id INT NOT NULL PRIMARY KEY,
    total_no_of_seats INT NOT NULL,
    type_name varchar(20) NOT NULL REFERENCES voos.airplane_type(type_name)
);

CREATE TABLE voos.flightLeg(
    leg_no INT NOT NULL PRIMARY KEY,
    number INT NOT NULL REFERENCES voos.flight(number),
    airportcode_dep INT NOT NULL REFERENCES voos.airport(airport_code),
    airportcode_arr INT NOT NULL REFERENCES voos.airport(airport_code),
    SCH_arr DATE,
    SCH_dep DATE
);

CREATE TABLE voos.leg_instance(
    date_leg                    DATE    PRIMARY KEY NOT NULL,
    no_of_avaiable_seats    INT,
    airplane_id                INT        NOT NULL REFERENCES voos.airplane(airplane_id),
    leg_no                    INT        REFERENCES     voos.flightleg(leg_no),
    dep_time                DATE,
    arr_time                DATE,
    airportcode_arr            INT        NOT NULL    REFERENCES voos.airport(airport_code),
    airportcode_dep            INT        NOT NULL    REFERENCES voos.airport(airport_code)
);

CREATE TABLE voos.seat(
    seat_no INT NOT NULL PRIMARY KEY,
    customer_name VARCHAR(20),
    customer_cphone INT ,
    date_leg DATE NOT NULL REFERENCES voos.leg_instance(date_leg)
);