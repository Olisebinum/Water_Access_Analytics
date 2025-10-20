# 🧠 SQL ANALYTICS & INSIGHTS NOTEBOOK  
### Project: **Water_Access_Analytics**  
**Author:** Olise Ebinum  

---

## 🌍 Project Overview  

The **Water Access Analytics** project demonstrates a complete end-to-end SQL analytical workflow for understanding and improving community water access.  
This notebook captures **technical reasoning**, **query logic**, and **key insights** from data exploration to validation — bridging structured data analysis and real-world decision support.

The project integrates SQL queries across multiple tables, revealing **data quality issues, efficiency gaps, and contamination risks**, which were later visualized in Power BI.

---

## 🎯 Objectives  

The SQL analysis aimed to:  
1. Identify **data inconsistencies** between auditors and surveyors.  
2. Assess **employee reporting accuracy and workload efficiency**.  
3. Quantify **access to clean water** across towns and provinces.  
4. Support **decision-making** through aggregated and clean datasets.  
5. Prepare data for **Power BI visualization** and dashboard storytelling.  

---

## 🧱 Database Context  

The relational schema `md_water_services` combines **operational**, **audit**, and **quality** data into one unified system.  

**Core Tables:**
- `location`: towns, provinces, and location types.  
- `visits`: field visit logs and queue times.  
- `water_source`: defines water source types and populations served.  
- `employee`: surveyor and auditor profiles.  
- `auditor_report`: third-party accuracy checks.  
- `water_quality`: subjective field ratings.  
- `well_pollution`: lab-confirmed contamination results.  

**Analytical Views:**
- `combined_analysis_table`
- `incorrect_records`

---

## 🧩 Analytical Workflow  

| Stage | Process | Output |
|--------|----------|---------|
| 1️⃣ | Integrate location, source, and visit data | Unified relational dataset |
| 2️⃣ | Join auditor and surveyor tables | Detect discrepancies |
| 3️⃣ | Quantify error counts per employee | Performance benchmarks |
| 4️⃣ | Create reusable views for dashboards | Simplified Power BI linking |
| 5️⃣ | Generate improvement insights | Recommendations table |

---

## 🔍 Step 1 — Data Integration (Joining Core Tables)

```sql
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

Insight:
This integration connects every field visit to its specific location and water source, forming the foundation for pollution and performance analysis.

