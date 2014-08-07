#! /usr/bin/env ruby

class BoardGame
  attr_accessor :board, :winning_positions

  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @winning_positions = [[0, 1, 2],[3, 4, 5],[6, 7, 8],[0, 3, 6],[1, 4, 7],[2, 5, 8],[0, 4, 8],[2, 4, 6]]
  end

  def set_position(position, letter)
    if check_position(position, letter) == false
      return nil
    else
      set_at_index(board.find_index(position), letter)
    end
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

  def display_board
    return board
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
    board.each.with_index { |v,k| moves << k if v == letter }
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

  def position_empty(index, letter1, letter2)
    move_does_not_contain(index, letter1) && move_does_not_contain(index, letter2)
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

    def test_building_board_class
      assert BoardGame.new
    end

    def test_game_class_responds_to_board
      assert @test_game.display_board
    end

    def test_game_includes_default_size_board
      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9], @test_game.display_board
    end

    def test_game_is_a_draw
      @test_game.set_position(1, "X")
      @test_game.set_position(3, "X")
      @test_game.set_position(4, "X")
      @test_game.set_position(8, "X")
      @test_game.set_position(9, "X")
      @test_game.set_position(2, "O")
      @test_game.set_position(5, "O")
      @test_game.set_position(6, "O")
      @test_game.set_position(7, "O")
      assert_equal :draw, @test_game.check_game
    end

    def test_player_wins_with_full_game_board
      @test_game.set_position(1, "X")
      @test_game.set_position(6, "X")
      @test_game.set_position(7, "X")
      @test_game.set_position(8, "X")
      @test_game.set_position(9, "X")
      @test_game.set_position(2, "O")
      @test_game.set_position(3, "O")
      @test_game.set_position(4, "O")
      @test_game.set_position(5, "O")
      assert_equal :player, @test_game.check_game
    end

    def test_computer_wins_with_full_game_board
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(5, "X")
      @test_game.set_position(7, "X")
      @test_game.set_position(3, "O")
      @test_game.set_position(6, "O")
      @test_game.set_position(9, "O")
      assert_equal :computer, @test_game.check_game
    end

    def test_building_default_board_size
      assert_kind_of Array, @test_game.board
    end

    def test_setting_an_X_position_on_the_board
      @test_game.set_position(1, "X")
      assert_includes @test_game.board, "X"
    end

    def test_setting_an_O_position_on_the_board
      @test_game.set_position(1, "O")
      assert_includes @test_game.board, "O"
    end

    def test_setting_another_position_on_the_board
      @test_game.set_position(2,"X")
      @test_game.set_position(4,"X")
      assert_equal [1, "X", 3, "X", 5, 6, 7, 8, 9], @test_game.board
    end

    def test_setting_a_position_ontop_of_another_position
      @test_game.set_position(2,"X")
      assert_equal nil, @test_game.set_position(2,"X")
    end

    def test_that_board_responds_to_display
      assert_respond_to @test_game, :display, "#{@test_game} does not respond to display"
    end

    def test_that_board_checks_for_player_position_at_1
      @test_game.set_position(1, "X")
      assert_equal false, @test_game.check_position(1, "X")
    end

    def test_that_board_checks_for_player_position_at_2
      @test_game.set_position(1, "X")
      assert_equal true, @test_game.check_position(2, "X")
    end

    def test_setting_an_X_index_position
      @test_game.set_at_index(1, "X")
      assert_equal [1, "X", 3, 4, 5, 6, 7, 8, 9], @test_game.display_board
    end

    def test_setting_X_index_position_on_top_of_another_X
      @test_game.set_at_index(1, "X")
      assert_equal false, @test_game.set_at_index(1, "X")
    end

    def test_that_position_does_not_contain_an_X
      @test_game.set_position(1, "X")
      assert_equal true, @test_game.move_does_not_contain(9, "X")
    end

    def test_that_position_does_contain_an_X
      @test_game.set_position(1, "X")
      assert_equal false, @test_game.move_does_not_contain(0, "X")
    end
    
    def test_that_game_over_message_returns_default_message
      assert "GAME ISN'T OVER DUDE!", @test_game.game_over_message
    end
  end
end


__END__
