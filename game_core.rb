require_relative 'players'
require_relative 'player'
require_relative 'dealer'
require_relative 'card'
require_relative 'deck'
require_relative 'game_view'

class GameCore
  attr_accessor :player, :dealer, :deck

  PLAYER_STEPS = { '1' => :player_miss, '2' => :player_take_card, '3' => :open_cards }.freeze

  def initialize(answer)
    @player = Player.new(answer)
    @dealer = Dealer.new('Dealer')
    @deck = Deck.new
  end

  def start_game
    add_start_cards(deck)
    take_start_bets
  end

  def player_miss
    return if dealer.score > 17 || dealer.cards.length == 3

    give_card(dealer)
  end

  def open_cards
    draw_result
    dealer_win? ? dealer_win_result : player_win_result
  end

  def give_card(player)
    player.take_card(deck)
    raise "Points exceeded, Player: #{player.name} lose, Points: #{player.score})" if player.score > 21

    player_miss
  end

  def max_cards?
    dealer.cards.length == 3 && player.cards.length == 3
  end

  def continue?(answer)
    return true if ['yes', '+', 'y', 'да', 'д'].include?(answer)

    false if ['no', '-', 'n', 'нет', 'н'].include?(answer)
  end

  def draw_result
    return unless draw?

    return_start_bets
    raise 'Draw'
  end

  def new_game
    refresh_game
    player.money = 100
    dealer.money = 100
  end

  def refresh_game
    refresh_players
    add_start_cards(deck)
    take_start_bets
  end

  def draw?
    dealer.score == player.score
  end

  def player_win_result
    player.take_bet
    raise 'You win, Congratz)'
  end

  def dealer_win_result
    dealer.take_bet
    raise 'Dealer win'
  end

  def dealer_win?
    21 - dealer.score < 21 - player.score
  end

  def refresh_players
    @player.cards = []
    @dealer.cards = []
    @player.score = 0
    @dealer.score = 0
    @deck = Deck.new
  end

  def add_start_cards(deck)
    player.take_start_cards(deck)
    dealer.take_start_cards(deck)
  end

  def take_start_bets
    player.add_bet
    dealer.add_bet
  end

  def return_start_bets
    player.return_bet
    dealer.return_bet
  end

  def make_choice(answer, *player)
    send PLAYER_STEPS[answer], player if answer == '2'
    send PLAYER_STEPS[answer]
  end

  def over?
    player.money.zero? || player.money.negative? || dealer.money.zero? || dealer.money.negative?
  end
end
