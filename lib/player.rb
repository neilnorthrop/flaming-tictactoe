#! /usr/bin/env ruby
require_relative 'computer_ai'

class Player
  attr_accessor :mover, :letter
  
  def initialize(mover, letter)
    @mover = mover
    @letter = letter
  end
  
  def get_move(args={})
    @mover.get_move(args)
  end
end

class Mover
  def get_move(args)
    raise 'MAKE A METHOD!'
  end

  def requires_interaction?
    true
  end
end

class ConsoleMover < Mover
  def initialize(input)
    @input = input
  end
  
  def get_move(args={})
    @input.gets.chomp.to_i
  end
end

class ComputerMover < Mover
  def initialize(board, opponent)
    @board = board
    @opponent = opponent
  end
  
  def get_move(args={})
    ComputerAI.get_move(@board, "O", @opponent)
  end

  def requires_interaction?
    false
  end
end

class WebMover < Mover
  def get_move(args={})
    args[:player_move].to_i
  end
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  require_relative 'board'
  require_relative 'computer_ai'
  print `clear`
  
  class TestConsoleMover < MiniTest::Unit::TestCase
    def setup
      @board = Board.new
    end
    
    class StubIn
      attr_reader :input

      def initialize(input)
        @input = input
      end

      def gets
        @input.shift
      end
    end
    
    def test_that_listen_gets_integers_from_input
      stubin = StubIn.new(["4.3", "asdf", "5", "6\n", "092834\t"])
      console = ConsoleMover.new(stubin)
      assert_equal console.get_move, 4
      assert_equal console.get_move, 0
      assert_equal console.get_move, 5
      assert_equal console.get_move, 6
      assert_equal console.get_move, 92834
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