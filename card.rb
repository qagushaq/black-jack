class Card
  attr_accessor :name, :suit, :score

  def initialize(name, suit, score)
    @name = name
    @suit = suit
    @score = score
  end

  NAMES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[♧ ♡ ♤ ♢].freeze

  def face
    name + suit
  end

  def ace?
    return if name.include?('A')
  end

end
