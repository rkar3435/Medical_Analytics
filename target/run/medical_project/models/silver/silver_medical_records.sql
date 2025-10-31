
  
    

create or replace transient table MEDICAL_DB.silver.silver_medical_records
    
    
    
    as (

WITH diagnosis_mapping AS (
  SELECT * FROM MEDICAL_DB.reference.diagnosis_codes
)
SELECT
  mr.record_id,
  mr.appointment_id,
  mr.patient_id,
  TRIM(mr.diagnosis) AS diagnosis,
  COALESCE(dm.diagnosis_category,'Other') AS diagnosis_category,
  COALESCE(dm.icd_10_code,'Unknown') AS icd_10_code,
  TRIM(mr.treatment_plan) AS treatment_plan,
  CASE 
    WHEN mr.treatment_plan = 'Medication' THEN 'Pharmacological'
    WHEN mr.treatment_plan IN ('Surgery','Procedure') THEN 'Surgical'
    WHEN mr.treatment_plan IN ('Physical Therapy','Counseling') THEN 'Therapeutic'
    ELSE 'Conservative' END AS treatment_category,
  mr.prescription,
  mr.follow_up_required,
  CASE WHEN mr.follow_up_required = 'Y' THEN 1 ELSE 0 END AS needs_follow_up,
  mr.severity,
  CASE 
    WHEN mr.severity = 'Low' THEN 1
    WHEN mr.severity = 'Medium' THEN 2
    WHEN mr.severity = 'High' THEN 3
    ELSE 0 END AS severity_score,
  mr.created_at,
  mr.updated_at,
  mr.dbt_loaded_at,
  mr.dbt_batch_id
FROM MEDICAL_DB.bronze.bronze_medical_records mr
LEFT JOIN diagnosis_mapping dm ON mr.diagnosis = dm.diagnosis_name
WHERE mr.record_id IS NOT NULL
    )
;


  