class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :claims, :pharmacy, :provider
  end
end
