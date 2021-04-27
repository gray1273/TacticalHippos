class CreateTerms < ActiveRecord::Migration[6.0]
  def change
    create_table :terms do |t|
      t.integer :season_id
      t.integer :year

      t.timestamps
    end
  end
end
