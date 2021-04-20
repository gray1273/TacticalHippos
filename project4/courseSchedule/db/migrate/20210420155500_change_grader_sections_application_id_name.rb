class ChangeGraderSectionsApplicationIdName < ActiveRecord::Migration[6.0]
  def change
    rename_column :grader_sections, :application_id, :grader_id
  end
end
