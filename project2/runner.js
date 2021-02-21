/*Runner class that handles the process of the game*/



class Runner {
	var p1Score = 0;
	var p2Score = 0;
	var board = new Board();
	
	p1Score(){
		return p1Score;
	}
	
	p2Score(){
		return p2Score;
	}

	waitUntilCall(startTime, difficulty){
		while(!Board.containSet() && Board.DeckKernel.baseCards.length >= 3){
			Board.DeckKernel.get(3);
		}
		if (!Board.containSet() && Board.DeckKernel.baseCards.length < 3){
			alert("Game over! No set on the board and not enough cards to draw");
			if (p1Score > p2Score){
				alert("Player 1 wins! Final Score " + p1Score + " to " + p2Score);
			}
			else if (p1Score < p2Score){
				alert("Player 2 wins! Final Score " + p1Score + " to " + p2Score);
			}
			else{
				alert("It is a tie! Final Score: " + p1Score + " to " + p2Score);
			}
			return false;
		}
		var validInput = false;
		var readChar;
		while(!validInput){
			readChar = window.prompt("Press [z] for player 1 or [m] for player 2. Press [q] to quit.");
			validInput = true;
			if (readChar != 'z' && readChar != 'm' && readChar != 'q'){
				alert("Invalid input! Please Enter again!");
				validInput = false;
			}
		}
		elapsedTime = new Date() - startTime;
		elapsedTime /= 1000;
		elapsedTime = Math.round(elapsedTime);
		var difficulty, withinTime;
		if (difficuly == "easy"){
			withinTime = elapsedTime <= 300;
		}
		else if (difficulty == "medium"){
			withinTime = elapsedTime <= 180;
		}
		else {
			withinTime = elapsedTime < 60;
		}
		if (readChar != 'q'){
			processCallout (readChar == 'z');
		}
		else if (p1Score != p2Score){
			if (p1Score > p2Score){
				alert("Player 1 wins! Final Score " + p1Score + " to " + p2Score);
			}
			else (p1Score < p2Score){
				alert("Player 2 wins! Final Score " + p1Score + " to " + p2Score);
			}
			if (withinTime){
				alert("You also completed within time!");
			}
			else{
				alert("Unfortunately, you could not complete withinin time");
			}
			alert("You took " + elapsedTime + " seconds.");
		}
			else{
				alert("It is a tie! Final Score: " + p1Score + " to " + p2Score);
			}
		return readChar != 'q';

	}
}

