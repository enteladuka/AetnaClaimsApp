class AddCoveredEntitiesColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :Covered_entities, :string
    add_column :claims, :Other_insurance, :integer
  end
end
