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

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

class Deck

  attr_reader :cards

  RANKS = ['A','2','3','4','5','6','7','8','9','10','J','K','Q']
  SUITS = ['hearts', 'spades', 'diamonds', 'clubs']

    def initialize
      @cards = []
      RANKS.each do |rank|
        SUITS.each do |suit|
          @cards << ([ rank , suit ])
        end
      end
    end

    def count
      @cards.count
    end

    def deal(int, player)
      timesz = int
        timesz.times do
          card = @cards.pop
          player.cards.push(card)
        end
      end

    def return(card)
      @cards << (card)
    end

    def shuffle
      5.times do
        @cards.shuffle!
      end
    end

    def discard(discardPile)
      card = @cards.pop
        discardPile.push(card)
    end
end

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

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

  def validate_play(card)
  end
end

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

class Game

  attr_reader :players
  attr_accessor :pile
  attr_accessor :deck
  attr_accessor :turn

  def initialize
    @deck = Deck.new
    @pile = DiscardPile.new
    @players = []
    @turn = nil
    @counter = 0
  end

  def start
    puts "Welcome To Crazy Eights"
    puts "======================="
    how_many_players
  end

  def how_many_players
    puts "How many players will be playing?"
    number = gets.chomp.to_i
    how_many_times(number)
  end

  def how_many_times(number)
    number.times do
      define_player
    end
  end

  def define_player
    puts "What is your name?"
    name = gets.chomp.to_s
    make_player(name)
  end

  def make_player(name)
    @players << Player.new(name)
  end

  def start_game
      until @players[0].cards.length == 0 || @players[1].cards.length == 0
          if @counter % 2 === 0
            @players[0].any_play?(@pile, @deck)
            @counter += 1
          elsif @counter % 2 != 0
            @players[1].any_play?(@pile, @deck)
            @counter += 1
          end
      end
      puts "Game Over"
  end

end
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

game = Game.new
game.start

# Create The Deck
puts "Making deck..."
puts "Shuffling the deck..."
game.deck.shuffle

# Deal The Cards
puts "Dealing the cards..."
game.players.each { |player|
  game.deck.deal(8, player)
}

# Create The Pile
game.deck.discard(game.pile.cards)
game.pile.top_card

game.start_game

Pry.start(binding)
