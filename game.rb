#! /usr/bin/env ruby
class Game
  attr_accessor :board, :player_one, :player_two
  
  def intialize(baord, player_one, player_two)
    @board = board
    @player_one = player_one
    @player_two = player_two
  end
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  require './board.rb'
  require './computer_ai.rb'
  print `clear`
  
  class TestGame < MiniTest::Unit::TestCase
    def setup
      @board = Board.new
    end
    
    def test_that_say_passed_a_message_to_puts
      stubout = StubOut.new
      console = ConsoleMover.new(nil, stubout)
      console.say("Hello")
      assert_equal stubout.output, "Hello"
    end
    
    def test_that_get_move_keeps_asking_for_a_valid_move
      stubin = StubIn.new(["asdf", " ", "-1", "3"])
      stubout = StubOut.new
      console = ConsoleMover.new(stubin, stubout)
      assert_equal console.get_move(@board, "X", "O"), 3
    end
    
    def test_that_get_move_keeps_asking_until_an_empty_position_is_given
      @board.set_position 1, "X"
      stubin = StubIn.new(["1", "2"])
      stubout = StubOut.new
      console = ConsoleMover.new(stubin, stubout)
      assert_equal console.get_move(@board, "X", "O"), 2
    end
  end
end