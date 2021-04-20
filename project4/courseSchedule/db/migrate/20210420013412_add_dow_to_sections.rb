class AddDowToSections < ActiveRecord::Migration[6.0]
  def change
  	add_column :sections, :days_of_week, :string
  end
end
