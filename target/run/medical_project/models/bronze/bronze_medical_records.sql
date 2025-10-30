
  
    

create or replace transient table MEDICAL_DB.bronze.bronze_medical_records
    
    
    
    as (

SELECT
  record_id,
  appointment_id,
  patient_id,
  diagnosis,
  treatment_plan,
  prescription,
  follow_up_required,
  severity,
  created_at,
  created_at AS updated_at,
  CURRENT_TIMESTAMP() AS dbt_loaded_at,
  '6f8acd78-335b-4b2f-affc-df45076778f6' AS dbt_batch_id
FROM MEDICAL_DB.RAW.medical_records
WHERE record_id IS NOT NULL
    )
;


  