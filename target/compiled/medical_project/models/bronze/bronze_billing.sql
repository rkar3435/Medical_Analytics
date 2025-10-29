

SELECT
  billing_id,
  appointment_id,
  patient_id,
  total_amount,
  insurance_paid,
  patient_paid,
  billing_date,
  payment_status,
  insurance_claim_number,
  created_at,
  created_at AS updated_at,
  CURRENT_TIMESTAMP() AS dbt_loaded_at,
  '047bd0cd-5f32-4eba-bff0-54847885ed8b' AS dbt_batch_id
FROM MEDICAL_DB.RAW.billing
WHERE billing_id IS NOT NULL