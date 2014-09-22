#! /usr/bin/env ruby

class Game
  attr_accessor :board, :player_one, :player_two, :current_player
  
  def initialize(board, player_one, player_two)
    @board = board
    @player_one = player_one
    @player_two = player_two
    @current_player = current_player
  end
  
  def game_loop
    while true do
      set(@current_player.get_move, @current_player.letter)
      check_for_win
    end
  end
  
  def check_for_win
    @board.game_over_message if @board.game_over?
  end
  
  def set(position, letter)
    @board.set_position(position, letter)
  end
  
  def current_player
    [@player_one, @player_two].cycle { |current_player| return current_player }
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