require_relative 'players'

class Deck

  attr_accessor :cards

  CARDS_NAMES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  CARDS_SUITS = %w[+ <3 ^ <>].freeze

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
    CARDS_NAMES.each do |card_name|
      CARDS_SUITS.each do |card_suit|
        score = add_score(card_name)
        name = "#{card_name}#{card_suit}"
        card = Card.new(name, score)
        @cards << card
      end
    end
  end

  def add_score(card_name)
    return 10 if %w[J K Q].include?(card_name)
    return [1, 11] if card_name == 'A'

    card_name.to_i
  end
end
