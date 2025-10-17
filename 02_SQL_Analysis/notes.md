# 🧩 DATABASE SCHEMA REFERENCE  
### Project: Water_Access_Analytics  
**Author:** Olise Ebinum  

---

## 🗄️ Database: `md_water_services`

This schema models a complete workflow for tracking, auditing, and improving community water sources.  
It supports **data validation, quality comparison, performance analytics, and project tracking**.  

---

## 🧱 Core Tables and Relationships

| Table | Description | Primary Key | Key Relationships |
|--------|--------------|--------------|-------------------|
| **location** | Stores each community’s geographic data including province, town, and location type. | `location_id` | Referenced by `visits.location_id` |
| **water_source** | Defines each water source (wells, taps, rivers) and the number of people it serves. | `source_id` | Referenced by `visits.source_id`, `well_pollution.source_id` |
| **visits** | Records each field visit to a water source, including queue time and assigned employee. | `record_id` | References `location_id`, `source_id`, and `employee_id` |
| **employee** | Contains details of field workers and surveyors assigned to inspections. | `assigned_employee_id` | Referenced by `visits.assigned_employee_id` |
| **auditor_report** | Independent audit records validating the surveyors’ water source assessments. | `location_id` | Linked to `visits` via shared `location_id` |
| **water_quality** | Captures surveyors’ subjective quality scores per visit (e.g., clean vs contaminated). | `record_id` | Linked to `visits` |
| **well_pollution** | Contains objective test results for biological or chemical contamination. | `source_id` | Linked to `water_source` and `visits` |
| **combined_analysis_table** *(View)* | Aggregated analytical dataset combining location, source, pollution, and queue data. | *(Derived)* | Built from joins across `location`, `visits`, `water_source`, and `well_pollution` |
| **incorrect_records** *(View)* | Highlights mismatched scores between auditors and surveyors to detect data quality issues. | *(Derived)* | Built from joins between `auditor_report`, `visits`, and `water_quality` |
| **project_progress** | Tracks improvement efforts on faulty or contaminated water sources. | `project_id` | References `water_source.source_id` |

---

## 🔗 Entity Relationships




---

## 🧮 Analytical Flow Overview

| Step | Process | Description | Output |
|------|----------|--------------|---------|
| **1️⃣ Data Collection** | Import raw tables (`location`, `visits`, `water_source`, etc.) | Foundation for analysis | Clean relational schema |
| **2️⃣ Data Integration** | Use joins to merge audits, visits, and pollution results | Creates unified analytical view | `combined_analysis_table` |
| **3️⃣ Discrepancy Detection** | Compare auditor vs. surveyor scores | Identify human data errors | `incorrect_records` |
| **4️⃣ Aggregation & Reporting** | Use SQL CTEs and CASE logic | Calculate water source performance and provincial coverage | Aggregated metrics for Power BI |
| **5️⃣ Improvement Tracking** | Generate project progress reports | Store recommendations like “Install UV Filter” | `project_progress` table |

---

## 💡 Example Analytical Joins

```sql
-- Example: Join auditor and surveyor records for validation
SELECT 
    a.location_id,
    a.true_water_source_score AS auditor_score,
    wq.subjective_quality_score AS surveyor_score,
    e.employee_name
FROM auditor_report AS a
JOIN visits AS v ON a.location_id = v.location_id
JOIN water_quality AS wq ON v.record_id = wq.record_id
JOIN employee AS e ON v.assigned_employee_id = e.assigned_employee_id;

