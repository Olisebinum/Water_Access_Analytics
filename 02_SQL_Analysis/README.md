# 🧮 Part 2 – SQL Analysis  

This stage of the **Water Access Analytics** project focuses on uncovering meaningful insights from the cleaned and structured data prepared in Part 1.  
Using **SQL**, I performed exploratory, aggregative, and diagnostic analysis to reveal hidden patterns in water accessibility, infrastructure reliability, and service efficiency across multiple regions.  

The analysis phase represents the **heart of the data pipeline**, transforming validated data into **evidence-based insights** that power visualization and decision-making.

---

## 📘 Overview  

The objective of this stage is to leverage SQL’s analytical power to:

- **Identify disparities** in water access across provinces and towns.  
- **Evaluate performance** of water source types by functionality and queue time.  
- **Quantify reach** — measure population coverage and accessibility metrics.  
- **Rank priority areas** for maintenance and infrastructure investment.  
- **Prepare summary datasets** optimized for Power BI dashboard integration.

All analyses were conducted using **PostgreSQL / MySQL** in a normalized relational database environment.  
Each SQL script was modular and reusable, designed to handle future data updates with minimal modification.

---

## 🧩 Analytical Framework  

The analysis followed a structured **4-step workflow** ensuring logical progression and reproducibility:

| Step | Task | Outcome |
|------|------|----------|
| **1. Data Exploration** | Examined key tables (`WaterSources`, `Visits`, `Employees`) and verified relationships. | Confirmed data integrity and completeness. |
| **2. Descriptive Analysis** | Aggregated and summarized statistics using `GROUP BY`, `COUNT()`, and `AVG()`. | Produced provincial-level summaries and KPIs. |
| **3. Diagnostic Queries** | Used subqueries and conditional logic to uncover service inefficiencies. | Identified long queue times and low functionality areas. |
| **4. Export & Validation** | Created SQL views and exported clean tables to Power BI. | Enabled seamless data visualization and reproducibility. |

---

## 🧰 Tools & Technologies  

- **SQL (PostgreSQL / MySQL)** — Data analysis, transformation, and validation.  
- **Jupyter / VS Code SQL Extension** — Query documentation and iteration.  
- **Excel / CSV** — Export and review of summarized datasets.  
- **Git & GitHub** — Version control and collaborative development.  
- **Power BI (Integration)** — Visualization of final analytical outputs.

---

## ⚙️ Key SQL Techniques Applied  

| Technique | Description | Use Case |
|------------|--------------|-----------|
| **Joins (INNER, LEFT)** | Combined related tables (e.g., visits with water sources). | Linked source and inspection data. |
| **Conditional Aggregation** | Applied `CASE WHEN` logic to classify functional vs. non-functional sources. | Calculated functionality rates per region. |
| **Window Functions** | Used `RANK()` and `ROW_NUMBER()` for ranking and deduplication. | Prioritized towns by access scores. |
| **Subqueries & CTEs** | Organized complex logic into readable segments. | Simplified priority index computation. |
| **Data Validation Queries** | Checked for nulls, orphan keys, and schema consistency. | Ensured high data quality before visualization. |

---

## 🗂️ Folder Contents  

| File | Description |
|------|-------------|
| `source_performance.sql` | Aggregates functionality rates and average queue times per source type. |
| `regional_coverage.sql` | Calculates total and functional water sources per province and town. |
| `priority_index.sql` | Computes an index combining queue time, functionality, and population metrics. |
| `export_views.sql` | Creates summarized SQL views ready for Power BI export. |
| `data_quality_checks.sql` | Runs integrity and consistency checks across joined tables. |
| `README.md` | Documentation detailing SQL objectives, logic, and insights. |

---

## 🧩 Key Analytical Queries  

### 1️⃣ Source Performance by Type  
Evaluates how different water sources perform in terms of reliability and queue time.

```sql
SELECT 
    SourceType,
    COUNT(SourceID) AS TotalSources,
    SUM(CASE WHEN FunctionalityStatus = 'Functional' THEN 1 ELSE 0 END) AS FunctionalSources,
    ROUND(AVG(QueueTime), 2) AS AvgQueueTime
FROM WaterSources ws
JOIN Visits v ON ws.SourceID = v.SourceID
GROUP BY SourceType
ORDER BY FunctionalSources DESC;

