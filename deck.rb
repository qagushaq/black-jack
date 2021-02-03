require_relative 'players'
require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    generate
  end

  def add_card
    card = @cards.sample
    @cards.delete(card)
    card
  end

  private

  def generate
    Card::NAMES.each do |name|
      Card::SUITS.each do |suit|
        score = add_score(name)
        card = Card.new(name, suit, score)
        @cards << card
      end
    end
    @cards.shuffle!
  end

  def add_score(name)
    return 10 if %w[J K Q].include?(name)
    return 11 if name == 'A'

    name.to_i
  end
end
