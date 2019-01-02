class Claim < ApplicationRecord

  validates :Covered_entities, :Other_insurance, presence: true
  validate :isJSON



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

  private

  def isJSON
    JSON.parse(self.JSONInput)
  rescue JSON::ParserError
    errors.add(:base, 'Data input is invalid. Please select all data and copy before pasting.')
  end
end
