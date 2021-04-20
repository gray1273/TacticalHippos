class GraderSection < ApplicationRecord
	belongs_to :application
    belongs_to :course
	belongs_to :section#, option: true
    enum status: [:accepted, :rejected, :applied]
end
