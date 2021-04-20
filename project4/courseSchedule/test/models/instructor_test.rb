require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  def test_accessing_nested_data
  	testInstructor = Instructor.find_or_create_by(:first_name => "fn", :last_name => "ln")

  	assert_equal "fn", testInstructor.first_name
  	assert_equal "ln", testInstructor.last_name
  end
  def test_activeRecord
  	Instructor.find_or_create_by(:first_name => "fn", :last_name => "ln")

  	assert_equal 1, Instructor.count
  end
end
