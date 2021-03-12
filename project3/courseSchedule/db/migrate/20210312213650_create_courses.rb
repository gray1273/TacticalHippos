class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.integer :catalog_number
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
