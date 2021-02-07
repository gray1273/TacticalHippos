# Thompson.3623

class Runner
	# Scores for each player
	@p1Score
	@p1Score
	#Constructor for class
	def initialize
		@p1Score = 0
		@p2Score = 0
	end

	#Methods to get scores for each player
	def p1Score
		@p1Score
	end
	def p2Score
		@p2Score
	end
    def printPlayerScores
            puts "Player 1 Score: #{@p1Score.to_s}   Player 2 Score: #{@p2Score.to_s}"
    end
	#Waits until either z or m is pressed (the button that either player uses to call out a set) or q (to quit)
	def waitUntilCallout
		# Source: https://stackoverflow.com/questions/39964008/read-a-single-char-from-stdin-without-pressing-enter/39967524
		require 'io/console'
		readChar = ' ';
		puts "Press [z] for Player 1 or [m] for Player 2. Press [q] to quit."
		while (readChar != 'z' && readChar != 'm' && readChar != 'q') do
			readChar = STDIN.getch
		end
		if readChar != 'q' then
			processCallout(readChar == 'z', 4)
		end
		return readChar != 'q'
	end

	# Gets input from the console of what set the player wants to input. Checks that set and increments if valid.
	# Inputs:
	# => player: true = p1, false = p2
	# => columns: # of columns being displayed on the board (4 to 6)
	def processCallout(player, columns)
		setString = ""
		invalidInput = true
		while invalidInput do
			puts "Enter three card names separated by spaces, e.g. \"A1 B2 C3\""
			setString = gets
			setString.upcase
			cardStrings = setString.split
			cardStrings.each{ |s| 
				if ((s[0] == 'A' || s[0] == 'B' || s[0] == 'C') && (s[1].to_i <= columns)) then
					invalidInput = false
				end
			}
			if invalidInput then
				puts "Invalid input. Try again."
			end
		end
		# TODO: call method that checks set
		validSet = true
		if (validSet && player) then
			@p1Score += 1
		elsif (validSet)
			@p2Score += 1
		else
			puts "Sorry, that is not a valid set."
		end
	end
end
