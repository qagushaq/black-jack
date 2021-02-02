class Players
  attr_accessor :money, :cards, :score, :name

  def initialize(name)
    @money = 100
    @cards = []
    @score = 0
    @name = name.capitalize
  end

  def take_bet
    self.money += 20
  end

  def return_bet
    self.money += 10
  end

  def add_bet
    self.money -= 10
  end

  def take_card(deck)
    cards << deck.add_card
    calculate_score
    deck.cards.delete(cards)
  end

  def take_start_cards(deck)
    2.times { take_card(deck) }
  end

  def calculate_score
    self.score = 0
    cards.each do |card|
      if card.card_name.include?('A')
        self.score += card.score
        ace.times { self.score -= 10 if score > 21 }
      else
        self.score += card.score
      end
    end
    self.score
  end

  def ace
    @cards.count(&:ace?)
  end

  def add_name(name)
    self.name = name
  end

end
