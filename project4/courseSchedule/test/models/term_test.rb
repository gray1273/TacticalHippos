require 'test_helper'

class TermTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def test_nested_params
  	testSeason = Season.new(:title => "Autumn")
  	testTerm = Term.create(:season => testSeason, :year => "2020")

  	assert_equal "Autumn", testTerm.season.title
  	assert_equal 2020, testTerm.year
  end
end
