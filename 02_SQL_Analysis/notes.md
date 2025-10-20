---
title: "Water Access Analytics - SQL Insights Notebook"
author: "Olise Ebinum"
output: html_document
---

# 🧠 SQL ANALYTICS & INSIGHTS NOTEBOOK  
### Project: Water_Access_Analytics  

---

## 🌍 Project Overview  

The **Water Access Analytics** project demonstrates a complete end-to-end SQL analytical workflow for understanding and improving community water access.  
This notebook captures **technical reasoning**, **query logic**, and **key insights** from data exploration to validation — bridging structured data analysis and real-world decision support.

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

**Core tables include:**
- `location`
- `visits`
- `water_source`
- `employee`
- `auditor_report`
- `water_quality`
- `well_pollution`

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
```

**Insight:**  
This integration connects every field visit to its specific location and water source, forming the foundation for pollution and performance analysis.

---

## 📍 Step 2 — Filtering and Refinement  

```sql
SELECT
    loc.province_name, 
    loc.town_name,
    ws.type_of_water_source,
    ws.number_of_people_served
FROM location AS loc
INNER JOIN visits AS v ON v.location_id = loc.location_id
INNER JOIN water_source AS ws ON ws.source_id = v.source_id
WHERE v.visit_count = 1;
```

**Insight:**  
Filtered multiple visits to ensure data consistency and represent only unique inspection records.

---

## 🧩 Step 3 — Building a Combined Analysis View  

```sql
CREATE VIEW combined_analysis_table AS
SELECT
    water_source.type_of_water_source AS source_type,
    location.town_name,
    location.province_name,
    location.location_type,
    water_source.number_of_people_served AS people_served,
    visits.time_in_queue,
    well_pollution.results
FROM visits
LEFT JOIN well_pollution ON well_pollution.source_id = visits.source_id
INNER JOIN location ON location.location_id = visits.location_id
INNER JOIN water_source ON water_source.source_id = visits.source_id
WHERE visits.visit_count = 1;
```

**Insight:**  
This view simplifies data analysis by combining multiple tables — ideal for creating Power BI dashboards.

---

## 🧮 Step 4 — Provincial Water Access Coverage  

```sql
WITH province_totals AS (
    SELECT province_name, SUM(people_served) AS total_ppl_serv
    FROM combined_analysis_table
    GROUP BY province_name
)
SELECT
    ct.province_name,
    ROUND((SUM(CASE WHEN source_type = 'river' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS river,
    ROUND((SUM(CASE WHEN source_type = 'shared_tap' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS shared_tap,
    ROUND((SUM(CASE WHEN source_type = 'tap_in_home' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS tap_in_home
FROM combined_analysis_table ct
JOIN province_totals pt ON ct.province_name = pt.province_name
GROUP BY ct.province_name
ORDER BY ct.province_name;
```

**Insight:**  
This aggregation quantifies access levels across provinces, identifying which regions rely heavily on shared or unsafe water sources.

---

## 🏙️ Step 5 — Town-Level Analysis  

```sql
WITH town_totals AS (
    SELECT province_name, town_name, SUM(people_served) AS total_ppl_serv
    FROM combined_analysis_table
    GROUP BY province_name, town_name
)
SELECT
    ct.province_name,
    ct.town_name,
    ROUND((SUM(CASE WHEN source_type = 'river' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS river,
    ROUND((SUM(CASE WHEN source_type = 'shared_tap' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS shared_tap,
    ROUND((SUM(CASE WHEN source_type = 'tap_in_home' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS tap_in_home
FROM combined_analysis_table ct
JOIN town_totals tt ON ct.province_name = tt.province_name AND ct.town_name = tt.town_name
GROUP BY ct.province_name, ct.town_name
ORDER BY ct.town_name;
```

**Insight:**  
This identifies disparities in access at the town level — revealing areas that need urgent infrastructure attention.

---

## 📊 Step 6 — Identifying Problem Areas  

```sql
SELECT
    province_name,
    town_name,
    ROUND(tap_in_home_broken / (tap_in_home_broken + tap_in_home) * 100, 0) AS pct_broken_taps
FROM town_aggregated_water_access;
```

**Insight:**  
Highlights towns where high proportions of households have broken taps, guiding resource allocation for maintenance and repairs.

---

## 🧰 Step 7 — Project Progress Tracking  

```sql
CREATE TABLE Project_progress (
    Project_id SERIAL PRIMARY KEY,
    source_id VARCHAR(20) NOT NULL REFERENCES water_source(source_id) ON DELETE CASCADE ON UPDATE CASCADE,
    Address VARCHAR(50),
    Town VARCHAR(30),
    Province VARCHAR(30),
    Source_type VARCHAR(50),
    Improvement VARCHAR(50),
    Source_status VARCHAR(50) DEFAULT 'Backlog' CHECK (Source_status IN ('Backlog', 'In progress', 'Complete')),
    Date_of_completion DATE,
    Comments TEXT
);
```

**Insight:**  
A new table designed to manage project updates — enabling progress tracking from backlog to completion.

---

## ⚙️ Step 8 — Generating Improvement Recommendations  

```sql
SELECT
    location.address,
    location.town_name,
    location.province_name,
    water_source.source_id,
    water_source.type_of_water_source,
    well_pollution.results,
    CASE
        WHEN (type_of_water_source = 'well' AND well_pollution.results = 'Contaminated: Chemical') THEN 'Install RO filter'
        WHEN (type_of_water_source = 'well' AND well_pollution.results = 'Contaminated: Biological') THEN 'Install UV and RO filter'
        WHEN type_of_water_source = 'river' THEN 'Drill well'
        WHEN type_of_water_source = 'shared_tap' AND time_in_queue >= 30 THEN CONCAT('Install ', FLOOR(time_in_queue/30), ' taps nearby')
        WHEN type_of_water_source = 'tap_in_home_broken' THEN 'Diagnose local infrastructure'
        ELSE NULL
    END AS Improvement
FROM water_source
LEFT JOIN well_pollution ON water_source.source_id = well_pollution.source_id
INNER JOIN visits ON water_source.source_id = visits.source_id
INNER JOIN location ON location.location_id = visits.location_id
WHERE visits.visit_count = 1;
```

**Insight:**  
This intelligent query generates actionable insights for improving each water source, helping decision-makers prioritize interventions.

---

## ✅ Summary  

The SQL pipeline successfully:  
- Merged multi-table relationships into a coherent schema.  
- Identified inconsistencies and bottlenecks.  
- Quantified disparities in access across regions.  
- Automated improvement recommendations for reporting dashboards.  

This framework bridges **data integrity, analytics, and visualization**, powering data-driven decisions for sustainable community water management.
 table |

---


✅ Identified **regions with poor access** to clean water.  
✅ Highlighted **survey inconsistencies** across data collection teams.  
✅ Generated **automated SQL-based recommendations** for remediation.  
✅ Created a **live Power BI dashboard** showing performance across provinces.  
✅ Established a **data-driven decision system** to guide resource allocation.

---

## 🧩 Summary  

This SQL-driven workflow demonstrates how structured queries can uncover real-world public infrastructure challenges.  
The findings powered Power BI dashboards, tracking **queue times, contamination levels, and improvement progress** — strengthening data governance and transparency in water management.
