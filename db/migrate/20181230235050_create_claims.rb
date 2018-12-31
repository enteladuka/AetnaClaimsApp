class CreateClaims < ActiveRecord::Migration[5.1]
  def change
    create_table :claims do |t|
      t.date :claim_date
      t.string :pharmacy
      t.string :drug
      t.decimal :prescription_cost
      t.decimal :plan_paid
      t.decimal :patient_paid

      t.timestamps
    end
  end
end
