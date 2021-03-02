class Board {
    constructor() {
        this.deck = new DeckKernel();
        this.rowLength = 4;
        this.prepareBoard();
    }

    //Find some way to code analagous version of printCurrentCards(requires display of cards)
    printBoard(){
        this.prepareBoard();
    }

    // Get number of cards in board to 12, and add cards to board if there are no sets
    prepareBoard() {
        this.rowLength = 4;
        if(this.deck.inUseCards.length < 12){
            this.deck.get(12 - this.deck.inUseCards.length);
        } else if(this.deck.inUseCards.length > 12){
            this.deck.putOnTop(this.deck.inUseCards.slice(12));
        }
        if(!this.containSet()){
            this.deck.get(3);
            this.rowLength++;
        }
        if(!this.containSet()){
            this.deck.get(3);
            this.rowLength++;
        }
    }

    //method taking the card in use as an array(Deck.getCurrent)and used to determine if any set exists
    containSet() {
        let inUseCards = this.deck.inUseCards;
        //set the indicator as the boolean expression indicating is there a set or not
        let indicator = false;

        //begin the loop to loop through all combinations
        let indexOne = 0;
        while(indexOne < inUseCards.length && !indicator) {
            let cardOne = inUseCards[indexOne];
            let indexTwo = indexOne + 1;
            while(indexTwo < inUseCards.length && !indicator) {
                let cardTwo = inUseCards[indexTwo];
                let indexThree = indexTwo + 1;
                while(indexThree < inUseCards.length && !indicator) {
                    let cardThree = inUseCards[indexThree];
                    indicator = indicator || this.checkSet(cardOne, cardTwo, cardThree);
                    indexThree++;
                }
                indexTwo++;
            }
            indexOne++;
        }

        return indicator;
    }

    //the function that check to see if a given combination of cards is a set
    checkSet(a, b, c) {
        let indicator = true;
        if (!(((a.get_number == b.get_number) && (b.get_number == c.get_number))
            || ((a.get_number != b.get_number) && (a.get_number != c.get_number) && (b.get_number != c.get_number))))
          indicator = false

        if (!(((a.get_shape == b.get_shape) && (b.get_shape == c.get_shape)) 
            || ((a.get_shape != b.get_shape) && (a.get_shape != c.get_shape) && (b.get_shape != c.get_shape))))
          indicator = false

        if (!(((a.get_opacity == b.get_opacity) && (b.get_opacity == c.get_opacity))
            || ((a.get_opacity != b.get_opacity) && (a.get_opacity != c.get_opacity) && (b.get_opacity != c.get_opacity))))
          indicator = false

        if (!(((a.get_color == b.get_color) && (b.get_color == c.get_color))
            || ((a.get_color != b.get_color) && (a.get_color != c.get_color) && (b.get_color != c.get_color))))
          indicator = false

        if(a == b || a == c || b == c)
          indicator = false

        return indicator
    }

    //method used to match the string that the user entered with cards.
    getCard(inputStr) {
        let cardArray = inputStr.split(" ");

        let cardObj = this.deck.inUseCards;
        let rowLength = this.columnCount();

        let cards = [];

        for(let i = 0; i < 3; i++) {
            let temp = cardArray[i];
            cards[i] = cardObj[this.getIndex(parseInt(temp[0]), parseInt(temp[1]))];
        }

        return cards;
    }

    //the method that take the col number and row number then return the index in the array
    getIndex(rowNum, colNum) {
        return rowNum * this.rowLength + colNum;
    }

    columnCount() {
        return this.deck.inUseCards.length / 3;
    }

    getValidSetInput() {
        let setString = "";
        let validString = false;

        while(!validInput) {
            var validInput = true;
            let setString = prompt("Enter three card names seperated by spaces, e.g. \"A1 B2 C3\"");
            setString = setString.toUpperCase();
            let cardStrings = setString.split("");
            cardStrings.forEach(function(s) {
                if(!(s[0] == 'A' || s[0] == 'B' || s[0] == 'C') || !(parseInt(s[1]) < this.columnCount()))
                    validInput = false;
            });
            if(!validInput)
                console.log("Invalid input.");

            return setString;
        }
    }

    //Given 3 cards, removes them from the deck
    removeCards(array) {
        this.deck.putBack(array);
        if(this.deck.inUseCards.length < 12)
            this.deck.get(3);
    }
}
