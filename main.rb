require_relative 'lib/game.rb'
require_relative 'lib/player.rb'
require_relative 'lib/deck.rb'
require_relative 'lib/discardpile.rb'

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

# Start The Game
game.start_game

Pry.start(binding)
