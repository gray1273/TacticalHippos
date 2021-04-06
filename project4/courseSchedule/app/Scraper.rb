#Create webscraper
require 'rubygems'
require 'nokogiri'
require './ClassesObject.rb'
require './SectionObject.rb'
require 'watir'
require 'webdrivers'
require './models/course.rb'
require './models/section.rb'
require './models/user.rb'
require './models/season.rb'


#Given a section, updates it to the webscraped information
def updateSection(section, updater)
    #TODO set model's section data from updater
    
    section.section_name = updater.sectionNumber
    season = Season.find_or_create_by title: updater.term
    section.term_id = Term.find_or_create_by year: updater.year, season_id: season
    section.instructor_id = (User.find_or_create_by first_name: updater.professor) or nil
    section.days_of_week = updater.days
    #section.location = Location.find_or_create_by location: updater.building + updater.room

    section.save
end

#Given a course, updates it to the webscraped information
def updateCourse(course, updater)
    course.title = updater.className
    course.course_name = updater.classNumber
    course.description = updater.description
    
    updater.classSections.each do |newSection|
        section = course.sections.find_by section_name: newSection.sectionNumber
        if section.blank? then
            section = Section.new
        end
        updateSection(section, newSection)
        course.sections << section
    end
    
    course.save
end

#Adds information to the model
def addToModel(courses)
    courses.each do |newCourse|
        course = Course.find_by title: newCourse.className
        if course.blank? then
            updateCourse(Course.new, newCourse)
        else
            updateCourse(course, newCourse)
        end
    end
end



#Create mechanize agent
#Campus = col
#term = 1214 for summer 2021
#depart = cse, ece, ETC
def scrapeWebsite(campus, term, depart)
	#Create custom URL based on input attributes - They must be present
	url = "https://classes.osu.edu/class-search/#/?q="+depart+"&campus="+campus+"&term="+term+"&p=1"
	#Open a browser to dynamically webscrape
	browser = Watir::Browser.new :firefox
	browser.goto(url)
	browser.element(css: "h1.loading-courses").wait_until_present
	#div.course.ng-scope
	
	
	
	classInfoArray = Array.new
	parseMain = Nokogiri::HTML(browser.html)
	totalClasses = Array.new
	
	#Find all the classes on the page
	totalClasses = parseMain.css('div.course.ng-scope')
	totalClasses.each do |indivClass|
		
		#get basic info for each class
		classNumber= indivClass.css('h3.ng-binding').text.strip
		className= indivClass.css('span.course-title.ng-binding').text.strip
		#Makes sure only course code is in the attribute classNumber
		classNumber = classNumber[0..9]
		#Adds a new location for description so it only gets this 'p.ng-binding' css element
		descriptionLocation = indivClass.css('div.col-md-12.light.course-info')
		description= descriptionLocation.css('p.ng-binding').text.strip
		classSections= indivClass.css('div.section-container.ng-scope')
		numberOfSections = classSections.length
		classInfo = ClassesObject.new(classNumber, className, description, numberOfSections)
		
		#Loops through each section that a class has
		classSections.each do |classSection|
			
			sectionNumber= classSection.css('h4.subtitle.ng-binding').text.strip
			year= classSection.css('span.label.primary.ng-binding').text.strip
			term= classSection.css('span.darker.ng-binding').text.strip
			#Gets info from the meeting division with time and location specifics
			meetingInfo= classSection.css('div.meeting.ng-scope')
				professor= meetingInfo.css('li.right.ng-binding.ng-scope').text.strip
				time= meetingInfo.css('div.meeting-times.ng-binding').text.strip
				days= meetingInfo.css('p.sr-only.sr-only-focusable.ng-binding').text.strip
				building= meetingInfo.css('p.ng-binding').text.strip
				room= meetingInfo.css('span.ng-binding.ng-scope').text.strip
				section = SectionObject.new(sectionNumber,year,term,professor,time,days,building,room)
			#Appends SectionObject to the array in its ClassesObject
			classInfo.classSections.append(section)
		end
		#Adds the ClassesObject to the output array
		classInfoArray.append(classInfo)	
	end	
	
	#puts parseMain
	#puts classInfoArray.length
return classInfoArray
end

=begin
class Scraper
    def initialize
        @temp = scrapeWebsite("col", "1214", "cse");
        addToModel(temp)
        return temp
    end
end
=end

#Usage
#temp = Array.new
#Campus = col
#term = 1214 for summer 2021
#depart = cse, ece, ETC
temp = scrapeWebsite("col", "1214", "cse") #NOTE: All 3 arguments must be strings!!
#temp.each do |course|
#	puts course.classNumber
#end
addToModel(temp)

#puts "Class Number: " + temp[1].classNumber
#puts "Class Name: " + temp[1].className
#puts "Class Description: " + temp[1].description
#puts temp[1].classSections.length
#numberOfSections can be used to run a for loop for each classSection
#puts temp[1].classSections[0].sectionNumber
#puts temp[1].classSections[0].year
#puts temp[1].classSections[0].term
#puts temp[1].classSections[0].professor
#puts temp[1].classSections[0].time
#puts temp[1].classSections[0].days
#puts temp[1].classSections[0].building
#puts temp[1].classSections[0].room






