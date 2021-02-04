#Create Board object, check potential sets in the inUseCard.

class Board

  #print the in used cards
  def printCurrentCards()
    puts Deck.inUseCards
  end

  #method used to determine if any set exists, if not draw three more cards
  def containSet(inUseCards)
    @indicator = false
    @indexOne = 0
    while index < inUseCards.length && indicator!
      @cardOne = inUseCards[indexOne]
      @indexTwo = indexOne + 1
      while indexTwo < inUseCards.length && indicator!
        @cardTwo = inUseCards[indexTwo]
        @indexThree = indexTwo + 1
        while indexThree < inUseCards.length && indicator!
          @cardThree = inUseCards[indexThree]
          indicator = isSet(cardOne,cardTwo,cardThree)
          if (indicator!)
            indexThree += 1
          end
        end
        if (indicator!)
          indexTwo += 1
        end
      end
      if (indicator!)
        indexOne += 1
      end
    end

    if (indicator!) #if indicator shows that we do not have a set
      Deck.inUseCards.get(3)
    end



