class Section < ApplicationRecord
	belongs_to :course
	belongs_to :instructor
	belongs_to :section_type
	belongs_to :term
	belongs_to :instruction_mode
	belongs_to :location
	has_many :users, through: :grader_sections

	accepts_nested_attributes_for :course
	accepts_nested_attributes_for :instructor
	accepts_nested_attributes_for :section_type
	accepts_nested_attributes_for :term
	accepts_nested_attributes_for :instruction_mode
	accepts_nested_attributes_for :location
end
