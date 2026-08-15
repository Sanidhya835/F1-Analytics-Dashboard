CREATE DATABASE formula1_analytics;

USE formula1_analytics;

CREATE TABLE drivers (
    driverId INT PRIMARY KEY,
    driverRef VARCHAR(50),
    number INT,
    code VARCHAR(5),
    forename VARCHAR(50),
    surname VARCHAR(50),
    dob DATE,
    nationality VARCHAR(50),
    url VARCHAR(255)
);

CREATE TABLE constructors (
    constructorId INT PRIMARY KEY,
    constructorRef VARCHAR(50),
    name VARCHAR(100),
    nationality VARCHAR(50),
    url VARCHAR(255)
);

CREATE TABLE circuits (
    circuitId INT PRIMARY KEY,
    circuitRef VARCHAR(100),
    name VARCHAR(150),
    location VARCHAR(100),
    country VARCHAR(100),
    lat DECIMAL(10,6),
    lng DECIMAL(10,6),
    alt INT,
    url VARCHAR(255)
);

CREATE TABLE status (
    statusId INT PRIMARY KEY,
    status VARCHAR(100)
);

CREATE TABLE seasons (
    year INT PRIMARY KEY,
    url VARCHAR(255)
);

CREATE TABLE races (
    raceId INT PRIMARY KEY,
    year INT,
    round INT,
    circuitId INT,
    name VARCHAR(150),
    date DATE,
    time TIME,
    url VARCHAR(255),

    fp1_date DATE,
    fp1_time TIME,

    fp2_date DATE,
    fp2_time TIME,

    fp3_date DATE,
    fp3_time TIME,

    quali_date DATE,
    quali_time TIME,

    sprint_date DATE,
    sprint_time TIME,

    FOREIGN KEY (year)
        REFERENCES seasons(year),

    FOREIGN KEY (circuitId)
        REFERENCES circuits(circuitId)
);

CREATE TABLE qualifying (
    qualifyId INT PRIMARY KEY,

    raceId INT,
    driverId INT,
    constructorId INT,

    number INT,
    position INT,

    q1 VARCHAR(20),
    q2 VARCHAR(20),
    q3 VARCHAR(20),

    FOREIGN KEY (raceId)
        REFERENCES races(raceId),

    FOREIGN KEY (driverId)
        REFERENCES drivers(driverId),

    FOREIGN KEY (constructorId)
        REFERENCES constructors(constructorId)
);

CREATE TABLE results (

    resultId INT PRIMARY KEY,

    raceId INT,
    driverId INT,
    constructorId INT,

    number INT,
    grid INT,
    position INT,

    positionText VARCHAR(10),

    positionOrder INT,

    points DECIMAL(6,2),

    laps INT,

    time VARCHAR(50),

    milliseconds BIGINT,

    fastestLap INT,

    `rank` INT,

    fastestLapTime VARCHAR(20),

    fastestLapSpeed DECIMAL(8,3),

    statusId INT,

    FOREIGN KEY (raceId)
        REFERENCES races(raceId),

    FOREIGN KEY (driverId)
        REFERENCES drivers(driverId),

    FOREIGN KEY (constructorId)
        REFERENCES constructors(constructorId),

    FOREIGN KEY (statusId)
        REFERENCES status(statusId)
);

CREATE TABLE driver_standings (

    driverStandingsId INT PRIMARY KEY,

    raceId INT,
    driverId INT,

    points DECIMAL(8,2),

    position INT,

    positionText VARCHAR(10),

    wins INT,

    FOREIGN KEY (raceId)
        REFERENCES races(raceId),

    FOREIGN KEY (driverId)
        REFERENCES drivers(driverId)
);

CREATE TABLE constructor_standings (

    constructorStandingsId INT PRIMARY KEY,

    raceId INT,
    constructorId INT,

    points DECIMAL(8,2),

    position INT,

    positionText VARCHAR(10),

    wins INT,

    FOREIGN KEY (raceId)
        REFERENCES races(raceId),

    FOREIGN KEY (constructorId)
        REFERENCES constructors(constructorId)
);

CREATE TABLE constructor_results (

    constructorResultsId INT PRIMARY KEY,

    raceId INT,

    constructorId INT,

    points DECIMAL(8,2),

    status VARCHAR(50),

    FOREIGN KEY (raceId)
        REFERENCES races(raceId),

    FOREIGN KEY (constructorId)
        REFERENCES constructors(constructorId)
);

CREATE TABLE sprint_results (

    resultId INT PRIMARY KEY,

    raceId INT,
    driverId INT,
    constructorId INT,

    number INT,
    grid INT,
    position INT,

    positionText VARCHAR(10),

    positionOrder INT,

    points DECIMAL(8,2),

    laps INT,

    time VARCHAR(50),

    milliseconds BIGINT,

    fastestLap INT,

    fastestLapTime VARCHAR(20),

    statusId INT,

    `rank` INT,

    FOREIGN KEY (raceId)
        REFERENCES races(raceId),

    FOREIGN KEY (driverId)
        REFERENCES drivers(driverId),

    FOREIGN KEY (constructorId)
        REFERENCES constructors(constructorId),

    FOREIGN KEY (statusId)
        REFERENCES status(statusId)
);

CREATE TABLE lap_times (

    raceId INT,
    driverId INT,

    lap INT,
    position INT,

    time VARCHAR(20),

    milliseconds INT,

    PRIMARY KEY (raceId, driverId, lap),

    FOREIGN KEY (raceId)
        REFERENCES races(raceId),

    FOREIGN KEY (driverId)
        REFERENCES drivers(driverId)
);

CREATE TABLE pit_stops (

    raceId INT,
    driverId INT,

    stop INT,
    lap INT,

    time TIME,

    duration VARCHAR(20),

    milliseconds INT,

    PRIMARY KEY (raceId, driverId, stop),

    FOREIGN KEY (raceId)
        REFERENCES races(raceId),

    FOREIGN KEY (driverId)
        REFERENCES drivers(driverId)
);

SHOW TABLES;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'formula1_analytics'
  AND REFERENCED_TABLE_NAME IS NOT NULL;
  
SELECT COUNT(*) AS total_seasons
FROM seasons;

SELECT *
FROM seasons
LIMIT 5;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM lap_times;

SET SQL_SAFE_UPDATES = 1;

SELECT COUNT(*) AS total_rows
FROM lap_times;

USE formula1_analytics;

SELECT 'drivers' AS table_name, COUNT(*) AS rows_count FROM drivers
UNION ALL
SELECT 'constructors', COUNT(*) FROM constructors
UNION ALL
SELECT 'circuits', COUNT(*) FROM circuits
UNION ALL
SELECT 'status', COUNT(*) FROM status
UNION ALL
SELECT 'seasons', COUNT(*) FROM seasons
UNION ALL
SELECT 'races', COUNT(*) FROM races
UNION ALL
SELECT 'qualifying', COUNT(*) FROM qualifying
UNION ALL
SELECT 'results', COUNT(*) FROM results
UNION ALL
SELECT 'driver_standings', COUNT(*) FROM driver_standings
UNION ALL
SELECT 'constructor_standings', COUNT(*) FROM constructor_standings
UNION ALL
SELECT 'constructor_results', COUNT(*) FROM constructor_results
UNION ALL
SELECT 'sprint_results', COUNT(*) FROM sprint_results
UNION ALL
SELECT 'lap_times', COUNT(*) FROM lap_times
UNION ALL
SELECT 'pit_stops', COUNT(*) FROM pit_stops;