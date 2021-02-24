class Card{
  constructor(color, opacity, shape, number) {
  //Match a number given for color to a color
    if(color == 1)
    	this.color = "Green";
    else if(color ==2)
    	this.color = "Red";
    else
    	this.color = "Purple";
  //Match an opacity number to an opacity
    if(opacity == 1)
	this.opacity = "Open"			
    else if(opacity == 2)
	this.opacity = "Striped"		
    else
	this.opacity = "Solid"
			
  //Match a number given for shape to a shape
    if(shape == 1)
	this.shape = "Diamond"
    else if(shape == 2)
	this.shape = "Squiggles"	
    else
	this.shape = "Circles"
			
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
}
/*
Example on usage
var newCard = new Card(2,3,2,3);
var temp = newCard.get_opacity
console.log(temp); 
*/
