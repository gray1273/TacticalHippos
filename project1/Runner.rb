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
	def waitUntilSetSeen
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
end
