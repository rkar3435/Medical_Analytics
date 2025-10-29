

SELECT
  appointment_id,
  patient_id,
  doctor_id,
  appointment_date,
  appointment_type,
  status,
  duration_minutes,
  notes,
  created_at,
  created_at AS updated_at,
  CURRENT_TIMESTAMP() AS dbt_loaded_at,
  '047bd0cd-5f32-4eba-bff0-54847885ed8b' AS dbt_batch_id
FROM MEDICAL_DB.RAW.appointments
WHERE appointment_id IS NOT NULL