class Section < ApplicationRecord
	belongs_to :course
	belongs_to :instructor
	belongs_to :section_type
	belongs_to :term
	belongs_to :instruction_mode
	belongs_to :location
	has_many :users, through: :grader_sections

	scope :filter_by_course, -> (course) { where("course LIKE ?", "#{name}%") }
	scope :filter_by_instructor, -> (instructor) { where instructor: instructor }
	scope :filter_by_section_type, -> (section_type) { where section_type: section_type}
	scope :filter_by_term, -> (term) { where term: term }
	scope :filter_by_instruction_mode, -> (instruction_mode) { where instruction_mode: instruction_mode }
	scope :filter_by_location, -> (location) { where location: location }

	accepts_nested_attributes_for :course
	accepts_nested_attributes_for :instructor
	accepts_nested_attributes_for :section_type
	accepts_nested_attributes_for :term
	accepts_nested_attributes_for :instruction_mode
	accepts_nested_attributes_for :location
end
