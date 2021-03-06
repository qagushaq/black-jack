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
    @total = 0
    cards.each do |card|
      @total += card.score
    end
    ace.times { @total -= 10 if @total > 21 }
    self.score = @total
  end

  def ace
    @cards.count { |card| card.name == 'A' }
  end

  def add_name(name)
    self.name = name
  end

  def faces
    faces = ''
    cards.each do |card|
      faces += "#{card.face} "
    end
    faces
  end
end
