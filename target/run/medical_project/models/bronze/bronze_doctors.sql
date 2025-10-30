
  
    

create or replace transient table MEDICAL_DB.bronze.bronze_doctors
    
    
    
    as (

SELECT
  doctor_id,
  doctor_name,
  specialty,
  department_id,
  phone,
  email,
  license_number,
  years_experience,
  is_active,
  hired_date,
  CURRENT_TIMESTAMP() AS dbt_loaded_at,
  '6f8acd78-335b-4b2f-affc-df45076778f6' AS dbt_batch_id
FROM MEDICAL_DB.RAW.doctors
WHERE doctor_id IS NOT NULL
    )
;


  