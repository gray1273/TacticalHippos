class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.integer :course_id
      t.integer :instructor_id
      t.integer :section_type_id
      t.integer :term_id
      t.integer :instruction_mode_id
      t.integer :location_id
      t.integer :section_number
      t.integer :class_number
      t.string :location
      t.string :days_of_week
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
