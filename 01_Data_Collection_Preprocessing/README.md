# 🧩 Part 1 – Data Collection & Preprocessing  

This stage marks the foundation of the **Water Access Analytics** project.  
It focuses on gathering, cleaning, and structuring raw data into a reliable format for SQL analysis and Power BI visualization.  
The goal is to ensure data consistency, accuracy, and readiness for downstream analytical workflows.

---

## 📘 Overview  

Data preprocessing is a critical phase where raw, inconsistent, and fragmented datasets are transformed into a unified, structured database.  
In this project, data was collected from multiple sources including **community surveys**, **employee visit logs**, and **water source registries**.  

All datasets were cleaned, merged, and validated to create a relational database that reflects accurate water source functionality and accessibility across different regions.

---

## 🧱 Data Sources  

| Source | Description | Format |
|--------|--------------|---------|
| **Employee Records** | Information on field agents and technicians who surveyed water sources. | CSV / Excel |
| **Water Sources** | Registry of wells, shared taps, boreholes, and in-home taps, including their status and location. | CSV / Excel |
| **Visit Logs** | Records of inspection visits, queue times, and maintenance activities. | CSV |
| **Regional Mapping** | Lookup table mapping towns and provinces for geographical hierarchy. | CSV |

---

## 🧰 Tools & Techniques  

- **SQL (PostgreSQL / MySQL)** — For data import, cleaning, and structuring.  
- **Excel / CSV Handling** — Initial dataset review and formatting.  
- **Data Cleaning Techniques:**  
  - Removing duplicates and null entries.  
  - Standardizing province, town, and water source naming conventions.  
  - Converting inconsistent date and numeric formats.  
  - Validating population and visit counts.  
- **Schema Design:** Defined **primary keys** and **foreign key relationships** across tables for relational integrity.

---

## 🗂️ Folder Contents  

| File / Folder | Description |
|----------------|-------------|
| `data/` | Contains raw CSV / Excel data files used for import. |
| `cleaned_data/` | Processed and standardized data files ready for SQL ingestion. |
| `data_cleaning.sql` | SQL script for handling missing values, duplicates, and normalization. |
| `data_validation.sql` | Queries for verifying data consistency and referential integrity. |
| `schema_setup.sql` | Script for creating relational tables and constraints. |
| `README.md` | Documentation describing data collection and preprocessing steps. |

---

## 🧩 Database Schema Overview  

The project follows a **normalized database structure** designed for efficient querying and clear relationships between entities.  

```plaintext
┌─────────────────────┐       ┌─────────────────────┐
│     Employees       │       │    WaterSources     │
│─────────────────────│       │─────────────────────│
│ EmployeeID (PK)     │       │ SourceID (PK)       │
│ Name                │       │ SourceType          │
│ Role                │◄────┐ │ Province            │
│ Contact             │     │ │ Town                │
└─────────────────────┘     │ │ FunctionalityStatus │
                            │ └─────────────────────┘
                            │
                            │
                            ▼
┌─────────────────────┐
│      Visits         │
│─────────────────────│
│ VisitID (PK)        │
│ SourceID (FK)       │
│ EmployeeID (FK)     │
│ QueueTime           │
│ VisitDate           │
│ Notes               │
└─────────────────────┘

