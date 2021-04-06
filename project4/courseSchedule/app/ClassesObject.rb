#Create classes object
class ClassesObject
	attr_accessor :classNumber, :className, :description, :classSections, :numberOfSections
	def initialize(classNumber, className, description, numberOfSections)
		#Class course code, name of the class, and description provided of the class
		@classNumber = classNumber
		@className = className
		@description = description
		#An array of all the SectionObjects that contain section specific info
		@classSections = Array.new
		#A number of how many sections are in the above array
		@numberOfSections = numberOfSections
	end

end

