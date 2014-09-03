#! /usr/bin/env ruby
require './computer_ai.rb'

class Player
  attr_accessor :letter, :mover
  
  def initialize(mover)
    @mover = mover
  end
  
  def get_move(board, player_one_moves, player_two_moves)
    @mover.get_move(board, player_one_moves, player_two_moves)
  end
end

class ConsoleMover
  def get_move(board, player_one_moves, player_two_moves)
  end
end

class ComputerMover
  def get_move(board, player_one_moves, player_two_moves)
    ComputerAI.new.get_move(board, player_one_moves, player_two_moves)
  end
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  require './board.rb'
  require './computer_ai.rb'
  print `clear`
  
  class TestPlayer < MiniTest::Unit::TestCase
    def setup
      @player = Player.new(ConsoleMover.new)
    end
    
    def test_player_creation
      assert @player
    end
    
    def test_player_responds_to_letter
      assert_respond_to @player, :letter
    end
    
    def test_player_responds_to_mover
      assert_respond_to @player, :mover
    end

    def test_console_mover_responds_to_method_get_move
      assert_respond_to @player, :get_move
    end
    
    def test_computer_mover_responds_to_method_get_move
      @player.mover = ComputerMover.new
      assert_respond_to @player, :get_move
    end
    
    def test_computer_mover_gives_move
      @player.mover = ComputerMover.new
      @board = Board.new
      @board.set_position(1, "O")
      @board.set_position(4, "O")
      @board.set_position(2, "X")
      @board.set_position(3, "X")
      @board.set_position(6, "X")
      assert_equal 7, @player.get_move(@board, "O", "X")
    end
  end
end