
  
    

create or replace transient table MEDICAL_DB.silver.silver_appointments
    
    
    
    as (

SELECT
  appointment_id,
  patient_id,
  doctor_id,
  appointment_date,
  DATE(appointment_date) AS appointment_date_only,
  TIME(appointment_date) AS appointment_time,
  EXTRACT(HOUR FROM appointment_date) AS appointment_hour,
  DAYNAME(appointment_date) AS day_of_week,
  CASE WHEN DAYNAME(appointment_date) IN ('Saturday','Sunday') THEN 'Weekend' ELSE 'Weekday' END AS day_type,
  CASE 
    WHEN EXTRACT(HOUR FROM appointment_date) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM appointment_date) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN EXTRACT(HOUR FROM appointment_date) BETWEEN 18 AND 21 THEN 'Evening'
    ELSE 'After Hours' END AS time_slot,
  appointment_type,
  status,
  CASE WHEN status = 'Completed' THEN 1 ELSE 0 END AS is_completed,
  CASE WHEN status = 'No-Show' THEN 1 ELSE 0 END AS is_no_show,
  CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END AS is_cancelled,
  duration_minutes,
  CASE 
    WHEN duration_minutes <= 15 THEN 'Short'
    WHEN duration_minutes <= 45 THEN 'Standard'
    ELSE 'Extended' END AS duration_category,
  notes,
  created_at,
  updated_at,
  dbt_loaded_at,
  dbt_batch_id
FROM MEDICAL_DB.bronze.bronze_appointments
WHERE appointment_id IS NOT NULL
    )
;


  