class AddInstructorIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :instructors, :instructor_id, :integer
  end
end
