#! /usr/bin/env ruby

class Game
  attr_reader :board
  
  def initialize(board, player_one, player_two)
    @board = board
    @player_one = player_one
    @player_two = player_two
    @current_player = @player_one
    @player_collection = [@player_one, @player_two]
  end

  def next_move
    @board.set_position(@current_player.get_move, @current_player.letter)
  end
  
  def toggle_players
    @current_player = (@player_collection - [@current_player]).shift
  end
end

class WebOutput
  def display(board)
    board.display_board
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
      @game = Game.new(@board, @player_one, Player.new(ComputerMover.new(@board, @player_one), "O"), ConsoleOutput.new)
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