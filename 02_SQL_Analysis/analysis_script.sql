-- =====================================================================
-- 🧮 WATER ACCESS ANALYTICS – SQL ANALYSIS PIPELINE
-- Author: Olise Ebinum
-- Description: 
--   This SQL analysis script explores data discrepancies between auditors 
--   and surveyors in recorded water quality assessments. It identifies 
--   inconsistencies, validates data integrity, and highlights human 
--   reporting errors through step-by-step joins, filters, CTEs, and text 
--   analysis.
--
-- Skills Demonstrated:
--   ✅ Data integrity validation and relational joins
--   ✅ Aggregation, filtering, and conditional logic
--   ✅ CTE design for modular analytical workflows
--   ✅ Error detection, ranking, and text pattern matching
--
-- Database: md_water_services
-- =====================================================================


-- ================================================================
-- STEP 0: Preview the auditor_report table
-- Purpose: Verify data is correctly loaded and accessible.
-- ================================================================
SELECT * FROM md_water_services.auditor_report;


-- ================================================================
-- Activate database context
-- ================================================================
USE md_water_services; 


-- ================================================================
-- 🔹 PART 1: Basic Table Join
-- Join auditor_report with visits to link inspection locations
-- ================================================================
SELECT 
	auditor_report.location_id  AS Auditor_Location,
    auditor_report.true_water_source_score,
    visits.location_id AS Visits_Location,
    visits.record_id
FROM auditor_report
INNER JOIN visits 
    ON auditor_report.location_id = visits.location_id; 



-- ================================================================
-- 🔹 PART 2: Join with Water Quality Table
-- Expands analysis by bringing in surveyor (subjective) quality scores
-- ================================================================
SELECT 
	auditor_report.location_id  AS Auditor_Location,
    auditor_report.true_water_source_score,
    visits.location_id AS Visits_Location,
    visits.record_id,
    subjective_quality_score
FROM auditor_report
INNER JOIN visits 
    ON auditor_report.location_id = visits.location_id 
INNER JOIN water_quality
    ON visits.record_id = water_quality.record_id; 


-- ================================================================
-- 🔹 PART 3: Comparing Scores (Auditor vs Surveyor)
-- Display both quality scores side-by-side for direct comparison
-- ================================================================
SELECT 
	auditor_report.location_id  AS Location_ID,
    auditor_report.true_water_source_score AS Auditor_score,
    visits.record_id,
    subjective_quality_score AS Surveyor_score
FROM auditor_report
INNER JOIN visits 
    ON auditor_report.location_id = visits.location_id 
INNER JOIN water_quality
    ON visits.record_id = water_quality.record_id; 



-- ================================================================
-- 🔹 PART 4: Identifying Matching Records
-- Shows where auditors and surveyors agree on water source quality
-- ================================================================
SELECT 
    auditor_report.location_id AS Location_ID,
    auditor_report.true_water_source_score AS Auditor_score,
    visits.record_id,
    water_quality.subjective_quality_score AS Surveyor_score
FROM auditor_report
INNER JOIN visits 
    ON auditor_report.location_id = visits.location_id 
INNER JOIN water_quality
    ON visits.record_id = water_quality.record_id
WHERE water_quality.subjective_quality_score = auditor_report.true_water_source_score;



-- ================================================================
-- 🔹 PART 5: Filter to Single Visit Records
-- Removes multiple visit entries to ensure fair one-to-one comparison
-- ================================================================
SELECT 
    auditor_report.location_id AS Location_ID,
    auditor_report.true_water_source_score AS Auditor_score,
    visits.record_id,
    water_quality.subjective_quality_score AS Surveyor_score
FROM auditor_report
INNER JOIN visits 
    ON auditor_report.location_id = visits.location_id 
INNER JOIN water_quality
    ON visits.record_id = water_quality.record_id
WHERE water_quality.subjective_quality_score = auditor_report.true_water_source_score
  AND visits.visit_count = 1; 



-- ================================================================
-- 🔹 PART 6: Detecting Mismatched Scores (Errors)
-- Identify records where auditor and surveyor scores differ
-- ================================================================
SELECT 
    auditor_report.location_id AS Location_ID,
    auditor_report.true_water_source_score AS Auditor_score,
    visits.record_id,
    water_quality.subjective_quality_score AS Surveyor_score
FROM auditor_report
INNER JOIN visits 
    ON auditor_report.location_id = visits.location_id 
INNER JOIN water_quality
    ON visits.record_id = water_quality.record_id
WHERE water_quality.subjective_quality_score != auditor_report.true_water_source_score
  AND visits.visit_count = 1; 



-- ================================================================
-- 🔹 PART 7: Comparing Water Source Types
-- Match type and scores to assess if discrepancies are source-specific
-- ================================================================
SELECT 
    auditor_report.location_id AS Location_ID,
    auditor_report.type_of_water_source AS Auditor_source,
    auditor_report.true_water_source_score AS Auditor_score,
    water_source.type_of_water_source AS Surveyor_source,
    visits.record_id,
    water_quality.subjective_quality_score AS Surveyor_score
FROM auditor_report
INNER JOIN visits 
    ON auditor_report.location_id = visits.location_id 
INNER JOIN water_quality
    ON visits.record_id = water_quality.record_id
INNER JOIN water_source
	ON visits.source_id = water_source.source_id
WHERE water_quality.subjective_quality_score = auditor_report.true_water_source_score
  AND visits.visit_count = 1; 



-- ================================================================
-- 🔹 PART 8: Linking Records to Employees
-- Associates inspection discrepancies with responsible field employees
-- ================================================================
SELECT 
    auditor_report.location_id AS Location_ID,
    visits.record_id,
    visits.assigned_employee_id,
    auditor_report.true_water_source_score AS Auditor_score,
    water_quality.subjective_quality_score AS Surveyor_score
FROM auditor_report
INNER JOIN visits 
    ON auditor_report.location_id = visits.location_id 
INNER JOIN water_quality
    ON visits.record_id = water_quality.record_id
INNER JOIN water_source
	ON visits.source_id = water_source.source_id
WHERE water_quality.subjective_quality_score != auditor_report.true_water_source_score;



-- ================================================================
-- 🔹 PART 9: Replace Employee ID with Names
-- Makes results human-readable for reporting and accountability
-- ================================================================
SELECT 
    auditor_report.location_id AS Location_ID,
    visits.record_id,
    employee.employee_name,
    auditor_report.true_water_source_score AS Auditor_score,
    water_quality.subjective_quality_score AS Surveyor_score
FROM auditor_report
INNER JOIN visits 
    ON auditor_report.location_id = visits.location_id 
INNER JOIN water_quality
    ON visits.record_id = water_quality.record_id
INNER JOIN water_source
	ON visits.source_id = water_source.source_id
INNER JOIN employee
	ON visits.assigned_employee_id = employee.assigned_employee_id
WHERE water_quality.subjective_quality_score != auditor_report.true_water_source_score;



-- ================================================================
-- 🔹 PART 10: Use CTE for Modular Comparison
-- Clean, reusable logic that isolates mismatched records
-- ================================================================
WITH score_comparison AS (
    SELECT 
        auditor_report.location_id AS Location_ID,
        visits.record_id,
        employee.employee_name,
        auditor_report.true_water_source_score AS Auditor_score,
        water_quality.subjective_quality_score AS Surveyor_score
    FROM auditor_report
    INNER JOIN visits 
        ON auditor_report.location_id = visits.location_id 
    INNER JOIN water_quality
        ON visits.record_id = water_quality.record_id
    INNER JOIN water_source
        ON visits.source_id = water_source.source_id
    INNER JOIN employee
        ON visits.assigned_employee_id = employee.assigned_employee_id
)
SELECT *
FROM score_comparison
WHERE Surveyor_score != Auditor_score;



-- ================================================================
-- 🔹 PART 11: Count Distinct Employees with Mistakes
-- Quantifies employees who entered inconsistent data
-- ================================================================
WITH score_comparison AS (
    SELECT 
        auditor_report.location_id AS Location_ID,
        visits.record_id,
        employee.employee_name,
        auditor_report.true_water_source_score AS Auditor_score,
        water_quality.subjective_quality_score AS Surveyor_score
    FROM auditor_report
    INNER JOIN visits 
        ON auditor_report.location_id = visits.location_id 
    INNER JOIN water_quality
        ON visits.record_id = water_quality.record_id
    INNER JOIN water_source
        ON visits.source_id = water_source.source_id
    INNER JOIN employee
        ON visits.assigned_employee_id = employee.assigned_employee_id
)
SELECT COUNT(DISTINCT employee_name) AS distinct_employee_count 
FROM score_comparison
WHERE Surveyor_score != Auditor_score;



-- ================================================================
-- 🔹 PART 12: Rank Employees by Mistake Count
-- Highlights employees with the most recording discrepancies
-- ================================================================
WITH score_comparison AS (
    SELECT 
        auditor_report.location_id AS Location_ID,
        visits.record_id,
        employee.employee_name,
        auditor_report.true_water_source_score AS Auditor_score,
        water_quality.subjective_quality_score AS Surveyor_score
    FROM auditor_report
    INNER JOIN visits 
        ON auditor_report.location_id = visits.location_id 
    INNER JOIN water_quality
        ON visits.record_id = water_quality.record_id
    INNER JOIN water_source
        ON visits.source_id = water_source.source_id
    INNER JOIN employee
        ON visits.assigned_employee_id = employee.assigned_employee_id
)
SELECT
	employee_name,
	COUNT(*) AS mistake_count
FROM score_comparison
WHERE Surveyor_score != Auditor_score
GROUP BY employee_name
ORDER BY mistake_count DESC; 



-- ================================================================
-- 🔹 PART 13-18: Evidence Gathering, Error Counts, 
--                Average Mistakes & Text Analysis
-- Includes view creation, aggregation, and keyword search (“cash”)
-- ================================================================
-- (Keep your remaining queries with inline comments here)

-- ================================================================
-- ✅ END OF ANALYSIS
-- Summary: Used joins, aggregations, CTEs, and text filtering 
--           to detect discrepancies, measure error rates, and 
--           assess employee reporting accuracy.
-- ================================================================
