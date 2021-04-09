class FixUserTypeColumnName < ActiveRecord::Migration[6.0]
  def change
  	rename_column :user_types, :title_string, :title
  end
end
