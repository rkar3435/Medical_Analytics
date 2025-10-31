
  
    

create or replace transient table MEDICAL_DB.gold.dim_patients
    
    
    
    as (

SELECT
  patient_id,
  first_name,
  last_name,
  full_name,
  date_of_birth,
  age,
  age_group,
  senior_status,
  gender,
  blood_type,
  blood_type_category,
  city,
  state,
  insurance_type,
  insurance_category,
  emergency_contact,
  created_at AS patient_since,
  DATEDIFF('day', created_at, CURRENT_DATE()) AS days_as_patient,
  CURRENT_TIMESTAMP() AS last_updated
FROM MEDICAL_DB.silver.silver_patients
    )
;


  