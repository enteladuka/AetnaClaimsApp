class ChangeColumnTypes < ActiveRecord::Migration[5.1]
  def change
    change_column :claims, :claim_date, :string
    change_column :claims, :prescription_cost, :string
    change_column :claims, :plan_paid, :string
    change_column :claims, :patient_paid, :string
  end
end
