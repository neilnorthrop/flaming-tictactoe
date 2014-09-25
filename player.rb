#! /usr/bin/env ruby
require './computer_ai.rb'

class Player
  attr_accessor :mover, :letter
  
  def initialize(mover, letter)
    @mover = mover
    @letter = letter
  end
  
  def get_move
    @mover.get_move
  end
end

class ConsoleMover
  def initialize(input)
    @input = input
  end
  
  def get_move
    @input.gets.chomp.to_i
  end
end

class ComputerMover
  def initialize(board, opponent)
    @board = board
    @opponent = opponent
  end
  
  def get_move
    ComputerAI.get_move(@board, @letter, @opponent)
  end
end

class WebMover
  def get_move
    params[:player_move]
  end
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  require './board.rb'
  require './computer_ai.rb'
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