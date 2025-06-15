--------------------------------------------------
-- Use database hospital patient records analysis
--------------------------------------------------
USE hospital_patient_records_analysis;

-----------------------
-- Check some tables 
-----------------------
SELECT * FROM patients;
SELECT * FROM encounters;

--------------------------
-- B. Analytical Queries
--------------------------

----------------------------------
-- 1. Patient Admission Over Time
----------------------------------
SELECT 
    YEAR(start) AS year, 
    COUNT(id) AS total_admissions
FROM
    encounters
GROUP BY YEAR(start)
ORDER BY year;

------------------------------
-- 2. Average Length of Stay
------------------------------
SELECT 
    ROUND(AVG(DATEDIFF(stop, start)),2) AS avg_length_stay
FROM
    encounters;

----------------------
-- 3. Cost Per Visit
----------------------
SELECT 
    encounter_class,
    ROUND(AVG(base_encounter_cost), 2) AS Avg_Cost
FROM
    encounters
GROUP BY encounter_class;

-----------------------------------
-- 4. Insurance Coverage Analysis
-----------------------------------
SELECT 
    payer, 
    COUNT(DISTINCT pr.code) AS covered_procedures
FROM
    encounters AS e
        JOIN
    payers AS p ON e.payer = p.id
        JOIN
    procedures AS pr ON e.id = pr.encounter
GROUP BY payer
ORDER BY covered_procedures DESC;

----------------------------
-- 5. Hospital Utilisation
----------------------------
SELECT
    o.name AS organisation_name,
    YEAR(e.start) AS year,
    COUNT(e.id) AS total_encounters
FROM encounters AS e
JOIN organisations AS o
    ON e.organisation = o.id
GROUP BY o.name, YEAR(e.start)
ORDER BY o.name, year;

-------------------------------------------
-- 6. Patient Deceased by Encounter Types
-------------------------------------------
SELECT 
    e.encounter_class,
    COUNT(DISTINCT deathdate) AS deceased_patients
FROM
    patients p
        JOIN
    encounters AS e ON e.patient = p.id
GROUP BY e.encounter_class;

-------------------------------------------------------
-- C. Advanced SQL Queries Using CTEs & Window Functions
-------------------------------------------------------

------------------------------------------
-- 1. Patient Admissions & Re-admissions
------------------------------------------
WITH patient_admissions AS (
	SELECT 
    patient,
    YEAR(start) AS admission_year,
    COUNT(id) AS total_admissions
FROM
    encounters
GROUP BY patient , YEAR(start)
) 
SELECT 
    *,
    CASE
        WHEN total_admissions > 1 THEN 're-admitted'
        ELSE 'first_admission'
    END AS admission_status
FROM
    patient_admissions;

------------------------------------------------
-- 2. Average Length of Stay by Encounter Type
------------------------------------------------
WITH stay_duration AS (
	SELECT 
		encounter_class,
        DATEDIFF(stop, start) AS length_stay
	FROM encounters
)
SELECT 
    encounter_class, AVG(length_stay) AS avg_stay_duration
FROM
    stay_duration
GROUP BY encounter_class;
 
 ----------------------------------------
 -- 3. High-Cost Vs Low-Cost Treatments
 ----------------------------------------
 WITH ranked_encounters as (
	SELECT
		id,
        encounter_class,
        total_claim_cost,
        RANK() OVER (ORDER BY total_claim_cost DESC) AS cost_rank
	FROM encounters
)
SELECT
	id,
    encounter_class,
    total_claim_cost,
    cost_rank
FROM ranked_encounters
WHERE cost_rank <= 10;

-------------------------------------
-- 4. Insurance Coverage Percentage
-------------------------------------
WITH insurance_coverage AS (
	SELECT
		payer,
        COUNT(DISTINCT p.code) AS covered_procedures,
        COUNT(DISTINCT encounter) AS total_encounters
	FROM encounters AS e
    JOIN procedures AS p 
    ON e.id = p.encounter
    GROUP BY payer
)
SELECT 
    payer,
    covered_procedures,
    ROUND((covered_procedures * 100 / total_encounters),2) AS coverage_percentage
FROM
    insurance_coverage
ORDER BY coverage_percentage DESC;

----------------------------------------------
-- 5. Hospital Utilisation & Rolling Average   
----------------------------------------------  
WITH organisation_utilisation AS (
	SELECT
		o.name,
        YEAR(e.start) AS year,
        COUNT(e.id) AS total_encounters
	FROM encounters AS e
    JOIN organisations AS o
        ON e.organisation = o.id
    GROUP BY o.name, YEAR(e.start)
)
SELECT 
	name,
    year,
    total_encounters,
    ROUND(AVG(total_encounters) OVER (
        PARTITION BY name 
        ORDER BY year 
        ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
    ), 2) AS RollingAvg12Years
FROM organisation_utilisation;

----------------------------------------
-- 6. Patient Visit Frequency & Trends
----------------------------------------
WITH visit_counts AS (
	SELECT
		patient,
        count(id) AS total_visits,
        MIN(start) AS first_visit,
        MAX(start) AS most_recent_visit
	FROM encounters
    GROUP BY patient
)
SELECT 
    patient,
    total_visits,
    first_visit,
    most_recent_visit,
    CASE
        WHEN total_visits >= 5 THEN 'frequent visitor'
        WHEN total_visits BETWEEN 2 AND 4 THEN 'returing patient'
        ELSE 'first-time patient'
    END AS patient_category
FROM
    visit_counts
ORDER BY total_visits DESC;

----------------------------------
-- 7. Hospital Revenue Insights
----------------------------------
WITH revenue_breakdown AS (
	SELECT
		o.name,
        ROUND(SUM(total_claim_cost),2) AS total_revenue,
        ROUND(SUM(payer_coverage),2) AS insurance_paid,
        ROUND(COUNT(e.id),2) AS total_encounters
	FROM encounters AS e 
    JOIN organisations AS o
    ON e.organisation = o.id
    GROUP BY organisation
)
SELECT name, total_encounters, total_revenue, insurance_paid, 
		ROUND((insurance_paid * 100/ total_revenue),2) AS coverage_percentage
FROM revenue_breakdown;

-------------------------------------------------
-- 8. Most Common Procedures & Associated Costs
-------------------------------------------------
WITH procedure_frequency AS (
	SELECT
		description,
        COUNT(*) AS total_performed,
        ROUND(AVG(base_cost),2) AS avg_procedure_cost,
        DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS procedure_rank
	FROM procedures
    GROUP BY description
)
SELECT description, total_performed, avg_procedure_cost, procedure_rank
	FROM procedure_frequency
    WHERE procedure_rank <= 10;
        
------------------------------------------------
-- 9. Patient Mortality Rate by Encounter Type
------------------------------------------------
WITH mortality_status AS (
	SELECT
		e. encounter_class,
        COUNT(DISTINCT e.patient) AS total_patients,
        COUNT(DISTINCT CASE WHEN p.deathdate IS NOT NULL THEN p.id END) AS deceased_patients
	FROM encounters AS e
    JOIN patients AS p
    ON e.patient = p.id
    GROUP BY e.encounter_class
)
SELECT encounter_class, total_patients, deceased_patients,
		ROUND((deceased_patients * 100/ total_patients),2) AS mortality_rate
FROM mortality_status
ORDER BY mortality_rate DESC;

------------------------------------------
-- 10. Insurance Cost vs Patient Payments
------------------------------------------
WITH cost_breakdown AS (
	SELECT 
		payer,
		ROUND(SUM(payer_coverage),2) AS insurance_paid,
		ROUND(SUM(total_claim_cost - payer_coverage),2) AS patient_paid,
		ROUND(SUM(total_claim_cost),2) AS total_cost
	FROM encounters
	GROUP BY payer
)
SELECT payer, insurance_paid, patient_paid, total_cost,
		ROUND((insurance_paid * 100 / total_cost),2) AS insurance_coverage_rate,
        ROUND((patient_paid * 100 / total_cost),2) AS out_of_pocket_rate
FROM cost_breakdown
order by insurance_coverage_rate DESC;
    
