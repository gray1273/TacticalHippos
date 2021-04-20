class GraderSection < ApplicationRecord
	has_one :grader
    has_one :course
	has_one :section 
    enum status: [:accepted, :rejected, :applied]
end
