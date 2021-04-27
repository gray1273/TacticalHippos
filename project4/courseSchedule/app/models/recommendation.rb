class Recommendation < ApplicationRecord
	has_one :user
	has_one :course
	has_one :section
	has_one :instructor, :foreign_key => "instructor_id"
	
	
end
