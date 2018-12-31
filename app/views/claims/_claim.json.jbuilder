json.extract! claim, :id, :claim_date, :pharmacy, :drug, :prescription_cost, :plan_paid, :patient_paid, :created_at, :updated_at
json.url claim_url(claim, format: :json)
