#Create Board object, check potential sets in the inUseCard.

class Board

  #print the in used cards
  def printCurrentCards()
    puts Deck.inUseCards
  end

  #method used to determine if any set exists, if not draw three more cards
  def containSet(inUseCards)
    
    #set the indicator as the boolean expression indcating is there a set or not
    @indicator = false
    
    #begin the loop to loop through all the combinations
    @indexOne = 0
    while index < inUseCards.length && indicator!
      @cardOne = inUseCards[indexOne]
      @indexTwo = indexOne + 1
      while indexTwo < inUseCards.length && indicator!
        @cardTwo = inUseCards[indexTwo]
        @indexThree = indexTwo + 1
        while indexThree < inUseCards.length && indicator!
          @cardThree = inUseCards[indexThree]
          indicator = checkSet(cardOne,cardTwo,cardThree)
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
    return indicator
  end

#the function that check to see if a given combination of cards is a set
  def checkSet(a,b,c)
    @indicator = true
    if (!((a.get_number == b.get_number) && (b.get_number == c.get_number) || (a.get_number != b.get_number) && (a.get_number != c.get_number) && (b.get_number != c.get_number))) 
      indicator = false
    end
    if (!((a.get_shape == b.get_shape) && (b.get_shape == c.get_shape) || (a.get_shape != b.get_shape) && (a.get_shape != c.get_shape) && (b.get_shape != c.get_shape))) 
      indicator = false
    end
    if (!((a.get_opacity == b.get_opacity) && (b.get_opacity == c.get_opacity) || (a.get_opacity != b.get_opacity) && (a.get_opacity != c.get_opacity) && (b.get_opacity != c.get_opacity))) 
      indicator = false
    end
    if (!((a.get_color == b.get_color) && (b.get_color == c.get_color) || (a.get_color != b.get_color) && (a.get_color != c.get_color) && (b.get_color != c.get_color))) 
      indicator = false
    end
    return indicator
  end
end