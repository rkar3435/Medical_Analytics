
  
    

create or replace transient table MEDICAL_DB.silver.silver_patients
    
    
    
    as (

SELECT
  patient_id,
  TRIM(UPPER(first_name)) AS first_name,
  TRIM(UPPER(last_name)) AS last_name,
  TRIM(UPPER(first_name)) || ' ' || TRIM(UPPER(last_name)) AS full_name,
  date_of_birth,
  
  DATEDIFF('year', date_of_birth, CURRENT_DATE())
 AS age,
  
  CASE
    WHEN 
  DATEDIFF('year', date_of_birth, CURRENT_DATE())
 < 18 THEN 'Minor'
    WHEN 
  DATEDIFF('year', date_of_birth, CURRENT_DATE())
 BETWEEN 18 AND 39 THEN 'Young Adult'
    WHEN 
  DATEDIFF('year', date_of_birth, CURRENT_DATE())
 BETWEEN 40 AND 59 THEN 'Middle Age'
    WHEN 
  DATEDIFF('year', date_of_birth, CURRENT_DATE())
 BETWEEN 60 AND 79 THEN 'Senior'
    ELSE 'Elderly'
  END
 AS age_group,
  CASE WHEN 
  DATEDIFF('year', date_of_birth, CURRENT_DATE())
 >= 65 THEN 'Senior' ELSE 'Non-Senior' END AS senior_status,
  UPPER(gender) AS gender,
  blood_type,
  CASE 
    WHEN blood_type IN ('O+','O-') THEN 'Universal Donor'
    WHEN blood_type IN ('AB+','AB-') THEN 'Universal Recipient'
    ELSE 'Standard' END AS blood_type_category,
  phone,
  LOWER(TRIM(email)) AS email,
  address,
  TRIM(UPPER(city)) AS city,
  UPPER(state) AS state,
  zip_code,
  insurance_type,
  CASE 
    WHEN insurance_type IN ('Medicare','Medicaid') THEN 'Government'
    WHEN insurance_type = 'Private' THEN 'Commercial'
    ELSE 'Other' END AS insurance_category,
  emergency_contact,
  created_at,
  updated_at,
  dbt_loaded_at,
  dbt_batch_id
FROM MEDICAL_DB.bronze.bronze_patients
WHERE patient_id IS NOT NULL
    )
;


  