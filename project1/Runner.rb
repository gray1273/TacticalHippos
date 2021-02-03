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
	#Waits until either q or p is pressed (the button that either player uses to call out a set)
	def waitUntilCallout
		# Source: https://stackoverflow.com/questions/39964008/read-a-single-char-from-stdin-without-pressing-enter/39967524
		require 'io/console'
		readChar = ' ';
		while (readChar != 'q' && readChar != 'p') do
			readChar = STDIN.getch
		end
		if(readChar == 'q')
			# stuff with p1 score
		else
			# stuff with p2 score
		end
	end
	# Gets input from the console of what set the player wants to input. Checks that set and increments if valid.
	# Inputs:
	# => player: true = p1, false = p2
	# => columns: # of columns being displayed on the board (4 to 6)
	def processCallout(player, columns)
		setString = ""
		invalidInput = true
		while invalidInput
			echo "Enter three card names separated by spaces, e.g. \"A1 B2 C3\""
			setString = gets
			setString.upcase
			cardStrings = setString.split
			cardStrings.each{ |s| 
				if ((s[0] == 'A' || s[0] == 'B' || s[0] == 'C') && (s[1].to_i <= columns)
					invalidInput = false
				end
			}
			if(invalidInput)
				echo "Invalid input. Try again."
			end
		end
		# CALL METHOD THAT CHECKS SET
		validSet = true
		if(validSet)
			if(player)
				@p1Score++
			else
				@p2Score++
			end
		else
			echo "Sorry, that is not a valid set."
		end
end
