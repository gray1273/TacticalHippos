class FixSectionTypeColumnName < ActiveRecord::Migration[6.0]
  def change
  	rename_column :section_types, :type, :title
  end
end
