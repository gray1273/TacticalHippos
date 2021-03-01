this.board = new Board();

this.p1Score = 0;
this.p2Score = 0;
this.selectedCardIndeces = [-1, -1, -1];

// Handling the button press for player 1
function player1ButtonPress(){
	//Get 3 cards from user presses
	//Run checkSet() on the 3 cards
	//Replace true with checkSet() call
	if(true){
		this.p1Score++;
		document.getElementById("player1Score").innerHTML = this.p1Score;
	}
}
// Handling the button press for player 2
function player2ButtonPress(){
	//Get 3 cards from user presses
	//Run checkSet() on the 3 cards
	//Replace true with checkSet() call
	if(true){
		this.p2Score++;
		document.getElementById("player2Score").innerHTML = this.p2Score;
	}
}
function selectCard(row, col){
	var foundCard = false;
	//Check if card has already been selected
	this.selectedCardIndeces.forEach(function(item, index){
		if(item == this.board.getIndex(row, col)){
			// Card has already been selected, so deselect it
			console.log("Card "+row+", "+col+" deselected.");
			//Change CSS for selected element
			document.getElementById("c"+row+col).classList.remove("border");
			document.getElementById("c"+row+col).classList.remove("border-info");
			document.getElementById("c"+row+col).classList.remove("rounded");
			//Do logic for selected card
			this.selectedCardIndeces[index] = -1;
			foundCard = true;
		}
	});
	//Check if there are open spots
	if(!foundCard){
		this.selectedCardIndeces.forEach(function(item, index){
			if(item == -1 && !foundCard) {
				//There is an empty spot for a card to fill, so select it
				console.log("Card "+row+", "+col+" selected.")
				//Change CSS for selected element
				document.getElementById("c"+row+col).classList.add("border");
				document.getElementById("c"+row+col).classList.add("border-info");
				document.getElementById("c"+row+col).classList.add("rounded");
				//Do logic for selected card
				this.selectedCardIndeces[index] = this.board.getIndex(row, col);
				foundCard = true;
			}
		});
	}
	//Otherwise do nothing with adding cards, since 3 cards are selected
	//Check if there are 3 cards selected
	var allSelected = true;
	this.selectedCardIndeces.forEach(function(item, index){
		if(item == -1){
			allSelected = false;
		}
	});
	if(allSelected){
		document.getElementById("submit-button").classList.remove("d-none");
	} else {
		document.getElementById("submit-button").classList.add("d-none");
	}
}

/*the function that takes the start time and difficulties then return the boolean showing whether the player finished on time or not*/

function timer(startTime, difficulty){
	var elapsedTime = new Date() - startTime;
	elapsedTime /= 1000;
	elapsedTime = Math.round(elapsedTime);
	var withinTime;
	if (difficuly == "easy"){
		withinTime = elapsedTime <= 300;
	}
	else if (difficulty == "medium"){
		withinTime = elapsedTime <= 180;
	}
	else {
		withinTime = elapsedTime < 60;
	}
	return withinTime;	
}

/*the function that takes the clolum number, row number, and row length then locate the card object*/

function locateCard(colNum, rowNum, rowLength){
	var index = (rowNum - 1) * rowLength + colNum;
	return DeckKernel.inUseCards[index];
}

/*the function that prints all the card in use*/

function printAll(){
	var index = 0;
	var colNum = 1;
	var rowNum = 1;
	while(index < DeckKernel.inUseCards.length()){
		rowNum = 1;
		while (rowNum <= 3){
			DeckKernel.inUseCards[index].printHTML(rowNum, colNum);
			rowNum += 1;
		}
		colNum += 1;
	}
}

/*the function that draw three more cards if there is no set on board and we got enough cards. If we dont have enough cards to draw from return false*/

function drawIfNoSet(){
	if (!this.board.containSet() && this.board.deck.baseCards.length < 3){
		return false;
	}
	while (!this.board.containSet() && this.board.deck.baseCards.length >= 3) {
		this.deck.get(3);	
	}
	return true;
}
