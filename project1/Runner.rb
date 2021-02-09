require './Board.rb'

class Runner
	# Scores for each player
	@p1Score
	@p1Score
	@board
	#Constructor for class
	def initialize
		@p1Score = 0
		@p2Score = 0
		@board = Board.new
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
          #if no set exist in in use cards and we have more than three cards in base cards, draw three more from the base cards
          while(!@board.containSet && @board.deck.baseCards.length > 3)
                  @board.deck.get 3
                end
                # if we have no set in the board, and not enough cards in base cards, we just return false
          if (!@board.containSet && @board.deck.baseCards.length < 3)
                  puts "Game over! No set on the board and not enough cards to draw"
                  if @p1Score != @p2Score
                    puts"Player #{@p1Score > @p2Score ? 1 : 2} wins! Final score: #{@p1Score} to #{@p2Score}"
                  else
                    puts "It is a tie! Final Score: #{@p1Score} to #{@p2Score}"
                  end
                  return false
                end
		@board.printCurrentCards()
		printPlayerScores
		# Source: https://stackoverflow.com/questions/39964008/read-a-single-char-from-stdin-without-pressing-enter/39967524
		require 'io/console'
		readChar = ' ';
		puts "Press [z] for Player 1 or [m] for Player 2. Press [q] to quit."
		while (readChar != 'z' && readChar != 'm' && readChar != 'q') do
			readChar = STDIN.getch
		end
		if readChar != 'q' then
			processCallout(readChar == 'z')
		elsif @p1Score != @p2Score
			puts "Player #{@p1Score > @p2Score ? 1 : 2} wins! Final score: #{@p1Score} to #{@p2Score}"
		else
			puts "It's a tie! Final score: #{@p1Score} to #{@p2Score}"
		end
		return readChar != 'q'
	end

	# Gets input from the console of what set the player wants to input. Checks that set and increments if valid.
	# Inputs:
	# => player: true = p1, false = p2
	# => columns: # of columns being displayed on the board (4 to 6)
	def processCallout(player)
		set = @board.getCard(@board.getValidSetInput())
                valid = @board.checkSet(set[0], set[1], set[2])
                if (valid) then
                  @board.removeCards(set)
		  if (player) then
	            @p1Score += 1
		    puts "That is a correct set! Player 1 earns 1 point."
                  else
		    @p2Score += 1
		    puts "That is a correct set! Player 2 earns 1 point."
		  end
                else
                  puts "Sorry, that is not a valid set."
                end
	end
end
