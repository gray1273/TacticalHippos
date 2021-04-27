#Create webscraper
require 'rubygems'
require 'nokogiri'
require_relative 'ClassesObject.rb'
require_relative 'SectionObject.rb'
require 'watir'
require 'webdrivers'
#https://stackoverflow.com/questions/5942281/ruby-scripts-with-access-to-rails-models
require_relative '../config/environment.rb'


#Given a section, updates it to the webscraped information
def updateSection(section, updater)
    #TODO set model's section data from updater
    
    section.section_name = updater.sectionNumber
    season = Season.find_or_create_by title: updater.term
    section.term_id = Term.find_or_create_by year: updater.year, season_id: season
    section.instructor_id = (User.find_or_create_by first_name: updater.instructor) or nil
    section.daysOfWeek = updater.days
    #section.location = Location.find_or_create_by location: updater.building + updater.room

    section.save
end

#Given a course, updates it to the webscraped information
def updateCourse(course, updater)
    course.title = updater.courseTitle
    course.course_name = updater.courseName
    course.description = updater.description
    
    updater.courseSections.each do |newSection|
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
        course = Course.find_by title: newCourse.courseTitle
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
	
	# sectionController = SectionsController.new
	
	#classInfoArray = Array.new
	parseMain = Nokogiri::HTML(browser.html)
	totalCourses = Array.new
	
	#Find all the courses on the page
	totalCourses = parseMain.css('div.course.ng-scope')
	totalCourses.each do |individualCourse|
		
		#this tag has multiple things that we need so we split it up
		courseHeader = individualCourse.css('h3.ng-binding').text.strip.split("\n")
		courseName = courseHeader[0]
		courseTitle = courseHeader[1]
		courseDescription = individualCourse.css('div.col-md-12.light.course-info').css('p.ng-binding').text.strip
		
		if courseName.nil?
			courseName = ""
		end
		if courseTitle.nil?
			courseTitle = ""
		else
			#https://ruby-doc.org/core-3.0.1/String.html#method-i-lstrip
			courseTitle = courseTitle.lstrip
		end
		if courseDescription.nil?
			courseDescription = ""
		end

		courseSections = individualCourse.css('div.section-container.ng-scope')
		numberOfSections = courseSections.length
		course = Course.find_or_create_by(:course_name => courseName, :title => courseTitle, :description => courseDescription)
		# puts course.course_name + "\t" + course.title + "\t" + course.description[0..25]
		#classInfo = ClassesObject.new(courseName, courseTitle, courseDescription, numberOfSections)
		
		#Loops through each section that a course has
		courseSections.each do |individualSection|
			sectionHeader = individualSection.css('h4.subtitle.ng-binding').text.strip.split("\n")
			#e.g. "Lecture"
			sectionType = sectionHeader[1]
			#e.g. "Section 0010 (5088)"
			if sectionType.nil?
				sectionType = ""
			else
				#https://ruby-doc.org/core-3.0.1/String.html#method-i-lstrip
				sectionType = sectionType.lstrip
			end

			numberInfo = sectionHeader[2].split(" ")
			sectionNumber = numberInfo[1]
			if sectionNumber.nil?
				sectionNumber = 0
			else
				sectionNumber = sectionNumber.to_i
			end
			classNumber = numberInfo[2]
			if classNumber.nil?
				classNumber = 0;
			else
				classNumber = classNumber[1..numberInfo[2].length-1].to_i
			end

			sectionTerm = individualSection.css('span.label.primary.ng-binding').text.strip

			instructionMode = individualSection.css('p.ng-binding').text.strip.split("\n")[0].split(":")[1].lstrip

			#Gets info from the meeting division with time and location specifics
			meetingInfo = individualSection.css('div.meeting.ng-scope')

			instructor = meetingInfo.css('li.right.ng-binding.ng-scope').text.strip.split(" ")
			instructorLastName = instructor.pop
			instructorFirstName = instructor.join(" ")

			days= meetingInfo.css('p.sr-only.sr-only-focusable.ng-binding').text.strip
			daysOfWeek = ""
			#https://stackoverflow.com/questions/8258517/how-to-check-whether-a-string-contains-a-substring-in-ruby/8258571
			if days.include? "Sunday"
				daysOfWeek += "Su"
			end
			if days.include? "Monday"
				daysOfWeek += "M"
			end
			if days.include? "Tuesday"
				daysOfWeek += "Tu"
			end
			if days.include? "Wednesday"
				daysOfWeek += "W"
			end
			if days.include? "Thursday"
				daysOfWeek += "Th"
			end
			if days.include? "Friday"
				daysOfWeek += "F"
			end
			if days.include? "Saturday"
				daysOfWeek += "Sa"
			end

			location= meetingInfo.css('p.ng-binding').text.strip.split("\n")[0]

			dates = meetingInfo.css('div.meeting-dates.ng-binding').text.strip.split(" - ")
			startDate = dates[0].split("/")
			startDateMonth = -1
			startDateDay = -1
			startDateYear = -1
			unless startDate.nil?
				startDateMonth = startDate[0].to_i
				startDateDay = startDate[1].to_i
				startDateYear = startDate[2].to_i
				if startDateYear < 2000 
					startDateYear += 2000
				end
			end

			endDate = dates[1].split("/")
			endDateMonth = -1
			endDateDay = -1
			endDateYear = -1
			unless endDate.nil?
				endDateMonth = endDate[0].to_i
				endDateDay = endDate[1].to_i
				endDateYear = endDate[2].to_i
				if endDateYear < 2000
					endDateYear += 2000
				end
			end

			times = meetingInfo.css('div.meeting-times.ng-binding').text.strip.split(" - ")
			startTime = times[0]
			startTimeHour = -1
			startTimeMinute = -1
			unless startTime.nil?
				startTime = startTime.strip.split(" ")
				clockTime = startTime[0].split(":")
				amPm = startTime[1]
				startTimeHour = clockTime[0].to_i
				#https://stackoverflow.com/questions/21331057/string-equalsignorecase-equivalent-in-ruby
				if !amPm.nil? && amPm.casecmp("pm")
					startTimeHour += 12
				end
				startTimeMinute = clockTime[1].to_i
			end
			endTime = times[1]
			endTimeHour = -1
			endTimeMinute = -1
			unless endTime.nil?
				endTime = endTime.strip.split(" ")
				clockTime = endTime[0].split(":")
				amPm = endTime[1]
				endTimeHour = clockTime[0].to_i
				#https://stackoverflow.com/questions/21331057/string-equalsignorecase-equivalent-in-ruby
				if !amPm.nil? && amPm.casecmp("pm")
					endTimeHour += 12
				end
				endTimeMinute = clockTime[1].to_i
			end
			
			puts "#{startTimeHour}:#{startTimeMinute}-#{endTimeHour}:#{endTimeMinute}|#{startDateYear}/#{startDateMonth}/#{startDateDay}-#{endDateYear}/#{endDateMonth}/#{endDateDay}"
			SectionsController.create_safely(course,
											sectionNumber,
											classNumber,
											instructorFirstName,
											instructorLastName,
											sectionType,
											sectionTerm,
											instructionMode,
											location,
											startDateYear,
											startDateMonth,
											startDateDay,
											endDateYear,
											endDateMonth,
											endDateDay,
											daysOfWeek,
											startTimeHour,
											startTimeMinute,
											endTimeHour,
											endTimeMinute)
			# classInfo.courseSections.append(section)
		end
		#Adds the ClassesObject to the output array
		#classInfoArray.append(classInfo)	
	end	
	
	#puts parseMain
	#puts classInfoArray.length
#return classInfoArray
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
#temp = 
scrapeWebsite("col", "1214", "cse") #NOTE: All 3 arguments must be strings!!
#temp.each do |course|
#	puts course.courseName
#end
#addToModel(temp)

#puts "Class Number: " + temp[1].courseName
#puts "Class Name: " + temp[1].courseTitle
#puts "Class Description: " + temp[1].description
#puts temp[1].courseSections.length
#numberOfSections can be used to run a for loop for each individualSection
#puts temp[1].courseSections[0].sectionNumber
#puts temp[1].courseSections[0].year
#puts temp[1].courseSections[0].term
#puts temp[1].courseSections[0].instructor
#puts temp[1].courseSections[0].time
#puts temp[1].courseSections[0].days
#puts temp[1].courseSections[0].building
#puts temp[1].courseSections[0].room






