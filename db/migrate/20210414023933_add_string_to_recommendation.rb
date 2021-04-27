class AddStringToRecommendation < ActiveRecord::Migration[6.0]
  def change
  	add_column :recommendations, :description, :string
  end
end
