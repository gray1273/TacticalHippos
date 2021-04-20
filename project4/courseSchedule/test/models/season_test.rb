require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  def test_uniqueness
  	Season.find_or_create_by(:title => "Autumn")
  	Season.find_or_create_by(:title => "Autumn")
  	Season.find_or_create_by(:title => "Winter")
  	Season.find_or_create_by(:title => "Autumn")

  	assert_equal 2, Season.count
  end
end
