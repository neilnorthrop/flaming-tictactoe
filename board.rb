#! /usr/bin/env ruby
require 'pp'

class Board
  attr_accessor :board, :board_dimension, :winning_positions

  def initialize
    @board_dimension = 3
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @winning_positions = [[1, 2, 3],[4, 5, 6],[7, 8, 9],[1, 4, 7],[2, 5, 8],[3, 6, 9],[1, 5, 9],[3, 5, 7]]
  end

  def set_position(position, letter)
    (valid_position(position) && position_empty(position)) ? (@board[find_index(position)] = letter) ? true : false : false
    # if valid_position(position) && position_empty(position)
    #   @board[find_index(position)] = letter
    # else 
    #   false 
    # end
  end

  def valid_position(position)
    position > 0 && position <= @board.size
  end

  def find_index(position)
    position - 1
  end

  def player_moves
    moves("X")
  end

  def computer_moves
    moves("O")
  end

  def check_game
    winning_positions.each do |row|
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

  def set_at_index(index, letter)
    if board[index] =~ /X|O/
      return false
    end
    board[index] = letter
  end

  def check_position(position, letter)
    board.find_index(position) != nil
  end

  def move_does_not_contain(index, letter)
    board[index] != letter
  end

  def moves(letter)
    moves = []
    board.each.with_index { |v,k| moves << k + 1 if v == letter }
    return moves.sort
  end

  def tally_moves_remaining
    moves_remaining = []
    @board.each do |position|
      if position != "X" && position != "O"
        moves_remaining << position
      end
    end
    return moves_remaining
  end

  def position_empty(position)
    @board[find_index(position)] != "X" && @board[find_index(position)] != "O"
  end
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  print `clear`

  class TestBoard < MiniTest::Unit::TestCase

    def setup
      @board = Board.new
    end

    def test_building_board_class
      assert @board
    end

    def test_game_class_responds_to_board
      assert @board.board
    end

    def test_game_includes_default_size_board
      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9], @board.board
    end

    def test_game_is_a_draw
      @board.set_position(1, "X")
      @board.set_position(3, "X")
      @board.set_position(4, "X")
      @board.set_position(8, "X")
      @board.set_position(9, "X")
      @board.set_position(2, "O")
      @board.set_position(5, "O")
      @board.set_position(6, "O")
      @board.set_position(7, "O")
      assert_equal :draw, @board.check_game
    end

    def test_player_wins_with_full_game_board
      @board.set_position(1, "X")
      @board.set_position(6, "O")
      @board.set_position(7, "X")
      @board.set_position(8, "X")
      @board.set_position(9, "X")
      @board.set_position(2, "O")
      @board.set_position(3, "O")
      @board.set_position(4, "X")
      @board.set_position(5, "O")
      assert_equal :player, @board.check_game
    end

    def test_computer_wins_with_full_game_board
      @board.set_position(1, "X")
      @board.set_position(2, "X")
      @board.set_position(5, "X")
      @board.set_position(7, "X")
      @board.set_position(3, "O")
      @board.set_position(4, "O")
      @board.set_position(6, "O")
      @board.set_position(8, "O")
      @board.set_position(9, "O")
      assert_equal :computer, @board.check_game
    end

    def test_building_default_board_size
      assert_kind_of Array, @board.board
    end

    def test_setting_an_X_position_on_the_board
      @board.set_position(1, "X")
      assert_includes @board.board, "X"
    end

    def test_setting_an_O_position_on_the_board
      @board.set_position(1, "O")
      assert_includes @board.board, "O"
    end

    def test_setting_another_position_on_the_board
      @board.set_position(2,"X")
      @board.set_position(4,"X")
      assert_equal [1, "X", 3, "X", 5, 6, 7, 8, 9], @board.board
    end

    def test_setting_a_position_ontop_of_another_position
      @board.set_position(2,"X")
      assert_equal false, @board.set_position(2,"X")
    end

    def test_that_board_responds_to_display
      assert_respond_to @board, :display, "#{@board} does not respond to display"
    end

    def test_that_board_checks_for_player_position_at_1
      @board.set_position(1, "X")
      assert_equal false, @board.check_position(1, "X")
    end

    def test_that_board_checks_for_player_position_at_2
      @board.set_position(1, "X")
      assert_equal true, @board.check_position(2, "X")
    end

    def test_setting_an_X_index_position
      @board.set_at_index(1, "X")
      assert_equal [1, "X", 3, 4, 5, 6, 7, 8, 9], @board.board
    end

    def test_setting_X_index_position_on_top_of_another_X
      @board.set_at_index(1, "X")
      assert_equal false, @board.set_at_index(1, "X")
    end

    def test_that_position_does_not_contain_an_X
      @board.set_position(1, "X")
      assert_equal true, @board.move_does_not_contain(9, "X")
    end

    def test_that_position_does_contain_an_X
      @board.set_position(1, "X")
      assert_equal false, @board.move_does_not_contain(0, "X")
    end
    
    def test_that_game_over_message_returns_default_message
      assert "GAME ISN'T OVER DUDE!", @board.game_over_message
    end
    
    def test_player_wins_three_in_a_row_across
      @board.set_position(1, "X")
      @board.set_position(2, "X")
      @board.set_position(3, "X")
      assert_equal :player, @board.check_game
    end
    
    def test_player_wins_three_in_a_row_down
      @board.set_position(1, "X")
      @board.set_position(4, "X")
      @board.set_position(7, "X")
      assert_equal :player, @board.check_game
    end
    
    def test_player_wins_three_in_a_row_diagonal
      @board.set_position(1, "X")
      @board.set_position(5, "X")
      @board.set_position(9, "X")
      assert_equal :player, @board.check_game
    end
    
    def test_computer_wins_three_in_a_row_across
      @board.set_position(1, "O")
      @board.set_position(2, "O")
      @board.set_position(3, "O")
      assert_equal :computer, @board.check_game
    end
    
    def test_computer_wins_three_in_a_row_down
      @board.set_position(1, "O")
      @board.set_position(4, "O")
      @board.set_position(7, "O")
      assert_equal :computer, @board.check_game
    end
    
    def test_computer_wins_three_in_a_row_diagonal
      @board.set_position(1, "O")
      @board.set_position(5, "O")
      @board.set_position(9, "O")
      assert_equal :computer, @board.check_game
    end
  end
end


__END__
