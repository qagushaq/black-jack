require_relative 'players'
require_relative 'player'
require_relative 'dealer'
require_relative 'card'
require_relative 'deck'
require_relative 'game_core'

class GameView
  attr_accessor :game, :answer

  STEPS = { '1' => :miss_step, '2' => :add_card_step, '3' => :open_step }.freeze

  def initialize
    add_player_name_tip
    @game = GameCore.new(user_answer)
  end

  def start
    game.start_game
    menu
  end

  def menu
    new_game if game.over?
    open_step if game.max_cards?
    show_menu_table
    user_answer
    send STEPS[answer]
  rescue RuntimeError => e
    puts e.message
    user_answer
    return unless game.continue?(answer)

    game.new_game
    menu
  end

  def miss_step
    game.player_miss
    menu
  rescue RuntimeError => e
    puts e.message
    game.player.take_bet
    show_continue_tip
    user_answer
    return unless game.continue?(answer)

    game.refresh_game
    menu
  end

  def add_card_step
    game.give_card(game.player)
    show_player_card
    menu
  rescue RuntimeError => e
    puts e.message
    game.dealer.take_bet
    show_continue_tip
    user_answer
    return unless game.continue?(answer)

    game.refresh_game
    menu
  end

  def open_step
    show_all_cards
    game.open_cards
  rescue RuntimeError => e
    puts e.message
    show_continue_tip
    user_answer
    return unless game.continue?(answer)

    game.refresh_game
    menu
  end

  def new_game
    show_money_tip
    show_continue_tip
    user_answer
    return unless game.continue?(answer)

    game.new_game
    menu
  end

  private

  def add_player_name_tip
    puts 'Enter player name'
  end

  def show_menu_table
    show_player_table
    puts
    show_dealer_table
    puts
    show_next_step
  end

  def show_player_card
    puts "Added cart: #{game.player.cards[2].name}"
  end

  def show_all_cards
    puts '*****************************************'
    puts 'Your cards:'
    show_player_cards
    puts "Points: #{game.player.score}"
    puts
    puts "Dealer's Cards:"
    show_dealer_cards
    puts "Points: #{game.dealer.score}"
  end

  def show_continue_tip
    puts 'Continue?'
  end

  def show_player_table
    puts '*****************************************'
    puts "Player: #{game.player.name}
        Points: #{game.player.score}
        Money: #{game.player.money}
        Cards:"
    show_player_cards
  end

  def show_dealer_table
    puts
    puts "Player: Dealer
        Cards: ** ** #{'**' if game.dealer.cards.length == 3}
        Money: #{game.dealer.money}"
  end

  def show_next_step
    puts "1.Pass turn#{', 2.Add card,' if game.player.cards.length < 3} 3.Show cards"
  end

  def show_player_cards
    game.player.cards.each do |card|
      print "#{card.name}  "
    end
  end

  def show_dealer_cards
    game.dealer.cards.each do |card|
      print "#{card.name}  "
    end
  end

  def user_answer
    self.answer = gets.chomp
  end

  def show_money_tip
    puts 'You are out of money' if game.player.money.zero? || game.player.money.negative?
    puts 'The dealer ran out of money' if game.dealer.money.zero? || game.dealer.money.negative?
  end
end
