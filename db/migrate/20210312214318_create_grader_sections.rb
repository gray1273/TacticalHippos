class CreateGraderSections < ActiveRecord::Migration[6.0]
  def change
    create_table :grader_sections do |t|
      t.integer :user_id
      t.integer :section_id

      t.timestamps
    end
  end
end
