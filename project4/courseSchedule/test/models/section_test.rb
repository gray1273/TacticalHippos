require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  def test_accessing_nested_data
  	testSection = Section.find_or_create_by(
	  	:course => Course.find_or_create_by(
	  		:course_name => "CourseName",
	  		:title => "Title",
	  		:description => "This is a description"
  		),
  		:instructor => Instructor.find_or_create_by(
  			:first_name => "fn",
  			:last_name => "ln"
  		),
  		:section_type => SectionType.find_or_create_by(
  			:title => "Lecture"
  		), 
  		:term => Term.find_or_create_by(
  			:season => Season.find_or_create_by(
  				:title => "Autumn"
  			),
  			:year => 2021
  		),
  		:instruction_mode => InstructionMode.find_or_create_by(
  			:mode => "Distance Learning"
  		),
  		:location => Location.find_or_create_by(
  			:location => "Online"
  		),
  		:section_number => 0010,
  		:class_number => 12345,
  		:start_date => Date.new(2021,7,1),
  		:end_date => Date.new(2021,12,20),
  		:start_time => Time.new(1990,1,1,12,45,00,"+00:00"),
  		:end_time => Time.new(1990,1,1,14,05,00,"+00:00")
  	)

  	assert_equal "CourseName", testSection.course.course_name
  	assert_equal "Title", testSection.course.title
  	assert_equal "This is a description", testSection.course.description
  	assert_equal "fn", testSection.instructor.first_name
  	assert_equal "ln", testSection.instructor.last_name
  	assert_equal "Lecture", testSection.section_type.title
  	assert_equal "Autumn", testSection.term.season.title
  	assert_equal 2021, testSection.term.year
  	assert_equal "Distance Learning", testSection.instruction_mode.mode
  	assert_equal "Online", testSection.location.location
  	assert_equal 0010, testSection.section_number
  	assert_equal 12345, testSection.class_number
  	assert_equal 2021, testSection.start_date.year
  	assert_equal 7, testSection.start_date.month
  	assert_equal 1, testSection.start_date.day
  	assert_equal 2021, testSection.end_date.year
  	assert_equal 12, testSection.end_date.month
  	assert_equal 20, testSection.end_date.day
  	assert_equal 12, testSection.start_time.hour, testSection.start_time.inspect
  	assert_equal 45, testSection.start_time.min, testSection.start_time.inspect
  	assert_equal 14, testSection.end_time.hour, testSection.end_time.inspect
  	assert_equal 5, testSection.end_time.min, testSection.end_time.inspect
  end
  def test_activeRecord
  	course = Course.find_or_create_by(
  		:course_name => "CourseName",
  		:title => "Title",
  		:description => "This is a description"
  	)
  	assert_equal 1, Course.count
  	instructor = Instructor.find_or_create_by(
  		:first_name => "fn",
  		:last_name => "ln",
  	)
  	assert_equal 1, Instructor.count
  	section_type = SectionType.find_or_create_by(:title => "Lecture")
  	assert_equal 1, SectionType.count
  	season = Season.find_or_create_by(:title => "Autumn")
  	assert_equal 1, Season.count
  	term = Term.find_or_create_by(
		:season => season,
		:year => 2021
	)
  	assert_equal 1, Term.count
  	instruction_mode = InstructionMode.find_or_create_by(:mode => "Distance Learning")
  	assert_equal 1, InstructionMode.count
  	location = Location.find_or_create_by(:location => "Online")
  	assert_equal 1, Location.count
  	testSection = Section.find_or_create_by(
  		:course => course,
  		:instructor => instructor,
  		:section_type => section_type, 
  		:term => term,
  		:instruction_mode => instruction_mode,
  		:location => location,
  		:section_number => 0010,
  		:class_number => 12345,
  		:days_of_week => "MWF",
  		:start_date => Date.new(2021,7,1),
  		:end_date => Date.new(2021,12,20),
  		:start_time => Time.new(1990,1,1,12,45,00,"+00:00"),
  		:end_time => Time.new(1990,1,1,14,05,00,"+00:00")
  	)
  	assert_equal 1, Section.count
  end
  def test_createSafely
  	course = Course.find_or_create_by(
  		:course_name => "CourseName",
  		:title => "Title",
  		:description => "This is a description"
  	)
  	testSection = SectionsController.create_safely(course, 0010, 12345, "fn", "ln", "Lecture", "Autumn 2021", "Distance Learning", "Online", 2021, 7, 1, 2021, 12, 20, "MWF", 12, 45, 14, 5)

  	assert_equal "CourseName", testSection.course.course_name
  	assert_equal "Title", testSection.course.title
  	assert_equal "This is a description", testSection.course.description
  	assert_equal "fn", testSection.instructor.first_name
  	assert_equal "ln", testSection.instructor.last_name
  	assert_equal "Lecture", testSection.section_type.title
  	assert_equal "Autumn", testSection.term.season.title
  	assert_equal 2021, testSection.term.year
  	assert_equal "Distance Learning", testSection.instruction_mode.mode
  	assert_equal "Online", testSection.location.location
  	assert_equal 0010, testSection.section_number
  	assert_equal 12345, testSection.class_number
  	assert_equal 2021, testSection.start_date.year
  	assert_equal 7, testSection.start_date.month
  	assert_equal 1, testSection.start_date.day
  	assert_equal 2021, testSection.end_date.year
  	assert_equal 12, testSection.end_date.month
  	assert_equal 20, testSection.end_date.day
  	assert_equal "MWF", testSection.days_of_week
  	assert_equal 12, testSection.start_time.hour, testSection.start_time.inspect
  	assert_equal 45, testSection.start_time.min, testSection.start_time.inspect
  	assert_equal 14, testSection.end_time.hour, testSection.end_time.inspect
  	assert_equal 5, testSection.end_time.min, testSection.end_time.inspect

    assert_equal 1, Course.count
  	assert_equal 1, Instructor.count
  	assert_equal 1, SectionType.count
  	assert_equal 1, Term.count
  	assert_equal 1, Season.count
  	assert_equal 1, InstructionMode.count
  	assert_equal 1, Location.count
  	assert_equal 1, Section.count
  end
end
