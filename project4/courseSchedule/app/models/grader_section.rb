class GraderSection < ApplicationRecord
	belongs_to :grader
    belongs_to :course
	belongs_to :section 
    enum status: [:accepted, :rejected, :applied]
end
