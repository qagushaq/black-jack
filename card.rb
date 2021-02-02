class Card
  attr_accessor :card_name, :card_suit, :score

  def initialize(card_name, card_suit, score)
    @card_name = card_name
    @card_suit = card_suit
    @score = score
  end

  CARDS_NAMES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  CARDS_SUITS = %w[♧ ♡ ♤ ♢].freeze

  def face
    face = "#{card_name}#{card_suit}"
  end

end
