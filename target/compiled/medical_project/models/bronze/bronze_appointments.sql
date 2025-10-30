

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
  '6f8acd78-335b-4b2f-affc-df45076778f6' AS dbt_batch_id
FROM MEDICAL_DB.RAW.appointments
WHERE appointment_id IS NOT NULL