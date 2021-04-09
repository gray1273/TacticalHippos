class Term < ApplicationRecord
	has_many :sections
	belongs_to :season

	accepts_nested_attributes_for :season

	validates_uniqueness_of :year, scope: :season_id
end
