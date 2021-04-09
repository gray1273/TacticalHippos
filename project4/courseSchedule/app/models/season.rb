class Season < ApplicationRecord
	has_many :terms

	#validates_uniqueness_of :title
end
