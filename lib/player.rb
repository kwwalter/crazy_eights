class Player

  attr_reader :player_name
  attr_accessor :cards

  def initialize player_name
        @player_name = player_name
        @cards = Array.new
  end

  def display_hand
    puts "===================="
      puts player_name + ": current hand"
        @cards.each do |card|
      puts "rank: " + card[0] + " suit: " + card[1]
    end
    puts "===================="
  end

  def any_play?(pile, deck)
      if deck.cards.length > 0
        @anyplays = nil
            puts "===================="
              puts "===================="
                puts player_name.capitalize + "'s turn"
              puts "Top card: " + pile.cards.last[0] + " : " + pile.cards.last[1]
            puts "Your current hand: " + @cards.length.to_s + " cards"
              puts "--------------------"
                @cards.each do |card|
                  puts "rank: " + card[0] + " suit: " + card[1]
                puts ""
            end

            puts "Possible plays..."
            puts "--------------------"
              @cards.each_with_index do |card, index|
            if card[0] === pile.cards.last[0] || card[1] === pile.cards.last[1]
                    puts "index: " + "#{index}" + " rank: " + card[0] + " suit: " + card[1]
                    @anyplays = true
                  end
                end

            if @anyplays === true
              choose_next_play(pile, deck)
            else
              draw_until_valid_play(pile, deck)
            end

      else
        # DOESNT WORK YET
        pile.cards.each do |x|
          deck.cards << x
            deck.shuffle
                # PRETTY SOON THE DECK HAS BEEN MADE, NEED TO BINDING DOT PRY TO CHECK.
              # STILL NEED TO DEFINE A NEW METHOD IN THE DECK CLASS TO REFRESH THE PILES CONTAINER
            deck.discard(pile)
          any_play?(pile, deck)
        end
      end
  end

  def choose_next_play(pile, deck)
    pile = pile
      puts "Choose your card based on index..."
        num = gets.chomp
      number = num.to_i
    play_card(number, pile, deck)
  end

  def play_card(number, pile, deck)
    pile = pile
        puts "===================="
          puts "You choose..."
        puts "rank: " + @cards[number][0] + " suit: " + @cards[number][1]
      pile.cards << @cards[number]
    @cards.delete_at(number)
    has_won?
  end

  def draw_until_valid_play(pile, deck)
    puts "===================="
        puts "No plays...gotta pull a card from the deck"
      deck.deal(1, self)
    any_play?(pile, deck)
  end

  def has_won?
      if @cards.length == 0
        puts "===================="
          puts @player_name + " wins!"
        puts "===================="
      else
        "Next player starts..."
    end
  end

end
