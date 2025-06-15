# 🚑 Hospital Patient Records | SQL & Power BI Analytics 
This project analysed synthetic hospital patient data from Massachusetts General Hospital (2011–2022) using SQL and Power BI to uncover insights on admissions, treatment costs, mortality trends, and insurance coverage. The final dashboard integrates dynamic slicers and summary cards to deliver a comprehensive and interactive view of healthcare operations.

## 📌 Table of Contents  
- [Dataset Overview](#1.-dataset-overview)  
- [Key Insights](#2.-key-insights)
- [Technology Stack](#3.-technology-stack)  
- [SQL Queries](#4.-sql-queries)  
- [Power BI Dashboard](#5.-power-bi-dashboard)  
- [How to Use](#6.-how-to-use)
- [Contact](#7.-contact)
- [Final Thoughts](#8.-final_thoughts)

  
## 1. Dataset Overview  
This project utilises **synthetic hospital data** containing ~1,000 patients from **Massachusetts General Hospital** over a **12-year period (2011-2022)**.  

### **Dataset Source:**  
The dataset used in this project comes from **Maven Analyticss** Hospital Patient Records Dataset:  
🔗 [Download Dataset](https://mavenanalytics.io/data-playground?order=date_added%2Cdesc&search=Hospital%20Patient%20Records)

### **Dataset Structure:**  
| Table Name    | Description |
|--------------|------------|
| `patients`   | Stores demographic details of hospital patients |
| `encounters` | Tracks patient visits, costs, and insurance coverage |
| `organizations` | Lists hospitals & medical facilities |
| `payers` | Contains insurance provider details |
| `procedures` | Stores medical procedures performed during encounters |

### **Recommended Analysis:**  
📊 **How many patients have been admitted or readmitted over time?**  
📉 **How long are patients staying in the hospital, on average?**  
💰 **How much is the average cost per visit?**  
📌 **How many procedures are covered by insurance?**  

---

## 2. Key Insights  

✅ **Admissions & Readmissions Over Time** – Understand patient return rates & hospital trends.  
✅ **Hospital Utilisation & Length of Stay Analysis** – Track efficiency and resource usage.  
✅ **Insurance Coverage Breakdown** – Compare **payer vs out-of-pocket costs**.  
✅ **Treatment Costs & Procedure Analytics** – Identify **high-cost vs low-cost treatments**.  
✅ **Mortality Rate by Encounter Type** – Assess **death rates across departments**.  
✅ **Hospital Revenue Breakdown** – Analyse **financial trends** & **insurance coverage**.  
✅ **Rolling Average Patient Visits** – Monitor **long-term trends using window functions**.  
✅ **Frequent Patients & Repeat Visits** – Find **most returning individuals**.  

---

## 3. Technology Stack  
- **SQL MySQL)** – Database design, queries, and analytics  
- **Power BI** – Dashboard visualization  
- **Google Drive/Maven Analytics** – Hosting large datasets

---
## 4. SQL Queries  

### 📊 Analytical Queries  

**1️⃣ Patient Admission Over Time** - Analyses annual patient inflow to identify admission trends.  
**2️⃣ Average Length of Stay** - Measures the average hospitalisation duration per visit.    
**3️⃣ Cost Per Visit** - Calculates the average claim cost across visit encounter class.  
**4️⃣ Insurance Coverage Analysis** - Evaluates insurance covered procedures.  
**5️⃣ Hospital Utilisation** - Assesses patient volume encounter over time.   
**6️⃣ Patient Deceased by Encounter Types** - Compares death rates across different encounter categories.  

---

### 📊 Advanced SQL Queries Using CTEs & Window Functions  

**1️⃣ Patient Admissions & Re-admissions** - Identifies frequent patient returns to track continuity of care.  
**2️⃣ Average Length of Stay by Encounter Type** - Compares hospital stay duration by encounter classification.  
**3️⃣ High-Cost Vs Low-Cost Treatments**  - Ranking insurance claim cost over encounter type.  
**4️⃣ Insurance Coverage Percentage** - Calculate coverage rates per payer.  
**5️⃣ Hospital Utilisation & Rolling Average** - Visualises yearly encounter trends using rolling averages.  
**6️⃣ Patient Visit Frequency & Trends** - Tracks repeat visits across time periods.  
**7️⃣ Hospital Revenue Insights** - Breaks down hospital revenue streams and payer impact.  
**8️⃣ Most Common Procedures & Associated Costs** - Ranking most common treatments and their financial implications.    
**9️⃣ Patient Mortality Rate by Encounter Type** - Evaluates patient death rates based on encounter type.  
**🔟 Insurance Cost vs Patient Payments** - Compares insurer coverage rate with patient contributions rate.  

---

## 5. Power BI Dashboard  

### **Dashboard Name:** **Health Patient Hub**  
### **Visualisations Included:**  
✔️ **Admissions & Re-admissions Trend Over Time** 📈 (Line Chart) - Year-over-year trends and patient retention.  
✔️ **Average Length of Stay by Gender** 🏥 (Bar Chart) - Compares average hospitalisation periods across gender.  
✔️ **Average Cost Per Visit** 💰 (Pie Chart) - Highlights average cost for patients visit.  
✔️ **Insurance Coverage Breakdown** 📊 (Column Charts): Highlights financial responsibility between patients and insurers across encounter class.  
✔️ **Hospital Utilisation & Capacity Trends** 📉 (Rolling Trend Line) - Shows yearly trends with rolling averages for operational analysis.  


### **🔹 Slicers (Filters) for Interactive Dashboard**  
Slicers allow users to **filter data dynamically** for deeper insights:  
- **Date Range (Year)** – Select hospital trends over time.  
- **Encounter Type** – Compare admissions across **Emergency, Inpatient, Wellness, Urgentcare**.  
- **City** – Focus on **patient location trends**.  
- **Gender** – Breakdown **data by male vs female patients**.  
- **Reason for Visit** – Analyse **common treatments & conditions**.  

### **🔹 Cards for Summary Metrics**  
Cards provide **quick key metrics** for immediate insights:  
- **Total Cost** – `$101.51M` (Hospital claim costs).  
- **Total Patients** – `974` (Unique hospital visitors).  
- **Mortality Rate** – `15.81%` (Patient deaths per encounter type).  
- **Average Cost Per Visit** – `$3.64K` (Across all encounters).   

### 📸 Screenshot 
📊 **Power BI Dashboard:**  
![Power BI Dashboard](https://github.com/user-attachments/assets/cfb5b2cd-3595-444d-b438-3896f580c854)


---

## 6. How to Use  

### **SQL Setup & Analysis**  
1️⃣ **Run Schema Setup:** Execute `schema_setup.sql` to set up database.  
2️⃣ **Import Data:** Load all 5 CSV datasets.  
3️⃣ **Run Analytical Queries:** Execute queries from `analytical_queries.sql`.  
4️⃣ **Optimize Query Performance:** Apply indexing & filtering for better efficiency.  

### **Power BI Dashboard Deployment**  
1️⃣ **Open Power BI Desktop**  
2️⃣ **Import Data** – Load all 5 CSV datasets & create relationships.  
3️⃣ **Apply Visualisations** – Add **charts, slicers, and cards** for better insights.  
4️⃣ **Customise Interactivity** – Enable **cross-filtering for dynamic reporting**.  
5️⃣ **Publish Dashboard** – Export `.pbix` file or share online for access.  

---

## 7. Contact  
📧 Email: [sudeeprai969@gmail.com](mailto:sudeeprai969@gmail.com)  
🔗 LinkedIn: [Sudeep Rai](https://www.linkedin.com/in/sudeep-rai/) 

---

## 8. Final Thoughts
Hospital Patient Analytics delivers intelligent healthcare insights by combining SQL-driven analysis with rich Power BI dashboards.  
Feel free to open an issue or contribute to expand healthcare analytics use cases.  
