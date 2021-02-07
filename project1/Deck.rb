# Controls a card deck for the game of Set.

require './Card.rb'

class Deck
  
  baseCards = Array.new
  inUseCards = Array.new
  usedCards = Array.new
  
  # Create the base Set deck
  def initialize()
    3.times { |i| 3.times { |j| 3.times { |k| 3.times { |l|
      baseCards.push Card.new i, j, k, l
    }}}}

    shuffle
    get 12
  end

  # Resets the class to the same state as initialization
  def reset()
    baseCards = baseCards + inUseCards + usedCards
    shuffle
    inUseCards = Array.new
    usedCards = Array.new
  end
  
  # Shuffles baseCards (The whole deck, or remaining unseen cards)
  def shuffle
    baseCards.shuffle
  end

  # Removes cards from in-use
  # @param *cards: Variable argument, pass each card as a separate parameter
  def putBack(*cards)
    inUseCards = inUseCards - cards
    usedCards = usedCards + cards
  end
  
  # Adds a specified number of cards to the in-use
  # @param count How many cards
  # @return The cards removed
  def get(count = 3)
    cards = baseCards[0, count]
    inUseCards.concat cards
    baseCards = baseCards - cards
    return cards
  end
  
  # Returns the cards that should be displayed on the screen
  def getCurrent()
    return inUseCards
  end

end

