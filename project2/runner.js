this.board = new Board();

this.p1Score = 0;
this.p2Score = 0;
this.enabled = false;
this.p1Selected = false;
this.p2Selected = false;
this.selectedCardIndeces = [-1, -1, -1];
this.submitted = false;
this.isValidSet = false;

window.onload = function onLoad() {
	this.board.printBoard();
}

// Handling the button press for player 1
function player1ButtonPress(){
	this.p1Selected = true;
	this.p2Selected = true;
	//Enable cards
	this.enabled = true;
	//Wait until the submit function is called
	//https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises
	console.log("Player 1: waiting for submit.");
	waitForSubmit()
	.then(function(result){
		//Update Score
		if(this.p1Selected){
			console.log("Player 1: submitted.");
			if(this.isValidSet){
				this.p1Score++;
				//https://www.w3schools.com/js/js_htmldom_html.asp
				document.getElementById("player1Score").innerHTML = this.p1Score;
			}
			this.submitted = false;
			//Disable cards
		}
	});
}
// Handling the button press for player 2
function player2ButtonPress(){
	this.p2Selected = true
	this.p1Selected = false
	//Enable cards
	this.enabled = true;
	if(true){
		this.p2Score++;
		//https://www.w3schools.com/js/js_htmldom_html.asp
		document.getElementById("player2Score").innerHTML = this.p2Score;
	}
	//Disable cards
	//Wait until the submit function is called
	//https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises
	console.log("Player 2: waiting for submit.");
	waitForSubmit()
	.then(function(result){
		if(this.p2Selected){
			console.log("Player 2: submitted.");
			if(this.isValidSet){
				this.p2Score++;
				document.getElementById("player2Score").innerHTML = this.p2Score;
			}
			this.submitted = false;
			//Disable cards
		}
	});
}
//https://stackoverflow.com/questions/3635924/how-can-i-make-a-program-wait-for-a-variable-change-in-javascript
async function waitForSubmit(){
	while(!this.submitted){
		await new Promise(resolve => setTimeout(resolve, 1000));
	}
}
function cardHandler(row,col){
	if(this.enabled)
		selectCard(row,col);
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
			//https://developer.mozilla.org/en-US/docs/Web/API/Element/classList
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
				//https://developer.mozilla.org/en-US/docs/Web/API/Element/classList
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
		//https://developer.mozilla.org/en-US/docs/Web/API/Element/classList
		document.getElementById("submit-button").classList.remove("d-none");
	} else {
		//https://developer.mozilla.org/en-US/docs/Web/API/Element/classList
		document.getElementById("submit-button").classList.add("d-none");
	}
}

// Handling the press of the submit button
async function submitCards(){
	document.getElementById("submit-button").classList.add("d-none");
	var cards = [];
	for (var i = 0; i < this.selectedCardIndeces.length; i++) {
		console.log(this.selectedCardIndeces[i]);
		cards.push(this.board.deck.inUseCards[this.selectedCardIndeces[i]]);
		console.log(cards[i].get_number, cards[i].get_color, cards[i].get_opacity, cards[i].get_shape);
	}
	console.log(this.board.checkSet(cards[0], cards[1], cards[2]));
	this.isValidSet = this.board.checkSet(cards[0], cards[1], cards[2]);
	console.log(this.isValidSet ? "Valid" : "Invalid");
	this.selectedCardIndeces.forEach(function(item, index){
		//https://nickthecoder.wordpress.com/2013/02/11/integer-division-in-javascript/
		var id = "c"+Math.floor(item / this.board.columnCount())+Math.floor(item % this.board.columnCount());
		//https://developer.mozilla.org/en-US/docs/Web/API/Element/classList
		document.getElementById(id).classList.remove("border-info");
		if(this.isValidSet){
			document.getElementById(id).classList.add("border-success");
		} else {
			document.getElementById(id).classList.add("border-danger");
		}
	});
	// https://www.sitepoint.com/delay-sleep-pause-wait/
	await sleep(1000);
	this.selectedCardIndeces.forEach(function(item, index){
		//https://nickthecoder.wordpress.com/2013/02/11/integer-division-in-javascript/
		var id = "c"+Math.floor(item / this.board.columnCount())+Math.floor(item % this.board.columnCount());
		//https://developer.mozilla.org/en-US/docs/Web/API/Element/classList
		if(this.isValidSet){
			document.getElementById(id).classList.remove("border-success");
		} else {
			document.getElementById(id).classList.remove("border-danger");
		}
		document.getElementById(id).classList.remove("border");
		document.getElementById(id).classList.remove("rounded");
	});
	this.board.removeCards(cards);
	this.board.printBoard();
	if(!this.board.containSet()){
		//Game over, there are no sets remaining
		//We know because printBoard() calls prepareBoard() which draws sets until there's a set or no cards remain i.e. if it returns without a set, no cards remain
		var p1 = document.getElementById("player1Score");
		var p2 = document.getElementById("player2Score");
		p1.classList.add(".d-none");
		p2.classList.add(".d-none");
		var text
		if(this.p1Score > this.p2Score){
			text = "Player 1 has won!";
		} else if(this.p1Score == this.p2Score) {
			text = "There is a tie!";
		} else {
			text = "Player 2 has won!"
		}
		document.getElementById("board").innerHTML = "<p>" + text + "</p>";

	}
	this.selectedCardIndeces = [-1, -1, -1];
	console.log(this.isValidSet ? "Valid set found." : "Not a valid set.");
	this.enabled = false;
	this.submitted = true;
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
	return this.board.deck.inUseCards[index];
}

/*the function that prints all the card in use*/

function printAll(){
	var index = 0;
	var colNum = 1;
	var rowNum = 1;
	while(index < this.board.deck.inUseCards.length()){
		rowNum = 1;
		while (rowNum <= 3){
			this.board.deck.inUseCards[index].printHTML(rowNum, colNum);
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
		this.board.deck.get(3);
	}
	return true;
}
