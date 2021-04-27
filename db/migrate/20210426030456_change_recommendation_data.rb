class ChangeRecommendationData < ActiveRecord::Migration[6.0]
  def change
  	change_table :recommendations do |t|
  	t.change :user_id, :string
  	t.change :course_id, :string
  	t.change :section_id, :string
  	t.change :instructor_id, :string
  	end
  end
end
