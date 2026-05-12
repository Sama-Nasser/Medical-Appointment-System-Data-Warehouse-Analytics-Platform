# 🏥 Medical Appointment System & Data Warehouse Analytics Platform

## 📌 Project Overview

This project is a **complete end-to-end healthcare data system** consisting of:

1. **Operational Database (OLTP System)**
2. **Data Warehouse (OLAP System)**
3. **Analytics Layer (Business Intelligence Queries)**

It simulates a real-world **hospital/clinic management system** where transactional data is stored, processed, and transformed into meaningful business insights.

---

## 🏗️ System Architecture

The project is divided into two main layers:

### 1️⃣ Operational Database (OLTP)
- Built using SQL Server
- Contains the full transactional medical system
- Handles real-time operations such as:
  - Appointments
  - Patients
  - Doctors
  - Clinics
  - Payments
  - Medical Records
  - Notifications

This layer is optimized for **data insertion and daily operations**.

---

### 2️⃣ Data Warehouse (OLAP)

A separate database (`MedicalDW`) designed for analytics and reporting.

#### ⭐ Star Schema Design

##### Dimension Tables:
- DimDoctor
- DimPatient
- DimClinic
- DimDate
- DimAppointmentStatus
- DimAppointmentType
- DimPaymentMethod
- DimPaymentStatus

##### Fact Table:
- FactAppointments

The Fact table stores measurable business data such as:
- Appointment counts
- Fees
- Payments
- Status metrics

---

## 🔄 ETL Process

The project includes a full ETL pipeline:

### 🔹 Extract
Data is extracted from the operational database (`MedicalAppointmentSystem`).

### 🔹 Transform
Data is cleaned and transformed by:
- Mapping business keys to surrogate keys
- Converting dates into `DateKey (yyyyMMdd)`
- Handling NULL values using `ISNULL`
- Ensuring data consistency across tables

### 🔹 Load
Data is loaded into:
- Dimension tables first
- Fact table after relationships are established

---

## 📊 Analytics & Business Intelligence

The Data Warehouse supports advanced analytical queries such as:

- Total appointments per doctor
- Monthly appointment trends
- Appointment status distribution
- Doctor performance (completion rate & revenue)
- Clinic revenue analysis
- Payment method preferences
- Peak booking days
- Average fees per appointment type

---

## 💡 Business Value

This system provides real-world business insights such as:

- 📈 Performance tracking for doctors
- 💰 Revenue analysis per clinic and doctor
- 📊 Patient behavior analysis
- 📅 Appointment trend forecasting
- ⚡ Operational efficiency monitoring
- 🏥 Better healthcare decision-making

---

## 🧱 Technologies Used

- SQL Server
- T-SQL
- Data Modeling (Star Schema)
- ETL Processes
- Data Warehousing Concepts
- Business Intelligence (BI Queries)

---

## 🚀 Key Highlights

- Complete real-world healthcare system simulation
- Full OLTP + OLAP architecture
- Star Schema Data Warehouse design
- SQL analytical queries
- Scalable BI-ready structure

---

 
