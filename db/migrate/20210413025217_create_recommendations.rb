class CreateRecommendations < ActiveRecord::Migration[6.0]
  def change
    create_table :recommendations do |t|
	t.integer :user_id
    	t.integer :course_id
    	t.integer :section_id
    	t.integer :instructor_id
    	t.integer :recommendation_type #Using the Enum idea to decide if the recommendation is for a class or an instructor's section
    	
      t.timestamps
    end
  end
end
