# 📊 Part 3 – Power BI Visualization  
### Project: Water Access Analytics  
**Author:** Olise Ebinum  

---

## 🌍 Overview  
This phase transforms all SQL analytical outputs from **Part 2** into clear, dynamic, and interactive visual insights using **Power BI**.  
The goal is to make complex data about water source performance, access disparity, and service improvement **intuitively understandable for decision-makers**.

Using the exported datasets from SQL (e.g., `combined_analysis_table`, `project_progress`, and `town_aggregated_water_access`), Power BI integrates these results into a comprehensive analytical dashboard.

---

## 🎯 Objectives  
- Convert SQL query outputs into **actionable visuals** for stakeholders.  
- Track **project progress**, **source contamination levels**, and **improvement priorities**.  
- Analyze **provincial and town-level disparities** in access to clean water.  
- Identify **bottlenecks**, such as long queue times or broken taps, and visualize trends over time.  

---

## 🧰 Tools & Technologies  
- **Microsoft Power BI** – Data modeling and visualization.  
- **Excel / CSV Exports** – Datasets generated from SQL analysis.  
- **DAX (Data Analysis Expressions)** – For advanced calculated measures and KPIs.  
- **Power Query** – To clean, transform, and merge SQL datasets.  

---

## 📁 Folder Contents  

| File | Description |
|------|-------------|
| `Water_Access_Analytics.pbix` | Main Power BI dashboard file with multiple report pages. |
| `data_exports/` | Folder containing CSV exports from SQL (e.g., `combined_analysis_table.csv`, `project_progress.csv`). |
| `images/` | Screenshots of dashboard visuals for GitHub preview. |
| `README.md` | Documentation of the visualization process and insights. |

---

## 🧩 Dashboard Structure  

### **Page 1 – Overview Dashboard**
- Provincial summary of population served.  
- Map visualization showing the distribution of water sources.  
- KPIs for total functional sources, average queue time, and contamination rate.

### **Page 2 – Data Quality and Validation**
- Comparison of **Auditor vs Surveyor** scores.  
- Bar chart of errors per employee.  
- Heatmap identifying most error-prone locations.

### **Page 3 – Source Performance**
- Water source functionality by type (wells, taps, rivers).  
- Queue time analysis and population served.  
- Drill-through feature to explore town-level details.

### **Page 4 – Project Progress Tracker**
- Monitors the `Project_progress` table from SQL.  
- Displays **status breakdowns** (Backlog, In Progress, Complete).  
- Includes improvement suggestions (“Install UV filter”, “Drill Well”).  

---

## 📈 Key Insights  
✅ Provinces with the **highest number of broken taps** were easily visualized.  
✅ Queue time analysis revealed areas needing **additional shared taps**.  
✅ Data validation dashboard identified **human reporting inconsistencies**.  
✅ Overall improvement recommendations streamlined **maintenance prioritization**.

---

## 🧠 Skills Demonstrated  
- Data modeling and relationships in Power BI.  
- Building calculated columns and DAX measures.  
- Interactive filtering and drill-down reports.  
- Combining SQL analysis with modern BI storytelling.  

---

## 🚀 How to Reproduce  
1. Open `Water_Access_Analytics.pbix` in **Power BI Desktop**.  
2. Connect to the exported CSVs from the `data_exports/` folder.  
3. Refresh all data connections to update the visuals.  
4. Explore the dashboard by switching between pages and filters.  

---

## 📜 Credits  
**Project:** Water Access Analytics  
**Developed by:** Olise Ebinum  
**Integrated Tools:** SQL, Power BI, GitHub  

---

