this.board = new Board();

this.p1Score = 0;
this.p2Score = 0;
this.selectedCardIndeces = [-1, -1, -1];
this.submitted = false;

function onLoad(){
	this.board.printBoard();
}

// Handling the button press for player 1
function player1ButtonPress(){
	//Enable cards
	var isValidSet = false;
	//Wait until the submit function is called
	console.log("Player 1: waiting for submit.");
	waitForSubmit();
	console.log("Player 1: submitted.");
	if(true){
		this.p1Score++;
		document.getElementById("player1Score").innerHTML = this.p1Score;
	}
	this.submitted = false;
	//Disable cards
}
// Handling the button press for player 2
function player2ButtonPress(){
	//Enable cards
	if(true){
		this.p2Score++;
		document.getElementById("player2Score").innerHTML = this.p2Score;
	}
	//Disable cards
}
async function waitForSubmit(){
	while(!this.submitted){
		await new Promise(resolve => setTimeout(resolve, 1000));
	}
}
// Handling the press of a card
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

// Handling the press of the submit button
async function submitCards(){
	document.getElementById("submit-button").classList.add("d-none");
	var cards = [];
	for (var i = 0; i < this.selectedCardIndeces.length; i++) {
		cards.push(this.board.deck.inUseCards[this.selectedCardIndeces[i]]);
	}
	var isValidSet = this.board.checkSet(cards[0], cards[1], cards[2]);
	this.selectedCardIndeces.forEach(function(item, index){
		var id = "c"+Math.floor(index / this.board.rowLength)+Math.floor(index % this.board.rowLength);
		document.getElementById(id).classList.remove("border-info");
		if(isValidSet){
			document.getElementById(id).classList.add("border-success");
		} else {
			document.getElementById(id).classList.add("border-danger");
		}
	});
	// https://www.sitepoint.com/delay-sleep-pause-wait/
	await sleep(1000);
	this.selectedCardIndeces.forEach(function(item, index){
		var id = "c"+Math.floor(index / this.board.rowLength)+Math.floor(index % this.board.rowLength);
		if(isValidSet){
			document.getElementById(id).classList.remove("border-success");
		} else {
			document.getElementById(id).classList.remove("border-danger");
		}
		document.getElementById(id).classList.remove("border");
		document.getElementById(id).classList.remove("rounded");
	});
	this.selectedCardIndeces = [-1, -1, -1];
	console.log(isValidSet ? "Valid set found." : "Not a valid set.");
	this.submitted = true;
	return isValidSet;
}

// https://www.sitepoint.com/delay-sleep-pause-wait/
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
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
