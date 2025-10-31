
  
    

create or replace transient table MEDICAL_DB.gold.kpi_dashboard
    
    
    
    as (

WITH appt AS (
  SELECT 
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN is_completed = 1 THEN 1 ELSE 0 END) AS completed_appointments,
    SUM(CASE WHEN is_no_show = 1 THEN 1 ELSE 0 END) AS no_shows
  FROM MEDICAL_DB.gold.fact_appointments
),
rev AS (
  SELECT 
    SUM(total_amount) AS total_revenue,
    SUM(patient_paid) AS total_patient_paid,
    SUM(insurance_paid) AS total_insurance_paid
  FROM MEDICAL_DB.gold.fact_billing
)
SELECT 
  a.total_appointments,
  a.completed_appointments,
  a.no_shows,
  ROUND(a.no_shows * 100.0 / NULLIF(a.total_appointments, 0), 2) AS no_show_rate_pct,
  r.total_revenue,
  r.total_patient_paid,
  r.total_insurance_paid,
  CURRENT_DATE() AS kpi_as_of_date
FROM appt a CROSS JOIN rev r
    )
;


  