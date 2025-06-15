------------------------------
-- Database & Initialization
------------------------------
CREATE DATABASE hospital_patient_records_analysis;
USE hospital_patient_records_analysis;

---------------------
-- A. Create Tables
---------------------

------------------------------------------------------------
-- 1. Create Patients Table - Stores Patient Demographics
------------------------------------------------------------
CREATE TABLE patients (
    id VARCHAR(50) PRIMARY KEY,
    birthdate DATE,
    deathdate VARCHAR(50),
    prefix VARCHAR(10),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    suffix VARCHAR(10),
    maiden VARCHAR(50),
    marital_status VARCHAR(50),
    race VARCHAR(50),
    ethnicity VARCHAR(50),
    gender VARCHAR(10),
    birthplace VARCHAR(100),
    address VARCHAR(500),
    city VARCHAR(100),
    state VARCHAR(50),
    country VARCHAR(50),
    zip VARCHAR(10),
    lat FLOAT,
    lon FLOAT
);

SET GLOBAL local_infile = 1;

-- Import data from a CSV file (big data)
LOAD DATA LOCAL INFILE 'C:/Users/Sudee/OneDrive/Desktop/Hospital+Patient+Records/patients.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Display Table
SELECT * FROM patients;

-- Display the schemas
DESCRIBE patients;

-- Check for null id value
SELECT 
    COUNT(*) AS total_rows,
    COUNT(id) AS non_null_ids,
    COUNT(CASE WHEN id IS NULL THEN 1 END) AS null_ids
FROM 
    patients;

-- Update all empty strings to NULL
UPDATE patients
SET
  deathdate = NULLIF(TRIM(deathdate), ''),
  suffix = NULLIF(TRIM(suffix), ''),
  maiden = NULLIF(TRIM(maiden), '');

-- Convert data types
ALTER TABLE patients
MODIFY COLUMN deathdate DATE;

------------------------------------------------------------------
-- 2. Create Organisations Table - Hospital Facilities & Clinics
------------------------------------------------------------------
CREATE TABLE organisations (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(50),
    zip VARCHAR(10),
    lat FLOAT,
    lon FLOAT
);

-- Import data from a CSV file (big data)
LOAD DATA LOCAL INFILE 'C:/Users/Sudee/OneDrive/Desktop/Hospital+Patient+Records/organizations.csv'
INTO TABLE organisations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Display Table
SELECT * FROM organisations;

-- Display the schemas
DESCRIBE organisations;

-------------------------------------------------
-- 3. Create Payers Table - Insurance Providers
-------------------------------------------------
CREATE TABLE payers (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(100),
    city VARCHAR(50),
    state_headquartered VARCHAR(100),
    zip VARCHAR(10),
    phone VARCHAR(20)
);

-- Import data from a CSV file (big data)
LOAD DATA LOCAL INFILE 'C:/Users/Sudee/OneDrive/Desktop/Hospital+Patient+Records/payers.csv'
INTO TABLE payers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Display Table
SELECT * FROM payers;

-- Display the schemas
DESCRIBE payers;

-------------------------------------------------------
-- 4. Create Encounters Table - Tracks Patient Visits
-------------------------------------------------------
CREATE TABLE encounters (
    id VARCHAR(50) PRIMARY KEY,
    start VARCHAR(100),
    stop VARCHAR(100),
    patient VARCHAR(100),
    organisation VARCHAR(100),
    payer VARCHAR(100),
    encounter_class VARCHAR(100),
    code VARCHAR(50),
    description VARCHAR(200),
    base_encounter_cost FLOAT,
    total_claim_cost FLOAT,
    payer_coverage FLOAT,
    reasoncode VARCHAR(100),
    reason_description VARCHAR(200)
   );

-- Import data from a CSV file (big data)
LOAD DATA LOCAL INFILE 'C:/Users/Sudee/OneDrive/Desktop/Hospital+Patient+Records/encounters.csv'
INTO TABLE encounters
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Display Table
SELECT * FROM encounters;

-- Display the schemas
DESCRIBE encounters;

-- Update all empty strings to NULL
UPDATE encounters
SET
  reasoncode = NULLIF(TRIM(reasoncode), ''),
  reason_description= NULLIF(TRIM(reason_description),'');

-- Convert Datatypes DATETIME
UPDATE encounters
SET start = STR_TO_DATE(REPLACE(REPLACE(start, 'T', ' '), 'Z', ''), '%Y-%m-%d %H:%i:%s');

UPDATE encounters
SET stop = STR_TO_DATE(REPLACE(REPLACE(stop, 'T', ' '), 'Z', ''), '%Y-%m-%d %H:%i:%s');

-- Convert data types
ALTER TABLE encounters
MODIFY COLUMN start DATETIME,
MODIFY COLUMN stop DATETIME;

-----------------------------------------------------
-- 5. Create Procedures Table - Medical Procedures
-----------------------------------------------------
Create Table procedures (
    start VARCHAR(100),
    stop VARCHAR(100),
    patient VARCHAR(100),
    encounter varchar(100),
    code VARCHAR(100),
    description varchar(200),
    base_cost VARCHAR(100),
    reasoncode VARCHAR(100),
    reason_description VARCHAR(200)
    );

-- Import data from a CSV file (big data)
LOAD DATA LOCAL INFILE 'C:/Users/Sudee/OneDrive/Desktop/Hospital+Patient+Records/procedures.csv'
INTO TABLE procedures
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Display Table
SELECT * FROM procedures;

-- Display the schemas
DESCRIBE procedures;

-- Update all empty strings to NULL
UPDATE procedures
SET
  reasoncode = NULLIF(TRIM(reasoncode), ''),
  reason_description= NULLIF(TRIM(reason_description),'');

-- Convert Datatypes DATETIME
UPDATE procedures
SET start = STR_TO_DATE(REPLACE(REPLACE(start, 'T', ' '), 'Z', ''), '%Y-%m-%d %H:%i:%s');

UPDATE procedures
SET stop = STR_TO_DATE(REPLACE(REPLACE(stop, 'T', ' '), 'Z', ''), '%Y-%m-%d %H:%i:%s');

-- Convert data types
ALTER TABLE procedures
MODIFY COLUMN base_cost INT,
MODIFY COLUMN start DATETIME,
MODIFY COLUMN stop DATETIME;



