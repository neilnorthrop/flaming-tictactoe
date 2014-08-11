#! /usr/bin/env ruby

class BoardGame
  attr_accessor :board
  
  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    @immutable_board = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
  end
  
  def display
    self.board
  end
  
  def set_position(position, letter)
    if valid_position(position)
      index = @board.find_index(position)
      @board[index] = letter
    else 
      false 
    end
  end
  
  def valid_position(position)
    @immutable_board.include?(position)
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
  end
end