require 'test_helper'

# https://stackoverflow.com/questions/4415305/basic-rails-question-how-to-create-a-new-entry-in-database
class UserTest < ActiveSupport::TestCase
	def test_nested_params
		testUser = User.find_or_create_by(
			:user_type => UserType.find_or_create_by(
				:title => "Student"
			), 
			:first_name => "fn1", 
			:last_name => "ln1", 
			:email => "e1@email.com"
		)

		assert_equal "Student", testUser.user_type.title
		assert_equal "fn1", testUser.first_name
		assert_equal "ln1", testUser.last_name
		assert_equal "e1@email.com", testUser.email
	end
	def test_unique_combinations
		User.find_or_create_by(
			:user_type => UserType.find_or_create_by(
				:title => "Student"
			), 
			:first_name => "sfn1", 
			:last_name => "sln1", 
			:email => "s1@email.com"
		)
		User.find_or_create_by(
			:user_type => UserType.find_or_create_by(
				:title => "Student"
			), 
			:first_name => "sfn2", 
			:last_name => "sln2", 
			:email => "s2@email.com"
		)
		User.find_or_create_by(
			:user_type => UserType.find_or_create_by(
				:title => "Instructor"
			), 
			:first_name => "ifn1", 
			:last_name => "iln1", 
			:email => "i1@email.com"
		)

		#assert_equal 3, User.count
		assert_equal 2, UserType.count
	end
end
