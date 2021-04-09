class AddUniqueCheckToSeasons < ActiveRecord::Migration[6.0]
  def change
  	add_index :term, [:season_id, :year], :unique => true
  end
end
