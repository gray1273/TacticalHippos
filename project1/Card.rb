#Create Card object, attributes, and instance methods to obtain the data
class Card
	# Source: https://www.rubyguides.com/2018/11/attr_accessor/
	attr_accessor :color, :opacity, :shape, :number
	def initialize(color,opacity,shape,number)
		#Take integer inputs and match them to a type
		#Match a number to a value for the color of the card
		if(color == 1)
			@color = "Green"
			@colorKey = 32
		elsif(color == 2)
			@color = "Red"
			@colorKey = 31
		else
			@color = "Purple"
			@colorKey = 35
		end
		#Match an integer to an opacity value
		
		if(opacity == 1)
			@opacity = "Open"
			@opacityOpen = 0
			@opacityClosed = 0
		elsif(opacity == 2)
			@opacity = "Striped"
			@opacityOpen = 3
			@opacityClosed = 23
		else
			@opacity = "Solid"
			@opacityOpen = 4
			@opacityClosed = 24
		end
		
		#Match an integer to a shape value
		if(shape == 1)
			@shape = "Diamond"
			@shapeChar = 'V'
		elsif(shape == 2)
			@shape = "Squiggles"
			@shapeChar = 'S'
		else
			@shape = "Circles"
			@shapeChar = 'O'
		end	
		#The number entered can just be used
		@number = number
	end
	
	#Create an ouput string with the card and its values
	def consoleString
		if(number == 1)
			"[\e[#{@opacityOpen}m\e[#{@colorKey}m  #{@shapeChar} \e[0m \e[#{@opacityClosed}m]"
		elsif(number == 2)
			"[\e[#{@opacityOpen}m\e[#{@colorKey}m#{@shapeChar} #{@shapeChar}  \e[0m\e[#{@opacityClosed}m]"
		else
			"[\e[#{@opacityOpen}m\e[#{@colorKey}m#{@shapeChar} #{@shapeChar} #{@shapeChar}\e[0m\e[#{@opacityClosed}m]"
		end
		
	#Color codes gotten from website at URL: https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal
	end
	
	
	#Accessor Instance Methods (Potentially useful for checking if set)
	def get_color
		@color
	end

	def get_opacity
		@opacity
	end
	
	def get_shape
		@shape
	end
	
	def get_number
		@number
	end
	
end
#Test code and examples on how to initialize and use instance methods 
#color, opacity, shape, number
#test = Card.new(3,1,2,2)
#puts test.consoleString


#puts test.get_color


#puts test.get_opacity

#puts test.get_shape


#puts test.get_number

