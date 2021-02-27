class Card{
  constructor(color, opacity, shape, number) {
  //Match a number given for color to a color
    if(color == 1)
    	this.color = "green";
    else if(color ==2)
    	this.color = "red";
    else
    	this.color = "purple";
  //Match an opacity number to an opacity
    if(opacity == 1){
	this.opacity = "open";
	this.opacityTag = "fas";
	}			
    else if(opacity == 2){
	this.opacity = "striped";
	this.opacityTag = "far";
	}		
    else{
	this.opacity = "solid";
	this.opacityTag = "far";
	}
			
  //Match a number given for shape to a shape
    if(shape == 1)
	this.shape = "square";
    else if(shape == 2)
	this.shape = "map";	
    else
	this.shape = "circle";
	
			
  //Number correlates directly to a number
    this.number = number;
  }
  //Accessor methods to get attributes from cards
  get get_color(){
  	return this.color;
  }
  get get_opacity(){
  	return this.opacity;
  }
  get get_shape(){
  	return this.shape;
  }
  get get_number(){
  	return this.number;
  }
  //Print the HTML code for each card given a row and column input
  printHTML(row, col){
  	var ret = "";
  	var i = 0;
  	//Add the header
  	ret += "<a href=\"#\" class=\"card col\">\n"
  	//If the card is not striped, print its attribute
  	if(this.opacity != "striped"){
  		for(i = 0; i < this.number; i++){
  			ret += "<i class=\"icon " + this.color+" "+ this.opacityTag +" fa-"+this.shape+" fa-2x\"></i>\n"
  		}
  	
  	}
  	//If the card is striped, print its attributes
  	else{
  		for(i = 0; i < this.number; i++){
  			ret += "<i class=\"icon " + this.color+" "+ this.opacityTag +" fa-"+this.shape+" fa-2x striped\"></i>\n"
  		}
  	}
  	//Add on the closing to the header
  	ret += "</a>"
  	return ret;
  }
}




                        
                    


/*Example on usage
var newCard = new Card(1,2,3,2);
var temp = newCard.printHTML(2,3);
console.log(temp); 
*/