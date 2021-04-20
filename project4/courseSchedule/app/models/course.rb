class Course < ApplicationRecord
    has_many :sections
    belongs_to :grader_sections
end
