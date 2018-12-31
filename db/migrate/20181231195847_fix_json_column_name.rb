class FixJsonColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :claims, :JSON, :JSONInput
  end
end
