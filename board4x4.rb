#! /usr/bin/env ruby
require 'pp'

class Board4x4
  attr_accessor :board, :board_dimension, :winning_positions
  
  def initialize
    @board_dimension = 4
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    @winning_positions = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [4, 8, 12, 16], [1, 6, 11, 16], [4, 7, 10, 13]]
  end
  
  def display_board
    self.board
  end
  
  def set_position(position, letter)
    if valid_position(position) && position_empty(position)
      @board[find_index(position)] = letter
    else 
      false 
    end
  end
  
  def valid_position(position)
    position > 0 && position <= @board.size
  end
  
  def check_position(position)
    @board[find_index(position)] !~ /X|O/
  end
  
  def find_index(position)
    position - 1
  end
  
  def position_empty(position)
    @board[find_index(position)] != "X" && @board[find_index(position)] != "O"
  end
  
  def moves(letter)
    moves_collected = []
    @board.each.with_index { |v,k| moves_collected << k + 1 if v == letter }
    return moves_collected
  end
  
  def tally_moves_remaining
    moves_remaining = []
    @board.each { |position| moves_remaining << position if position !~ /X|O/ }
    return moves_remaining
  end
  
  def player_moves
    moves("X")
  end
  
  def computer_moves
    moves("O")
  end
  
  def check_game
    @winning_positions.each do |row|
      return :player if (row - player_moves).empty?
      return :computer if (row - computer_moves).empty?
    end
    return :draw if tally_moves_remaining.empty?
    return :nobody
  end
  
  def game_over?
    check_game != :nobody
  end

  def game_over_message
    case check_game
    when :player
      "PLAYER WON!"
    when :computer
      "COMPUTER WON!"
    when :draw
      "IT'S A DRAW!"
    when :nobody
      "GAME ISN'T OVER DUDE!"
    end
  end
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  print `clear`

  class TestBoard4x4 < MiniTest::Unit::TestCase

    def setup
      @test_game = Board4x4.new
    end
    
    def test_that_boardgame_constructs
      assert Board4x4.new
    end
    
    def test_that_boardgame_constructs_4x4_grid
      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], @test_game.board
    end
    
    def test_that_board_responds_to_calls
      assert @test_game.board
    end
    
    def test_that_board_will_display_to_ui
      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], @test_game.display_board
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
      assert_equal [1, "X", 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], @test_game.display_board
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
      assert @test_game.position_empty(3)
    end
    
    def test_that_position_does_contain_an_X_or_O
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "O")
      refute @test_game.position_empty(1)
      refute @test_game.position_empty(2)
    end
    
    def test_that_board_gathers_moves_together
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "O")
      @test_game.set_position(3, "X")
      @test_game.set_position(4, "O")
      assert_equal [1, 3], @test_game.moves("X")
      assert_equal [2, 4], @test_game.moves("O")
    end
    
    def test_that_board_tallies_moves_remaining
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "X")
      @test_game.set_position(4, "X")
      @test_game.set_position(5, "X")
      @test_game.set_position(6, "X")
      assert_equal [7, 8, 9, 10, 11, 12, 13, 14, 15, 16], @test_game.tally_moves_remaining
    end

    def test_player_moves_returns_all_moves_for_player_X
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "X")
      @test_game.set_position(4, "X")
      assert_equal [1, 2, 3, 4], @test_game.player_moves
    end

    def test_player_moves_returns_all_moves_for_player_O
      @test_game.set_position(1, "O")
      @test_game.set_position(2, "O")
      @test_game.set_position(3, "O")
      @test_game.set_position(4, "O")
      assert_equal [1, 2, 3, 4], @test_game.computer_moves
    end
    
    def test_board_responds_to_check_game
      assert_equal :nobody, @test_game.check_game
    end
    
    def test_that_check_game_returns_player_x_symbol_when_player_X_wins_across
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "X")
      @test_game.set_position(4, "X")
      assert_equal :player_x, @test_game.check_game
    end
    
    def test_that_check_game_returns_player_o_symbol_when_player_O_wins
      @test_game.set_position(1, "O")
      @test_game.set_position(2, "O")
      @test_game.set_position(3, "O")
      @test_game.set_position(4, "O")
      assert_equal :player_o, @test_game.check_game
    end
    
    def test_that_check_game_returns_draw_symbol_when_nobody_wins
      @test_game.board = ["X", "O", "X", "O", "O", "X", "O", "X", "O", "X", "O", "X", "X", "O", "X", "O"]
      assert_equal :draw, @test_game.check_game
    end
    
    def test_that_game_over_returns_false_if_no_player_wins
      refute @test_game.game_over?
    end
    
    def test_that_game_over_returns_true_if_a_player_O_wins_across
      @test_game.set_position(1, "O")
      @test_game.set_position(2, "O")
      @test_game.set_position(3, "O")
      @test_game.set_position(4, "O")
      assert @test_game.game_over?
    end
    
    def test_that_game_over_returns_true_if_a_player_X_wins_across
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "X")
      @test_game.set_position(4, "X")
      assert @test_game.game_over?
    end
    
    def test_that_check_game_returns_player_x_symbol_when_player_X_wins_down
      @test_game.set_position(1, "X")
      @test_game.set_position(5, "X")
      @test_game.set_position(9, "X")
      @test_game.set_position(13, "X")
      assert_equal :player_x, @test_game.check_game
    end
    
    def test_that_check_game_returns_player_x_symbol_when_player_X_wins_diagonal
      @test_game.set_position(1, "X")
      @test_game.set_position(6, "X")
      @test_game.set_position(11, "X")
      @test_game.set_position(16, "X")
      assert_equal :player_x, @test_game.check_game
    end
    
    def test_that_check_game_returns_player_x_symbol_when_player_X_wins_diagonal
      @test_game.set_position(4, "X")
      @test_game.set_position(7, "X")
      @test_game.set_position(10, "X")
      @test_game.set_position(13, "X")
      assert_equal :player_x, @test_game.check_game
    end
    
    def test_that_valid_position_returns_false_when_moved_on_a_filled_position
      @test_game.set_position(1, "X")
      assert @test_game.valid_position(1)
    end
  end
end