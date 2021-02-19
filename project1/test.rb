# require './Deck.rb'

# d = Deck.new

#d.getCurrent.each{ |s| puts "#{s.get_color} #{s.get_opacity} #{s.get_shape} #{s.get_number}"}

require './Board.rb'

b = Board.new
puts b.getCard("A0 A1 A2")

# c.printCurrentCards()
# for i in "A".."C"
# 	for j in 0..3
# 		puts c.getIndex(i, j, 4)
# 	end
# end
# c.deck.getCurrent.each{ |s| puts "#{s.get_color} #{s.get_opacity} #{s.get_shape} #{s.get_number}"}
# a = b.deck.getCurrent()
# for i in 0..a.length-1
# 	puts "#{a[i].get_color},#{a[i].get_opacity},#{a[i].get_shape},#{a[i].get_number}"
# end

# a1 = b.deck.getCurrent.first(3)
# puts b.checkSet(a1[0], a1[1], a1[2])
# puts ""
# puts a1[0].get_number
# puts a1[1].get_number
# puts a1[2].get_number
# puts a1[0].get_number == a1[1].get_number
# puts a1[1].get_number == a1[2].get_number

# # for i in 0..2
# # 	puts c.deck.getCurrent[i].get_color
# # 	puts c.deck.getCurrent[i].get_opacity
# # 	puts c.deck.getCurrent[i].get_shape
# # 	puts c.deck.getCurrent[i].get_number
# # end

# require './Card.rb'

# a2 = [Card.new(0,0,0,0), Card.new(0,0,0,1), Card.new(0,0,0,2)]
# puts ""

# puts b.checkSet(a2[0], a2[1], a2[2])

# puts ""

# for i in 0..2
# 	puts a[i].get_color
# 	puts a[i].get_opacity
# 	puts a[i].get_shape
# 	puts a[i].get_number
# end