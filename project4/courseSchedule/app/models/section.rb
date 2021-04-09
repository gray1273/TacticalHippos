class Section < ApplicationRecord
	belongs_to :course
	belongs_to :user, :foreign_key => "instructor_id"
	belongs_to :section_type
	belongs_to :term
	belongs_to :instruction_mode
	belongs_to :location
	has_many :users, through: :grader_sections

	accepts_nested_attributes_for :user
	accepts_nested_attributes_for :section_type
	accepts_nested_attributes_for :term
	accepts_nested_attributes_for :instruction_mode
	accepts_nested_attributes_for :location
end
