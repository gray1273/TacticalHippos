require 'test_helper'

# https://stackoverflow.com/questions/4415305/basic-rails-question-how-to-create-a-new-entry-in-database
class UserTest < ActiveSupport::TestCase
	def test_user_type_to_user
		# assert_equal 0, User.count
		# assert_equal 0, UserType.count

		testUser = User.create(:first_name => "TestFn1", :last_name => "TestLn1", :email => "test1@test.com")
		testUserType = UserType.create(:title_string => "Student")
		testUser.user_type_id = testUserType.id
		testUser.save
		testUserType.save

		# assert_equal 1, User.count
		# assert_equal 1, UserType.count

		assert_equal testUserType.id, testUser.user_type_id
	end
end
