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
	if (!Board.containSet() && Board.deck.baseCards.length < 3){
		return false;
	}
	while (!Board.containSet() && Board.deck.baseCards.length >= 3) {
		Board.deck.get(3);	
	}
	return true;
}
