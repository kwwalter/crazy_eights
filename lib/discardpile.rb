class DiscardPile

  attr_accessor :cards

  def initialize
    @cards = []
  end

  def top_card
    puts "===================="
      puts "Alright, here's the top card"
        puts "rank: " + @cards.last[0] + " " + "suit: " + @cards.last[1]
      puts "===================="
  end
  
end
