-- =====================================================================
-- 💧 WATER ACCESS ANALYTICS – IMPROVEMENT & ACTION PIPELINE
-- Author: Olise Ebinum
-- Database: md_water_services
-- Description:
--   This SQL project identifies underserved communities by analyzing
--   water source types, pollution levels, and queue times. It integrates
--   multiple datasets — visits, locations, and pollution results — into
--   actionable insights and infrastructure improvement recommendations.
--
-- Skills Demonstrated:
--   ✅ Multi-table joins and conditional filtering
--   ✅ CTE and VIEW creation for modular analysis
--   ✅ Case logic for decision-driven improvements
--   ✅ Population distribution and percentage breakdowns
--   ✅ Project tracking via progress tables
-- =====================================================================

USE md_water_services;

-- ================================================================
-- 🔹 PART 1: Basic Table Join – Locations, Visits, and Water Sources
-- Goal: Combine key data to analyze visit counts and water source info
-- ================================================================
SELECT
	loc.province_name, 
	loc.town_name,
	v.visit_count,
	v.location_id,
	ws.type_of_water_source,
	ws.number_of_people_served
FROM location AS loc
INNER JOIN visits AS v ON v.location_id = loc.location_id
INNER JOIN water_source AS ws ON ws.source_id = v.source_id;

-- ================================================================
-- 🔹 PART 2: Filtering Specific Locations
-- Example: Focus on a single community (‘AKHa00103’) for inspection
-- ================================================================
SELECT
	loc.province_name, 
	loc.town_name,
	v.visit_count,
	v.location_id,
	ws.type_of_water_source,
	ws.number_of_people_served
FROM location AS loc
INNER JOIN visits AS v ON v.location_id = loc.location_id
INNER JOIN water_source AS ws ON ws.source_id = v.source_id
WHERE v.location_id = 'AKHa00103';

-- ================================================================
-- 🔹 PART 3: Restrict to Single Visits
-- Ensures data consistency by excluding multiple inspections
-- ================================================================
SELECT
	loc.province_name, 
	loc.town_name,
	v.visit_count,
	v.location_id,
	ws.type_of_water_source,
	ws.number_of_people_served
FROM location AS loc
INNER JOIN visits AS v ON v.location_id = loc.location_id
INNER JOIN water_source AS ws ON ws.source_id = v.source_id
WHERE v.visit_count = 1;

-- ================================================================
-- 🔹 PART 4: Include Location Type & Time in Queue
-- Adds context for deeper socioeconomic analysis
-- ================================================================
SELECT
	loc.province_name, 
	loc.town_name,
	loc.location_type,
	ws.type_of_water_source,
	ws.number_of_people_served,
	v.time_in_queue
FROM location AS loc
INNER JOIN visits AS v ON v.location_id = loc.location_id
INNER JOIN water_source AS ws ON ws.source_id = v.source_id
WHERE v.visit_count = 1;

-- ================================================================
-- 🔹 PART 5: Integrating Well Pollution Data
-- Enriches dataset with pollution test results for each source
-- ================================================================
SELECT
	ws.type_of_water_source,
	loc.town_name,
	loc.province_name,
	loc.location_type,
	ws.number_of_people_served,
	v.time_in_queue,
	wp.results
FROM visits AS v
LEFT JOIN well_pollution AS wp ON wp.source_id = v.source_id
INNER JOIN location AS loc ON loc.location_id = v.location_id
INNER JOIN water_source AS ws ON ws.source_id = v.source_id
WHERE v.visit_count = 1;

-- ================================================================
-- 🔹 PART 6: Create a Combined View
-- Purpose: Reuse this unified dataset across all subsequent analyses
-- ================================================================
CREATE VIEW combined_analysis_table AS
SELECT
	ws.type_of_water_source AS source_type,
	loc.town_name,
	loc.province_name,
	loc.location_type,
	ws.number_of_people_served AS people_served,
	v.time_in_queue,
	wp.results
FROM visits AS v
LEFT JOIN well_pollution AS wp ON wp.source_id = v.source_id
INNER JOIN location AS loc ON loc.location_id = v.location_id
INNER JOIN water_source AS ws ON ws.source_id = v.source_id
WHERE v.visit_count = 1;

-- ================================================================
-- 🔹 PART 7: Provincial Water Source Distribution
-- Objective: Calculate % of population per source type by province
-- ================================================================
WITH province_totals AS (
	SELECT
		province_name,
		SUM(people_served) AS total_ppl_serv
	FROM combined_analysis_table
	GROUP BY province_name
)
SELECT
	ct.province_name,
	ROUND(SUM(CASE WHEN source_type = 'river' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv, 0) AS river,
	ROUND(SUM(CASE WHEN source_type = 'shared_tap' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv, 0) AS shared_tap,
	ROUND(SUM(CASE WHEN source_type = 'tap_in_home' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv, 0) AS tap_in_home,
	ROUND(SUM(CASE WHEN source_type = 'tap_in_home_broken' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv, 0) AS tap_in_home_broken,
	ROUND(SUM(CASE WHEN source_type = 'well' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv, 0) AS well
FROM combined_analysis_table AS ct
JOIN province_totals AS pt ON ct.province_name = pt.province_name
GROUP BY ct.province_name
ORDER BY ct.province_name;

-- ================================================================
-- 🔹 PART 8: Town-Level Water Access Breakdown
-- Handles duplicate town names across provinces (e.g., Harare)
-- ================================================================
WITH town_totals AS (
	SELECT province_name, town_name, SUM(people_served) AS total_ppl_serv
	FROM combined_analysis_table
	GROUP BY province_name, town_name
)
SELECT
	ct.province_name,
	ct.town_name,
	ROUND(SUM(CASE WHEN source_type = 'river' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv, 0) AS river,
	ROUND(SUM(CASE WHEN source_type = 'shared_tap' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv, 0) AS shared_tap,
	ROUND(SUM(CASE WHEN source_type = 'tap_in_home' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv, 0) AS tap_in_home,
	ROUND(SUM(CASE WHEN source_type = 'tap_in_home_broken' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv, 0) AS tap_in_home_broken,
	ROUND(SUM(CASE WHEN source_type = 'well' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv, 0) AS well
FROM combined_analysis_table AS ct
JOIN town_totals AS tt
	ON ct.province_name = tt.province_name AND ct.town_name = tt.town_name
GROUP BY ct.province_name, ct.town_name
ORDER BY ct.town_name;

-- ================================================================
-- 🔹 PART 9: Temporary Table for Faster Retrieval
-- Stores aggregated water access data for town-level reuse
-- ================================================================
CREATE TEMPORARY TABLE town_aggregated_water_access AS
WITH town_totals AS (
	SELECT province_name, town_name, SUM(people_served) AS total_ppl_serv
	FROM combined_analysis_table
	GROUP BY province_name, town_name
)
SELECT
	ct.province_name,
	ct.town_name,
	ROUND(SUM(CASE WHEN source_type = 'river' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv, 0) AS river,
	ROUND(SUM(CASE WHEN source_type = 'shared_tap' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv, 0) AS shared_tap,
	ROUND(SUM(CASE WHEN source_type = 'tap_in_home' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv, 0) AS tap_in_home,
	ROUND(SUM(CASE WHEN source_type = 'tap_in_home_broken' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv, 0) AS tap_in_home_broken,
	ROUND(SUM(CASE WHEN source_type = 'well' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv, 0) AS well
FROM combined_analysis_table AS ct
JOIN town_totals AS tt
	ON ct.province_name = tt.province_name AND ct.town_name = tt.town_name
GROUP BY ct.province_name, ct.town_name
ORDER BY ct.town_name;

-- ================================================================
-- 🔹 PART 10: Identify Towns with High Broken Tap Ratios
-- Insight: Measure percentage of malfunctioning in-home taps
-- ================================================================
SELECT
	province_name,
	town_name,
	ROUND(tap_in_home_broken / (tap_in_home_broken + tap_in_home) * 100, 0) AS Pct_broken_taps
FROM town_aggregated_water_access;

-- ================================================================
-- 🔹 PART 11: Create a Project Progress Table
-- Tracks improvement implementation across all water sources
-- ================================================================
CREATE TABLE Project_progress (
	Project_id SERIAL PRIMARY KEY,
	source_id VARCHAR(20) NOT NULL REFERENCES water_source(source_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	Address VARCHAR(50),
	Town VARCHAR(30),
	Province VARCHAR(30),
	Source_type VARCHAR(50),
	Improvement VARCHAR(50),
	Source_status VARCHAR(50) DEFAULT 'Backlog' 
		CHECK (Source_status IN ('Backlog', 'In progress', 'Complete')),
	Date_of_completion DATE,
	Comments TEXT
);

-- ================================================================
-- 🔹 PART 12: Actionable Recommendations by Source Type
-- (Rivers, Wells, Shared Taps, Broken Home Taps)
-- ================================================================
SELECT
	l.address,
	l.town_name,
	l.province_name,
	ws.source_id,
	ws.type_of_water_source,
	wp.results,
	CASE
		WHEN ws.type_of_water_source = 'well' AND wp.results = 'Contaminated: Biological'
			THEN 'Install UV filter'
		WHEN ws.type_of_water_source = 'well' AND wp.results = 'Contaminated: Chemical'
			THEN 'Install RO filter'
		WHEN ws.type_of_water_source = 'river'
			THEN 'Drill Well'
		WHEN ws.type_of_water_source = 'shared_tap'
			AND v.time_in_queue >= 30
			THEN CONCAT('Install ', FLOOR(v.time_in_queue / 30), ' taps nearby')
		WHEN ws.type_of_water_source = 'tap_in_home_broken'
			THEN 'Diagnose local infrastructure'
		ELSE NULL
	END AS Improvement
FROM water_source AS ws
LEFT JOIN well_pollution AS wp ON ws.source_id = wp.source_id
INNER JOIN visits AS v ON ws.source_id = v.source_id
INNER JOIN location AS l ON l.location_id = v.location_id
WHERE v.visit_count = 1
  AND (
	wp.results != 'Clean'
	OR ws.type_of_water_source IN ('tap_in_home_broken', 'river')
	OR (ws.type_of_water_source = 'shared_tap' AND v.time_in_queue >= 30)
  );

-- ================================================================
-- 🔹 PART 13: Populate the Project Progress Table
-- Inserts prioritized improvements for field teams
-- ================================================================
INSERT INTO Project_progress (
	source_id,
	Address,
	Town,
	Province,
	Source_type,
	Improvement,
	Source_status,
	Date_of_completion,
	Comments
)
SELECT
	ws.source_id,
	l.address,
	l.town_name,
	l.province_name,
	ws.type_of_water_source,
	CASE
		WHEN ws.type_of_water_source = 'well' AND wp.results = 'Contaminated: Chemical'
			THEN 'Install RO filter'
		WHEN ws.type_of_water_source = 'well' AND wp.results = 'Contaminated: Biological'
			THEN 'Install UV and RO filter'
		WHEN ws.type_of_water_source = 'river'
			THEN 'Drill well'
		WHEN ws.type_of_water_source = 'shared_tap' AND v.time_in_queue >= 30
			THEN CONCAT('Install ', FLOOR(v.time_in_queue / 30), ' taps nearby')
		WHEN ws.type_of_water_source = 'tap_in_home_broken'
			THEN 'Diagnose local infrastructure'
		ELSE NULL
	END AS Improvement,
	'Backlog' AS Source_status,
	NULL AS Date_of_completion,
	NULL AS Comments
FROM water_source AS ws
LEFT JOIN well_pollution AS wp ON ws.source_id = wp.source_id
INNER JOIN visits AS v ON ws.source_id = v.source_id
INNER JOIN location AS l ON l.location_id = v.location_id
WHERE v.visit_count = 1
  AND (
	wp.results != 'Clean'
	OR ws.type_of_water_source IN ('tap_in_home_broken', 'river')
	OR (ws.type_of_water_source = 'shared_tap' AND v.time_in_queue >= 30)
  );

-- ================================================================
-- ✅ END OF IMPROVEMENT ANALYSIS
-- Summary:
--   - Built multi-layer joins to analyze water access.
--   - Identified broken infrastructure and contamination risks.
--   - Designed automated improvement recommendations.
--   - Populated progress tracking table for follow-up interventions.
-- ================================================================
