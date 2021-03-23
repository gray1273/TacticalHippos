class Section < ApplicationRecord
	has_one :course
	has_one :user, :foreign_key => "instructor_id"
	has_one :section_type
	has_one :term
	has_one :instruction_mode
	has_one :location
	has_many :users, through: :grader_sections
end
