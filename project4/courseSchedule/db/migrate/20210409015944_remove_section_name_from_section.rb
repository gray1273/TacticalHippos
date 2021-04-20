class RemoveSectionNameFromSection < ActiveRecord::Migration[6.0]
  def change
  	remove_column :sections, :section_name
  end
end
