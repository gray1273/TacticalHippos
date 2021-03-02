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

	constructor(){
		this.baseCards = [];
		this.inUseCards = [];
		this.usedCards = [];
		this.reset();
	}
	
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
	
	//
	shuffle() {
		shuffleArray(this.baseCards);
	}

	putOnTop(cards){
		cards.forEach(function(card, index, array){
			var pos = window.board.deck.inUseCards.indexOf(card);
			window.board.deck.inUseCards.splice(pos);
			window.board.deck.baseCards.push(card);
		});
	}
	
	putBack(cards){
		cards.forEach(function(card, index, array){
			var pos = this.inUseCards.indexOf(card);
			window.board.deck.inUseCards.splice(pos);
			window.board.deck.usedCards.push(card);
		})
	}
	
	get(num){
		for(let i = 0; i < num; i++){
			this.inUseCards.push(this.baseCards.shift());
		}
	}
}
