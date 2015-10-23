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
