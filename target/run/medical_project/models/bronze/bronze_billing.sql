
  
    

create or replace transient table MEDICAL_DB.bronze.bronze_billing
    
    
    
    as (

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
  '6f8acd78-335b-4b2f-affc-df45076778f6' AS dbt_batch_id
FROM MEDICAL_DB.RAW.billing
WHERE billing_id IS NOT NULL
    )
;


  