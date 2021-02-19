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

	var baseCards, inUseCards, usedCards;


	constructor(){
		reset();
	}
	
	reset(){
		baseCards = [];
		inUseCards = [];
		usedCards = [];
		for(let i = 0; i < 3; i++){
			for(let j = 0; j < 3; j++){
				for(let k = 0; k < 3; k++){
					for(let l = 0; l < 3; l++){
						baseCards.push(new Card(i, j, k, l));
					}
				}
			}
		}
		
		shuffle();
		get(12);
	}
	
	//
	shuffle() {
		shuffleArray(baseCards);
	}
	
	putBack(cards){
		cards.forEach(function(card, index, array){
			var pos = inUseCards.indexOf(card);
			inUseCards.splice(pos);
			usedCards.push(card);
		})
	}
	
	get(var num){
		for(let i = 0; i < num; i++){
			inUseCards.push(baseCards.shift());
		}
	}
}
