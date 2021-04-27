require 'test_helper'

class TermTest < ActiveSupport::TestCase
  def test_nested_params
  	testTerm = Term.find_or_create_by(:season => Season.find_or_create_by(:title => "Autumn"), :year => "2020")

  	assert_equal "Autumn", testTerm.season.title
  	assert_equal 2020, testTerm.year
  end
  def test_unique_combinations
  	Term.find_or_create_by(:season => Season.find_or_create_by(:title => "Autumn"), :year => "2020")
  	Term.find_or_create_by(:season => Season.find_or_create_by(:title => "Autumn"), :year => "2021")
  	Term.find_or_create_by(:season => Season.find_or_create_by(:title => "Autumn"), :year => "2021")
  	Term.find_or_create_by(:season => Season.find_or_create_by(:title => "Winter"), :year => "2020")
  	Term.find_or_create_by(:season => Season.find_or_create_by(:title => "Winter"), :year => "2021")

  	assert_equal 4, Term.count, Term.all.map{|t| t.season.title + " " + t.year.to_s}.join("\n")
  end
end
