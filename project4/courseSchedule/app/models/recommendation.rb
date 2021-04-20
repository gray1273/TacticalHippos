class Recommendation < ApplicationRecord
	has_one :course
	has_many :sections
	has one :user, :foreign_key => "instructor_id"
	enum recommendation_type: [:specificInstructor, :generalCourse]
end
