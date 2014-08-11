#! /usr/bin/env ruby
require 'pp'

class BoardGame
  attr_accessor :board, :winning_positions
  
  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    @immutable_board = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    @winning_positions = []
  end
  
  def display
    self.board
  end
  
  def set_position(position, letter)
    if valid_position(position) && position_empty?(position)
      @board[@board.find_index(position)] = letter
    else 
      false 
    end
  end
  
  def valid_position(position)
    @immutable_board.include?(position)
  end
  
  def check_position(position)
    @board[@immutable_board.find_index(position)] !~ /X|O/
  end
  
  def position_empty?(position)
    @board[@immutable_board.find_index(position)] != "X" && @board[@immutable_board.find_index(position)] != "O"
  end
  
  def moves(letter)
    moves_collected = []
    @board.each.with_index { |v,k| moves_collected << @immutable_board[k] if v == letter }
    return moves_collected
  end
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  print `clear`

  class TestBoard < MiniTest::Unit::TestCase

    def setup
      @test_game = BoardGame.new
    end
    
    def test_that_boardgame_constructs
      assert BoardGame.new
    end
    
    def test_that_boardgame_constructs_4x4_grid
      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], @test_game.board
    end
    
    def test_that_board_responds_to_calls
      assert @test_game.board
    end
    
    def test_that_board_will_display_to_ui
      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], @test_game.display
    end
    
    def test_that_board_will_respond_to_setting_position
      assert @test_game.set_position(1, "X")
    end
    
    def test_that_board_responds_to_checking_for_validity_of_move
      assert @test_game.valid_position(1)
    end
    
    def test_that_board_checks_for_validity_of_move
      assert @test_game.valid_position(3)
      assert @test_game.valid_position(15)
    end
    
    def test_that_board_refutes_invalid_position
      refute @test_game.valid_position(-1)
      refute @test_game.valid_position(17)
    end
    
    def test_that_board_sets_X_at_position_2
      @test_game.set_position(2, "X")
      assert_equal [1, "X", 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], @test_game.display
    end
    
    def test_that_board_responds_to_checks_position
      assert @test_game.check_position(1)
    end
    
    def test_that_board_checks_position
      assert @test_game.check_position(2)
    end
    
    def test_that_board_refutes_when_position_is_filled
      @test_game.set_position(1, "X")
      refute @test_game.check_position(1)
    end
    
    def test_that_board_refuses_move_on_another_move
      @test_game.set_position(1, "X")
      refute @test_game.set_position(1, "X")
    end
    
    def test_that_position_does_not_contain_an_X_or_O
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "O")
      assert @test_game.position_empty?(3)
    end
    
    def test_that_position_does_contain_an_X_or_O
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "O")
      refute @test_game.position_empty?(1)
      refute @test_game.position_empty?(2)
    end
    
    def test_that_board_gathers_moves_together
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "O")
      @test_game.set_position(3, "X")
      @test_game.set_position(4, "O")
      assert_equal [1, 3], @test_game.moves("X")
      assert_equal [2, 4], @test_game.moves("O")
    end
  end
end