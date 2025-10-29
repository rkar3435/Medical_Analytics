

SELECT
  doctor_id,
  doctor_name,
  specialty,
  department_id,
  phone,
  email,
  license_number,
  years_experience,
  is_active,
  hired_date,
  CURRENT_TIMESTAMP() AS dbt_loaded_at,
  '047bd0cd-5f32-4eba-bff0-54847885ed8b' AS dbt_batch_id
FROM MEDICAL_DB.RAW.doctors
WHERE doctor_id IS NOT NULL