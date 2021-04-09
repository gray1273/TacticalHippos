class FixSectionColumnName < ActiveRecord::Migration[6.0]
  def change
  	rename_column :sections, :section_id, :section_number
  end
end
