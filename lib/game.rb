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
