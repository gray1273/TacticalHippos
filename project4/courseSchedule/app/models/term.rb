class Term < ApplicationRecord
	has_many :sections
	belongs_to :season

	accepts_nested_attributes_for :season
end
