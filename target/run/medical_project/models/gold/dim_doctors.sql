
  
    

create or replace transient table MEDICAL_DB.gold.dim_doctors
    
    
    
    as (

SELECT
  doctor_id,
  doctor_name,
  specialty,
  specialty_category,
  experience_level,
  care_category,
  years_experience,
  tenure_years,
  is_active_flag,
  hired_date,
  CURRENT_TIMESTAMP() AS last_updated
FROM MEDICAL_DB.silver.silver_doctors
    )
;


  