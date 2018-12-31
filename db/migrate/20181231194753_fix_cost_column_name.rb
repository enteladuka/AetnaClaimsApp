class FixCostColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :claims, :prescription_cost, :total_cost
  end
end
