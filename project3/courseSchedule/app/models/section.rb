class Section < ApplicationRecord
	has_one :courses
	has_one :users, :foreign_key => "instructor_id"
	has_one :section_types
	has_one :terms
	has_one :instruction_modes
	has_one :locations
	has_many :users, :through => :grader_sections
end
