class Instructor < ApplicationRecord
	belongs_to :User, optional: true
end
