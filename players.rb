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
        add_ace_score(card)
      else
        self.score += card.score
      end
    end
    score_with_ace
  end

  def add_name(name)
    self.name = name
  end

  private

  def score_with_ace
    return if @ace_score.nil?

    @ace_score.each do |score|
      self.score += if self.score + score[1] <= 21
                      score[1]
                    else
                      score[0]
                    end
    end
    @ace_score = []
  end

  def add_ace_score(card)
    @ace_score ||= []
    @ace_score << card.score
  end
end
