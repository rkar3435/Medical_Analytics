
  
    

create or replace transient table MEDICAL_DB.gold.fact_appointments
    
    
    
    as (

SELECT 
  a.appointment_id,
  a.patient_id,
  a.doctor_id,
  a.appointment_date,
  a.appointment_date_only,
  a.day_of_week,
  a.day_type,
  a.time_slot,
  a.appointment_type,
  a.status,
  a.is_completed,
  a.is_no_show,
  a.is_cancelled,
  a.duration_minutes,
  a.duration_category,
  -- Patient context
  p.age_group AS patient_age_group,
  p.insurance_category AS patient_insurance_category,
  p.senior_status AS patient_senior_status,
  -- Doctor context
  d.specialty AS doctor_specialty,
  d.experience_level AS doctor_experience_level,
  d.care_category AS doctor_care_category,
  -- Business metrics (illustrative)
  CASE 
    WHEN a.appointment_type = 'Emergency' THEN 500
    WHEN a.appointment_type = 'Surgery' THEN 2000
    WHEN a.appointment_type = 'Consultation' THEN 200
    WHEN a.appointment_type = 'Follow-up' THEN 100
    WHEN a.appointment_type = 'Screening' THEN 150
    ELSE 175 END AS estimated_revenue,
  a.created_at,
  CURRENT_TIMESTAMP() AS last_updated
FROM MEDICAL_DB.silver.silver_appointments a
LEFT JOIN MEDICAL_DB.gold.dim_patients p ON a.patient_id = p.patient_id
LEFT JOIN MEDICAL_DB.gold.dim_doctors d ON a.doctor_id = d.doctor_id
    )
;


  