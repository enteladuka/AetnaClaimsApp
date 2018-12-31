class Claim < ApplicationRecord
  require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      row.to_hash
      Claim.create(:claim_date => row["Date"], :pharmacy => row["Serviced By/Prescription Number"], :drug => row["Drug Name"], :prescription_cost => row[" Prescription Cost"], :plan_paid => row["Plan Paid"], :patient_paid => row["Your Responsibility"])
    end
  end
end
