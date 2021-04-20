class RemoveExtraColumnFromCourses < ActiveRecord::Migration[6.0]
  def change
  	remove_column :courses, :course_id
  end
end
