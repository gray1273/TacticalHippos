class ChangeColumnIdName < ActiveRecord::Migration[6.0]
  def change
    rename_column :courses, :catalog_number, :course_id
    rename_column :sections, :section_number, :section_id
  end
end
