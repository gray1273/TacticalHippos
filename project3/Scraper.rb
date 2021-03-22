#Create webscraper
require 'rubygems'
require 'nokogiri'
require './ClassesObject.rb'
require './SectionObject.rb'
require 'watir'
require 'webdrivers'


def updateSections(section, updater)
    #TODO set model's section data from updater
    
    section.section_number = updater.sectionNumber
    season = seasons.find_by title: updater.term
    term = terms.find_by year: updater.year, season_id: season
    section.term_id = term
    section.instructor_id = users.find updater.professor
    section.start_time = updater.time
    section.days_of_week = updater.days
    section.location = updater.building + updater.room

    section.save
end

def updateCourse(course, updater)
    course.title = updater.className
    course.catalog_number = updater.classNumber
    course.description = updater.description
    
    updater.courseSections.each do |newSection|
        section = Course.sections.find_by section_number: newSection.sectionNumber
        if section.blank? then
            updateSection(Section.new, newSection)
        else
            updateSection(section, newSection)
        end
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
            updateCourse(course, neCourse)
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
		description= indivClass.css('p.ng-binding').text.strip
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

#Usage
#temp = Array.new
#Campus = col
#term = 1214 for summer 2021
#depart = cse, ece, ETC
temp = scrapeWebsite("col", "1214", "cse") #NOTE: All 3 arguments must be strings!!
#addToModel(temp)
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






