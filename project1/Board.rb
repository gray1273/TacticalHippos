#Create Board object, check potential sets in the inUseCard.

require './Deck.rb'

class Board

  @deck

  def initialize
    @deck = Deck.new
  end

  def deck
    @deck
  end

  #print the in used cards
  def printCurrentCards()
    @current = @deck.getCurrent()
    rowLength = columnCount()
    # Print Column headings
    print "     " # Extra spacing so it doesn't label the row headings with a column head
    rowLength.times { |i| print "---#{i.to_s}---" }
    puts "" #newline
    
    # Print the cards
    3.times { |i|
      print "#{(i+65).chr}:   "
      rowLength.times { |j|
        print @current[i * rowLength + j].consoleString
      }
      puts "" # Newline
    }
  end

  #method taking the card in use as an array(Deck.getCurrent)and used to determine if any set exists, if not draw three more cards
  def containSet()
    inUseCards = @deck.getCurrent()
    #set the indicator as the boolean expression indcating is there a set or not
    indicator = false
    
    #begin the loop to loop through all the combinations
    indexOne = 0
    while indexOne < inUseCards.length && indicator!
      cardOne = inUseCards[indexOne]
      indexTwo = indexOne + 1
      while indexTwo < inUseCards.length && indicator!
        cardTwo = inUseCards[indexTwo]
        indexThree = indexTwo + 1
        while indexThree < inUseCards.length && indicator!
          cardThree = inUseCards[indexThree]
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
      @deck.get(3)
    end
    return indicator
  end

#the function that check to see if a given combination of cards is a set
  def checkSet(a,b,c)
    indicator = true
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
    if(a == b || a == c || b == c)
      indicator = false
    end
    return indicator
  end

  #method used to match the string that the user entered with cards.
  def getCard (inputStr)
    #seperate three card notations using space
    cardArray = inputStr.split(' ')

    #get the col name and row number to get the index of the card in the inUseCards object
    cardObj = @deck.getCurrent()
    rowLength = columnCount()

    cards = Array.new 3

    for i in 0..2
      temp = cardArray[i]
      cards[i] = cardObj[getIndex(temp[0], temp[1].to_i, rowLength)]
    end

    #get three card objects and pass it to checkSet
    return cards
  end

  #the method that take the col number and row number then return the index in the array
  def getIndex(colNum,rowNum,rowLength)
    index = 0
    if(colNum == "A")
      index = rowNum
    elsif (colNum == "B")
      index = rowLength + rowNum
    else
      index = rowLength * 2 + rowNum
    end
    
    return index
  end
  def columnCount
    return @deck.getCurrent().length / 3
  end
  def getValidSetInput
    setString = ""
    validInput = false
    while !validInput do
      validInput = true
      puts "Enter three card names separated by spaces, e.g. \"A1 B2 C3\""
      setString = gets
      setString.upcase
      cardStrings = setString.split
      cardStrings.each{ |s| 
        if (!(s[0] == 'A' || s[0] == 'B' || s[0] == 'C') || !(s[1].to_i < columnCount())) then
          validInput = false
        end
      }
      if !validInput then
        puts "Invalid input. Try again."
      end
    end
    return setString
  end
  
  # Given 3 cards, removes them from the deck
  def removeCards(array)
    @deck.putBack array
    @deck.get 
  end
end
