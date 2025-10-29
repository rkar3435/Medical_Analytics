
  
    

create or replace transient table MEDICAL_DB.gold.patient_summary
    
    
    
    as (

WITH agg AS (
  SELECT 
    p.patient_id,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    COUNT(DISTINCT CASE WHEN a.is_completed = 1 THEN a.appointment_id END) AS completed_appointments,
    COUNT(DISTINCT CASE WHEN a.is_no_show = 1 THEN a.appointment_id END) AS no_show_count,
    COUNT(DISTINCT mr.record_id) AS total_diagnoses,
    COUNT(DISTINCT mr.diagnosis) AS unique_diagnoses,
    COUNT(DISTINCT CASE WHEN mr.severity = 'High' THEN mr.record_id END) AS high_severity_cases,
    COUNT(DISTINCT CASE WHEN mr.needs_follow_up = 1 THEN mr.record_id END) AS follow_ups_needed,
    COALESCE(SUM(b.total_amount), 0) AS lifetime_revenue,
    COALESCE(SUM(b.patient_paid), 0) AS total_patient_payments,
    COALESCE(SUM(b.insurance_paid), 0) AS total_insurance_payments,
    COALESCE(AVG(b.insurance_coverage_percentage), 0) AS avg_insurance_coverage,
    MAX(a.appointment_date) AS last_visit_date,
    MIN(a.appointment_date) AS first_visit_date
  FROM MEDICAL_DB.gold.dim_patients p
  LEFT JOIN MEDICAL_DB.gold.fact_appointments a ON p.patient_id = a.patient_id
  LEFT JOIN MEDICAL_DB.silver.silver_medical_records mr ON p.patient_id = mr.patient_id
  LEFT JOIN MEDICAL_DB.gold.fact_billing b ON p.patient_id = b.patient_id
  GROUP BY 1
)
SELECT 
  p.patient_id,
  p.full_name,
  p.age,
  p.age_group,
  p.insurance_category,
  a.total_appointments,
  a.completed_appointments,
  a.no_show_count,
  ROUND(a.no_show_count * 100.0 / NULLIF(a.total_appointments, 0), 2) AS no_show_rate,
  a.total_diagnoses,
  a.unique_diagnoses,
  a.high_severity_cases,
  a.follow_ups_needed,
  a.lifetime_revenue,
  a.total_patient_payments,
  a.total_insurance_payments,
  a.avg_insurance_coverage,
  a.last_visit_date,
  a.first_visit_date,
  DATEDIFF('day', a.first_visit_date, a.last_visit_date) AS patient_journey_days,
  CURRENT_TIMESTAMP() AS last_updated
FROM MEDICAL_DB.gold.dim_patients p
LEFT JOIN agg a ON p.patient_id = a.patient_id
    )
;


  