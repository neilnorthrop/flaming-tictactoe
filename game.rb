#! /usr/bin/env ruby

class Game
  attr_accessor :board, :player_one, :player_two, :current_player, :player_collection
  
  def initialize(board, player_one, player_two)
    @board = board
    @player_one = player_one
    @player_two = player_two
    @current_player = @player_one
    @player_collection = [@player_one, @player_two]
  end
  
  def game_loop
    while !@board.game_over? do
      display_board
      puts current_player.inspect
      set(current_player.get_move, current_player.letter)
      check_for_win
      toggle_players
    end
  end
  
  def check_for_win
    puts @board.game_over_message and exit if @board.game_over?
  end
  
  def set(position, letter)
    @board.set_position(position, letter)
  end
  
  def toggle_players
    @current_player = (@player_collection - [@current_player]).shift
  end
  
  def display_board
    print `clear`
    board.display_board.map {|num| "%2s" % num }.each_slice(board.board_dimension) { |row| print row, "\n" }
  end
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  require './board.rb'
  require './player.rb'
  print `clear`
  
  class TestGame < MiniTest::Unit::TestCase
    
    def setup
      @board = Board.new
      @player_one = Player.new(ConsoleMover.new($stdin), "X")
      @game = Game.new(@board, @player_one, Player.new(ComputerMover.new(@board, @player_one), "O"))
    end
    
    # def test_that_say_passed_a_message_to_puts
    #   stubout = StubOut.new
    #   console = ConsoleMover.new(nil, stubout)
    #   console.say("Hello")
    #   assert_equal stubout.output, "Hello"
    # end
    # 
    # def test_that_get_move_keeps_asking_for_a_valid_move
    #   stubin = StubIn.new(["asdf", " ", "-1", "3"])
    #   stubout = StubOut.new
    #   console = ConsoleMover.new(stubin, stubout)
    #   assert_equal console.get_move(@board, "X", "O"), 3
    # end
    # 
    # def test_that_get_move_keeps_asking_until_an_empty_position_is_given
    #   @board.set_position 1, "X"
    #   stubin = StubIn.new(["1", "2"])
    #   stubout = StubOut.new
    #   console = ConsoleMover.new(stubin, stubout)
    #   assert_equal console.get_move(@board, "X", "O"), 2
    # end
  end
end

__END__


load "player.rb"
load "game.rb"
load "board.rb"
load "board4x4.rb"
load "computer_ai.rb"

player_one_letter = "X"
player_two_letter = "O"

board = Board.new
player_one = Player.new(ConsoleMover.new($stdin), player_one_letter)
player_two = Player.new(ComputerMover.new(board, player_one.letter), player_two_letter)
game = Game.new(board, player_one, player_two)