// Base methods to create and control cards


// Javascript Array has no built-in shuffle, found one here:
// https://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array
function shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
}

class DeckKernel {
	//Setup the board
	constructor(){
		this.baseCards = [];
		this.inUseCards = [];
		this.usedCards = [];
		this.reset();
	}
	//Reset the board on game restart
	reset(){
		this.baseCards = [];
		this.inUseCards = [];
		this.usedCards = [];
		for(let i = 0; i < 3; i++){
			for(let j = 0; j < 3; j++){
				for(let k = 0; k < 3; k++){
					for(let l = 0; l < 3; l++){
						this.baseCards.push(new Card(i, j, k, l));
					}
				}
			}
		}

		this.shuffle();
		this.get(12);
	}

	//Shuffles the baseCards
	shuffle() {
		shuffleArray(this.baseCards);
	}

	//Puts the card back into the list of remaining cards so the game never ends???
	putOnTop(cards){
		console.log("putOnTop Running...");
		cards.forEach(function(card, index, array){
			var pos = this.inUseCards.indexOf(card);
			this.inUseCards.splice(pos, 1);
			this.baseCards.push(card);
		});
	}
	//Removes the card from inUse, adds it to usedCards
	putBack(cards){
		console.log("putBack Length: ", this.inUseCards.length);
		for(let i = 0; i < cards.length; i++){
			var index = this.inUseCards.indexOf(cards[i]);
			var card = this.inUseCards[index]
			this.inUseCards.splice(index, 1);
			this.usedCards.push(card);
		}		
		console.log("putBack Length: ", this.inUseCards.length);
	}
	//Adds num cards to the inUseCards
	get(num){
		for(let i = 0; i < num; i++){
			this.inUseCards.push(this.baseCards.shift());
		}
		console.log("get Length: ", this.inUseCards.length);
	}
}
