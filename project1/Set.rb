# Project 1

require './Runner.rb'
require './Board.rb'

#require_relative 'runner'
	runner = Runner.new
	board = Board.new
	#Waits until  s is pressed to start game
	def waitUntilStart
		require 'io/console'
        readChar = ' ';
        puts "Press 's' to start the game!"
		while (readChar != 's') do
			readChar = STDIN.getch
		end
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
    
    printRules()
    waitUntilStart()
    while(runner.waitUntilCallout())do end