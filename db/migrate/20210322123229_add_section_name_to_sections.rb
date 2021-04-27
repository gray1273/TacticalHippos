class AddSectionNameToSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :section_name, :string
  end
end
