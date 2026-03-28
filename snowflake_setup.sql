-- ==========================================
-- PROJECT: TRIPLE-CLOUD HYBRID DATA PIPELINE
-- ARCHITECT: Sathwika P.
-- DESCRIPTION: Integrating AWS S3, Azure Blob, and GCS
-- ==========================================

-- 1. DATABASE SETUP
CREATE DATABASE IF NOT EXISTS DE_HYBRID_DB;
USE SCHEMA DE_HYBRID_DB.RAW;

-- 2. AWS S3 INTEGRATION (IAM ROLE)
CREATE OR REPLACE STAGE s3_customer_stage
  URL = 's3://de-hybrid-storage-sathwika/customers/'
  FILE_FORMAT = my_csv_format;

-- 3. AZURE BLOB INTEGRATION (SAS TOKEN)
-- Bypassing AccountAdmin restrictions using direct credentials
CREATE OR REPLACE STAGE azure_sas_stage
  URL = 'azure://sathwikadata24.blob.core.windows.net/customers/'
  CREDENTIALS = (AZURE_SAS_TOKEN = 'sv=2024-11-04&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2026-04-03T11:58:08Z&st=2026-03-28T03:43:08Z&spr=https&sig=bfw%2BKevvlUs8SXBXPYfs5wjnrWrjveEGNxG%2BK73CmQI%3D')
  FILE_FORMAT = my_csv_format;

-- 4. GCP GCS INTEGRATION (SERVICE ACCOUNT)
CREATE OR REPLACE STAGE gcp_product_stage
  URL = 'gcs://de-hybrid-gcs-sathwika/'
  STORAGE_INTEGRATION = gcp_integration
  FILE_FORMAT = my_csv_format;

-- 5. THE UNIFIED SEMANTIC VIEW (THE BRAIN)
CREATE OR REPLACE VIEW UNIFIED_CUSTOMER_INSIGHTS AS
SELECT 'AWS-S3' AS CLOUD_PROVIDER, ::INT AS ID, ::STRING AS NAME FROM @s3_customer_stage
UNION ALL
SELECT 'AZURE-BLOB', CUSTOMER_ID, FIRST_NAME FROM AZURE_CUSTOMERS
UNION ALL
SELECT 'GCP-GCS', 701, PRODUCT_NAME FROM GCP_PRODUCTS;

SELECT * FROM UNIFIED_CUSTOMER_INSIGHTS;
