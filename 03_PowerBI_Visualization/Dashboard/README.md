# 📊 Power BI Dashboard — Water Access Analytics

## Overview
This dashboard visualizes the analytical outcomes from SQL and data preprocessing stages of the **Water_Access_Analytics** project.  
It brings to life insights on water source quality, access levels, and improvement tracking using **interactive Power BI visuals**.

---

## 💡 Key Dashboards

| Dashboard | Description |
|------------|--------------|
| **Access Overview** | Displays distribution of water sources by type, province, and town. |
| **Quality Comparison** | Compares surveyor and auditor scores to identify data discrepancies. |
| **Pollution Insights** | Shows contaminated vs. clean water sources by type and location. |
| **Improvement Tracker** | Visualizes actionable recommendations from SQL logic (e.g., “Install UV Filter”). |

---

## 📈 Features
- Interactive filters by **Province**, **Source Type**, and **Pollution Result**  
- Integrated visuals from `combined_analysis_table` and `incorrect_records` views  
- Uses **DAX measures** to calculate total population served, contamination rates, and progress status  

---

## ⚙️ Tools & Technologies
- **Power BI Desktop**
- **SQL (MySQL Workbench)**
- **Data Source:** `md_water_services` database
- **Integration:** Exported `.pbix` built from the SQL outputs and CSV extracts in `/02_SQL_Analysis/data/`

---

## 📁 File Structure
- `Water_Access_Insights.pbix` → Power BI file  
- `README.md` → Dashboard documentation  

---

## 👨‍💻 Author
**Olise Ebinum**  
Data Analyst | Power BI Developer  
📧 [olisebinum@gmail.com](mailto:olisebinum@gmail.com)  
🔗 [Portfolio](https://www.datascienceportfol.io/olisebinum)

