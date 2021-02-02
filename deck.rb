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
    Card::CARDS_NAMES.each do |card_name|
      Card::CARDS_SUITS.each do |card_suit|
        score = add_score(card_name)
        card = Card.new(card_name, card_suit, score)
        @cards << card
      end
    end
    @cards.shuffle!
  end

  def add_score(card_name)
    return 10 if %w[J K Q].include?(card_name)
    return [1, 11] if card_name == 'A'

    card_name.to_i
  end
end
