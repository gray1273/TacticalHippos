#Create classes object
class SectionObject
	attr_accessor :sectionNumber, :year, :term, :professor, :time, :days, :building, :room
	def initialize(sectionNumber,year,term,professor,time,days,building,room)
		#attributes have information for one of the sections in the class
		@sectionNumber = sectionNumber
		@year = year
		@term = term
		@professor = professor
		@time = time
		@days = days
		@building = building
		@room = room
	end

end



