class Claim < ApplicationRecord
  require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      row.to_hash
      pharmacy = row["Serviced By/Prescription Number"].rstrip #removes extra space at the end of string
      pharmacy[/[R][X]\d+$/] = '' #removes rxnumber/regex proof: https://rubular.com/r/FinC8OSIqR40
      Claim.create(:claim_date => row["Date"], :pharmacy => pharmacy, :drug => row["Drug Name"], :prescription_cost => row[" Prescription Cost"], :plan_paid => row["Plan Paid"], :patient_paid => row["Your Responsibility"])
    end
  end
end
