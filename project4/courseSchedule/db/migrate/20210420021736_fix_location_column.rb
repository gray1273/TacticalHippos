class FixLocationColumn < ActiveRecord::Migration[6.0]
  def change
  	remove_column :sections, :location
  end
end
