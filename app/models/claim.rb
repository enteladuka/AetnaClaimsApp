class Claim < ApplicationRecord
require 'csv'
  def self.import(file)
    unless file == nil
      CSV.foreach(file.path, headers: true) do |row|
        row.to_hash
        if row["Serviced By/Prescription Number"] != nil
          provider = row["Serviced By/Prescription Number"].rstrip
          provider[/[R][X]\d+$/] = ''             #proof: https://rubular.com/r/FinC8OSIqR40
          cost = row[" Prescription Cost"]
        else row["Provider"] != nil
          provider = row["Provider"]
          cost = row["Bill Amount"]
        end
        Claim.create(:claim_date => row["Date"], :provider => provider, :drug => row["Drug Name"], :total_cost => cost, :plan_paid => row["Plan Paid"], :patient_paid => row["Your Responsibility"])
      end
    end
  end
end
