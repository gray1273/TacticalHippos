class AddColumnsToGraderSections < ActiveRecord::Migration[6.0]
  def change
    remove_column :grader_sections, :user_id, :integer
    add_column :grader_sections, :course_id, :integer
    add_column :grader_sections, :application_id, :integer
    add_column :grader_sections, :preference, :integer #1-5 how much they prefer this section
    add_column :grader_sections, :status, :integer #Enum accepted/rejected/applied
  end
end
