# 🌐 Multi-Cloud Hybrid Data Pipeline
### **AWS (S3) | Azure (Blob) | Google Cloud (GCS) | Snowflake**  

## 📖 Project Overview
This project demonstrates a robust **Multi-Cloud Data Engineering** architecture. The goal was to break down data silos by integrating disparate datasets from the three major cloud providers into a single, unified analytical layer in **Snowflake**.

---

## 🏗️ Architecture
The pipeline connects three distinct cloud storage ecosystems to a centralized Snowflake Data Warehouse:
* **AWS S3:** Customer Master Data (connected via IAM Storage Integration).
* **Azure Blob Storage:** Regional Sales Data (connected via **SAS Token** for secure, granular access).
* **Google Cloud Storage:** Product Catalog (connected via **GCP Service Account**).

---

## 🛠️ Technical Implementation
### **1. Data Virtualization**
Used **External Stages** to query data directly from cloud buckets without initial ingestion, allowing for real-time data exploration.

### **2. Security & Authentication**
* **SAS Tokens:** Successfully bypassed ACCOUNTADMIN role restrictions in Azure by implementing Shared Access Signatures.
* **Service Accounts:** Configured GCP IAM roles to allow Snowflake-specific service accounts access to GCS buckets.

### **3. Semantic Layer**
Developed a unified SQL View (UNIFIED_CUSTOMER_INSIGHTS) using UNION ALL to standardize and merge schemas across all three providers.

---

## 📊 Hybrid Data Schema
| Source | Cloud Provider | Key Identifier | Entity Type |
| :--- | :--- | :--- | :--- |
| **S3** | Amazon Web Services | 100 - 200 | Customer |
| **Blob** | Microsoft Azure | 501 - 503 | Customer |
| **GCS** | Google Cloud | P101 - P103 | Product |

---

## 🚀 How to Run
1.  Execute the snowflake_setup.sql script in your Snowflake worksheet.
2.  Ensure you have the appropriate IAM roles and SAS tokens configured as per the script comments.
3.  Query the UNIFIED_CUSTOMER_INSIGHTS view to see the merged global dataset.

---

## 🧠 Challenges Overcome
* **Identity Resolution:** Managing different credential types (IAM vs. SAS vs. Key-pair).
* **Path Mapping:** Resolving 404 errors in GCS by implementing recursive directory listing.
* **Role Management:** Handling restricted environment permissions through direct credentialing.

