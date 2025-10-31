
  
    

create or replace transient table MEDICAL_DB.gold.fact_billing
    
    
    
    as (

SELECT 
  b.billing_id,
  b.appointment_id,
  b.patient_id,
  b.total_amount,
  b.insurance_paid,
  b.patient_paid,
  b.insurance_coverage_percentage,
  b.revenue_tier,
  b.coverage_quality,
  b.payment_status,
  b.collection_status,
  b.is_overdue,
  b.days_since_billing,
  -- Appointment context
  a.appointment_date,
  a.appointment_type,
  a.time_slot,
  a.doctor_id,
  -- Patient context
  p.insurance_category AS patient_insurance_category,
  p.age_group AS patient_age_group,
  -- Doctor context
  d.specialty AS service_specialty,
  d.care_category AS service_care_category,
  b.created_at,
  CURRENT_TIMESTAMP() AS last_updated
FROM MEDICAL_DB.silver.silver_billing b
LEFT JOIN MEDICAL_DB.gold.fact_appointments a ON b.appointment_id = a.appointment_id
LEFT JOIN MEDICAL_DB.gold.dim_patients p ON b.patient_id = p.patient_id
LEFT JOIN MEDICAL_DB.gold.dim_doctors d ON a.doctor_id = d.doctor_id
    )
;


  