# Project 1

require './Runner.rb'

#require_relative 'runner'
	runner = Runner.new
	#Waits until  s is pressed to start game
	def waitUntilStart
		require 'io/console'
        readChar = ' ';
        puts "Press 's' to start the game!"
		while (readChar != 's') do
			readChar = STDIN.getch
		end

		return Time.now
    end

    #Displays rules for game. ( https://en.wikipedia.org/wiki/Set_(card_game) )
    def printRules
        puts "\nRules:"
        puts "A set consists of three cards satisfying all of these conditions:"
        puts "They all have the same number or have three different numbers."
        puts "They all have the same shape or have three different shapes."
        puts "They all have the same shading or have three different shadings."
        puts "They all have the same color or have three different colors."
    end

		#Asks user for difficulty
		def getDifficulty
			puts "Would you like to make this game easy, medium, or hard?"
			puts "In easy mode, you have 5 minutes to get a set."
			puts "In medium mode, you have 3 minutes to get a set."
			puts "In hard mode, you have 1 minute to get a set."

			user_input = gets.chomp

			until ["easy", "medium", "hard"].include?(user_input.downcase) do
				puts "Please enter a valid difficulty."
				user_input = gets.chomp
			end

			return user_input.downcase
		end


    printRules()
		difficulty = getDifficulty()
    startTime = waitUntilStart()
    while(runner.waitUntilCallout(startTime, difficulty)) do end
