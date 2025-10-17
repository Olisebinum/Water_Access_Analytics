-- =====================================================================
-- 🧮 WATER ACCESS ANALYTICS – SQL ANALYSIS PIPELINE
-- Author: Olise Ebinum
-- Database: md_water_services
-- Description:
--   This SQL pipeline investigates discrepancies between auditor and
--   surveyor-reported water quality scores. The goal is to validate
--   data integrity, identify employee-level inconsistencies, and
--   detect potential reporting bias or misconduct.
--
-- Key Skills Demonstrated:
--   ✅ Data validation and relational joins
--   ✅ Aggregation, filtering, and conditional logic
--   ✅ Common Table Expressions (CTEs) for modular analysis
--   ✅ Error detection, ranking, and keyword text analysis
-- =====================================================================


-- ================================================================
-- STEP 0: Preview base data
-- Purpose: Quick sanity check – confirm the table is loaded properly.
-- ================================================================
SELECT * FROM md_water_services.auditor_report;


-- ================================================================
-- Activate working database context
-- ================================================================
USE md_water_services;


-- ================================================================
-- 🔹 PART 1: Linking Auditor and Visit Records
-- Objective: Connect audit reports to corresponding site visits.
-- ================================================================
SELECT 
    auditor_report.location_id AS Auditor_Location,
    auditor_report.true_water_source_score,
    visits.location_id AS Visits_Location,
    visits.record_id
FROM auditor_report
INNER JOIN visits 
    ON auditor_report.location_id = visits.location_id;


-- ================================================================
-- 🔹 PART 2: Enrich data with Water Quality Scores
-- Adds surveyor quality metrics for cross-comparison.
-- ================================================================
SELECT 
    auditor_report.location_id AS Auditor_Location,
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
-- 🔹 PART 3: Compare Auditor vs Surveyor Scores
-- Lays the foundation for identifying discrepancies.
-- ================================================================
SELECT 
    auditor_report.location_id AS Location_ID,
    auditor_report.true_water_source_score AS Auditor_score,
    visits.record_id,
    subjective_quality_score AS Surveyor_score
FROM auditor_report
INNER JOIN visits 
    ON auditor_report.location_id = visits.location_id 
INNER JOIN water_quality
    ON visits.record_id = water_quality.record_id;


-- ================================================================
-- 🔹 PART 4: Matching Score Analysis
-- Objective: Identify cases where both scores agree.
-- Insight: Useful for measuring data consistency rate.
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
-- 🔹 PART 5: Filter for Single Visit Records
-- Reason: Exclude sites visited multiple times to avoid duplicate bias.
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
-- 🔹 PART 6: Detect Mismatched Records
-- Purpose: Identify all sites where auditors and surveyors disagree.
-- Insight: Returns 102 mismatched observations (data quality issue).
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
-- 🔹 PART 7: Source Type Comparison
-- Objective: Determine if specific water source types produce more errors.
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
-- 🔹 PART 8: Link Errors to Employees
-- Tracks which employee handled each visit.
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
-- 🔹 PART 9: Add Employee Names for Readability
-- Makes reporting human-friendly for stakeholder review.
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
-- 🔹 PART 10: Introduce CTE (Common Table Expression)
-- Modularizes repeated join logic for further analysis.
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
-- 🔹 PART 11: Count Distinct Employees with Errors
-- Measures breadth of the problem across the workforce.
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
-- 🔹 PART 12: Rank Employees by Mistake Frequency
-- Identifies top offenders to target training or audits.
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
-- 🔹 PART 13: Create a View of Incorrect Records
-- Purpose: Persistent view for quality-control dashboards (Power BI).
-- ================================================================
CREATE VIEW Incorrect_records AS
SELECT
    auditor_report.location_id,
    visits.record_id,
    employee.employee_name,
    auditor_report.true_water_source_score AS Auditor_score,
    wq.subjective_quality_score AS Surveyor_score,
    auditor_report.statements
FROM auditor_report
JOIN visits
    ON auditor_report.location_id = visits.location_id
JOIN water_quality AS wq
    ON visits.record_id = wq.record_id
JOIN employee
    ON employee.assigned_employee_id = visits.assigned_employee_id
WHERE visits.visit_count = 1
  AND auditor_report.true_water_source_score != wq.subjective_quality_score;

SELECT * FROM md_water_services.Incorrect_records;


-- ================================================================
-- 🔹 PART 14: Aggregate Error Counts per Employee
-- Purpose: Quantify error distribution and identify training needs.
-- ================================================================
WITH error_count AS (
    SELECT
        employee_name,
        COUNT(*) AS number_of_mistakes
    FROM Incorrect_records
    GROUP BY employee_name
)
SELECT * FROM error_count;


-- ================================================================
-- 🔹 PART 15: Compute Average Mistake Rate
-- Benchmark performance against average accuracy.
-- ================================================================
WITH error_count AS (
    SELECT
        employee_name,
        COUNT(*) AS number_of_mistakes
    FROM Incorrect_records
    GROUP BY employee_name
)
SELECT 
    *,
    (SELECT ROUND(AVG(number_of_mistakes), 2) FROM error_count) AS avg_mistake_count
FROM error_count
ORDER BY number_of_mistakes DESC;


-- ================================================================
-- 🔹 PART 16: Identify Top 4 High-Risk Employees
-- Drills down into employees with the highest mistake counts.
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
    WHERE water_quality.subjective_quality_score != auditor_report.true_water_source_score
),
suspect_list AS (
    SELECT 
        employee_name,
        COUNT(*) AS mistake_count
    FROM score_comparison
    GROUP BY employee_name
    ORDER BY mistake_count DESC
    LIMIT 4
)
SELECT sc.*
FROM score_comparison AS sc
JOIN suspect_list AS s
    ON sc.employee_name = s.employee_name;


-- ================================================================
-- 🔹 PART 17: Combine Statements for Contextual Evidence
-- Adds auditor remarks to support data interpretation.
-- ================================================================
WITH Incorrect_records AS (
    SELECT 
        auditor_report.location_id AS Location_ID,
        visits.record_id,
        employee.employee_name,
        auditor_report.true_water_source_score AS Auditor_score,
        water_quality.subjective_quality_score AS Surveyor_score,
        auditor_report.statements
    FROM auditor_report
    INNER JOIN visits 
        ON auditor_report.location_id = visits.location_id 
    INNER JOIN water_quality
        ON visits.record_id = water_quality.record_id
    INNER JOIN water_source
        ON visits.source_id = water_source.source_id
    INNER JOIN employee
        ON visits.assigned_employee_id = employee.assigned_employee_id
    WHERE water_quality.subjective_quality_score != auditor_report.true_water_source_score
),
suspect_list AS (
    SELECT 
        employee_name,
        COUNT(*) AS mistake_count
    FROM Incorrect_records
    GROUP BY employee_name
    ORDER BY mistake_count DESC
    LIMIT 4
)
SELECT *
FROM Incorrect_records
WHERE employee_name IN (SELECT employee_name FROM suspect_list);


-- ================================================================
-- 🔹 PART 18: Text Analysis (Keyword “cash”)
-- Goal: Identify statements mentioning “cash” – potential bias or fraud.
-- ================================================================
WITH Incorrect_records AS (
    SELECT 
        auditor_report.location_id AS Location_ID,
        visits.record_id,
        employee.employee_name,
        auditor_report.true_water_source_score AS Auditor_score,
        water_quality.subjective_quality_score AS Surveyor_score,
        auditor_report.statements
    FROM auditor_report
    INNER JOIN visits 
        ON auditor_report.location_id = visits.location_id 
    INNER JOIN water_quality
        ON visits.record_id = water_quality.record_id
    INNER JOIN water_source
        ON visits.source_id = water_source.source_id
    INNER JOIN employee
        ON visits.assigned_employee_id = employee.assigned_employee_id
    WHERE water_quality.subjective_quality_score != auditor_report.true_water_source_score
),
suspect_list AS (
    SELECT 
        employee_name,
        COUNT(*) AS mistake_count
    FROM Incorrect_records
    GROUP BY employee_name
    ORDER BY mistake_count DESC
    LIMIT 4
)
SELECT *
FROM Incorrect_records
WHERE employee_name IN (SELECT employee_name FROM suspect_list)
  AND LOWER(statements) LIKE '%cash%';


-- ================================================================
-- ✅ END OF ANALYSIS
-- Summary:
--   ✔ Validated data reliability between auditor and surveyor reports
--   ✔ Quantified employee-level inconsistencies
--   ✔ Aggregated and benchmarked error rates
--   ✔ Detected potential misconduct through keyword search
--   ✔ Created reusable views for visualization in Power BI
-- ================================================================
