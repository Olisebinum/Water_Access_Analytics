# 🧩 DATABASE SCHEMA REFERENCE  
### Project: **Water_Access_Analytics**  
**Author:** Olise Ebinum  

---

## 🗄️ Database: `md_water_services`

This database schema underpins the **Water Access Analytics** project — a data-driven initiative designed to **analyze, validate, and improve community water access** across regions.  
It integrates **field survey data, audit results, contamination tests, and project tracking** into a unified analytical system.

---

## 🧱 Core Tables and Relationships

| Table | Description | Primary Key | Key Relationships |
|--------|--------------|--------------|-------------------|
| **location** | Stores each community’s geographic details, including province, town, and location type. | `location_id` | Referenced by `visits.location_id` |
| **water_source** | Defines every water source (well, tap, river) and the number of people it serves. | `source_id` | Referenced by `visits.source_id`, `well_pollution.source_id` |
| **visits** | Logs each inspection of a water source, capturing queue times, field notes, and assigned staff. | `record_id` | References `location_id`, `source_id`, and `employee_id` |
| **employee** | Contains information about field officers and surveyors performing data collection. | `assigned_employee_id` | Referenced by `visits.assigned_employee_id` |
| **auditor_report** | Records independent audit validations comparing field survey accuracy. | `location_id` | Linked to `visits` via `location_id` |
| **water_quality** | Captures subjective surveyor ratings on water quality (e.g., clean, biological contamination). | `record_id` | Linked to `visits` |
| **well_pollution** | Stores objective laboratory results for biological or chemical contamination. | `source_id` | Linked to `water_source` and `visits` |
| **combined_analysis_table** *(View)* | Aggregated dataset merging location, water source, visit, and pollution data for analysis. | *(Derived)* | Built from joins across multiple core tables |
| **incorrect_records** *(View)* | Flags mismatched auditor vs. surveyor scores to identify potential data entry errors. | *(Derived)* | Built from `auditor_report`, `visits`, and `water_quality` |
| **project_progress** | Tracks improvement recommendations for contaminated or faulty sources (e.g., “Install UV filter”). | `project_id` | References `water_source.source_id` |

---

## 🔗 Entity Relationships  

Below is the high-level relational structure of the `md_water_services` database:


