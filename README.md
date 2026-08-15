# ⚙️ Automated ETL Pipeline

An automated ETL pipeline built with **Python** and **FastAPI**, designed to pull data from multiple sources, transform it, and load it into **SQL Server** — all triggerable on-demand through a REST API.

![Python](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-API-009688?logo=fastapi&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL%20Server-Database-CC2927?logo=microsoftsqlserver&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 🧩 Problem Statement

Manually extracting, cleaning, and loading data from multiple sources into a database is slow, error-prone, and hard to repeat consistently. This project automates the entire pipeline, from raw multi-source data to clean, query-ready tables in SQL Server and exposes it through an API so the pipeline can be triggered on demand instead of run manually.

> **Goal:** Build a reliable, repeatable ETL system that ingests data from multiple sources, applies consistent transformations, and loads it into a centralized SQL Server database — triggerable via API rather than manual scripts.

---

## 🚀 Key Features

| Feature | Description |
|---|---|
| 🔄 **Multi-source Extraction** | Pulls data from multiple input sources (CSV, APIs, etc.) |
| 🧹 **Automated Transformation** | Cleans, standardizes, and reshapes data using Python/Pandas |
| 🗄️ **SQL Server Loading** | Loads transformed data directly into SQL Server tables |
| ⚡ **On-Demand Trigger** | FastAPI endpoint lets you kick off the pipeline anytime via HTTP request |
| 📊 **SQL-Ready Output** | Data lands in analysis-ready tables for reporting/BI tools |

---

## 🗂️ Project Structure

```
Automated-ETL-Pipeline/
│
├── API/
│   └── Fastapi.py            # FastAPI app exposing endpoints to trigger the ETL pipeline
│
├── ETL/
│   └── ETL_pipeline.py       # Core extract, transform, load logic
│
├── Data/
│   └── (raw / sample data files used by the pipeline)
│
├── sql/
│   └── analytics.sql         # SQL queries for analysis on loaded data
│
├── code/
│   └── main.py                # Entry point / orchestration script
│
└── README.md
```

---

## 🛠️ Tools & Technologies

| Layer | Tool |
|---|---|
| Language | Python |
| API Layer | FastAPI |
| Data Handling | Pandas, NumPy |
| Database | SQL Server (SQLAlchemy) |
| Config Management | python-dotenv |
| Version Control | Git & GitHub |

---

## ⚙️ How It Works

1. **Extract** — Data is pulled from configured source(s) (files, APIs, or external systems).
2. **Transform** — Raw data is cleaned, validated, and standardized using Python/Pandas.
3. **Load** — Transformed data is written into SQL Server tables.
4. **Trigger** — The entire flow is wrapped behind a FastAPI endpoint, so it can be run on-demand with a simple HTTP request instead of manually running scripts.

```
Source Data → Extract → Transform → Load → SQL Server
                              ▲
                        Triggered via
                        FastAPI endpoint
```

---

## 🔒 Security Notes

- Real credentials shall be stored only in a local `.env` file, which is excluded via `.gitignore` and **never pushed to GitHub**.

---

## 📌 Future Improvements

- Add scheduling (e.g., cron / Airflow) for fully automated recurring runs
- Add logging and error alerting for failed pipeline runs
- Add data validation checks before loading into SQL Server
- Containerize with Docker for easier deployment

---
## 👤 Author

**Priyanshu Dwivedi**

<p>
  <a href="https://www.linkedin.com/in/priyanshu-x-dwivedi">
    <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
  </a>
  &nbsp;
  <a href="mailto:priyanshud.0001@gmail.com">
    <img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white" alt="Email"/>
  </a>
</p>
