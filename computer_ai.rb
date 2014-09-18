#! /usr/bin/env ruby

class ComputerAI
	def self.get_move(board, me, opponent)
		board = board
		my_moves = board.moves(me)
		opponent_moves = board.moves(opponent)

		if opponent_moves.count == 1
	    opening_move(opponent_moves)
	  else
	    move = next_win_or_block(board, my_moves)
	    move = next_win_or_block(board, opponent_moves) if move == :none
	    move = blocking_fork(board, opponent_moves) if move == :none
	    move = board.tally_moves_remaining.sample if move == :none
	    return move
	  end
	end

  def self.opening_move(opponent_moves)
    !opponent_moves.include?(5) ? 5 : 1
  end

  def self.next_win_or_block(board, moves)
    results = board.winning_positions.select { |row| (row - moves).count == 1 }
    matches = results.flatten.select { |position| board.position_empty(position) }
    matches.shift || :none
  end

  def self.blocking_fork(board, opponent_moves)
    blockings = {
      [[1, 3, 6, 8]] => board.tally_moves_remaining.sample,
      [[1, 6, 7]] => 4,
      [[2, 4]] => 1,
      [[6, 8], [2, 6], [5, 9], [1, 6]] => 3,
      [[4, 8]] => 7,
      [[1, 9], [3, 7]] => 2,
      [[1, 8]] => 4
    }
    blockings.select do |moves, block| 
      moves.include?(opponent_moves)
    end.values.first || :none
  end
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  require './board.rb'
  print `clear`

  class TestComputerAI < MiniTest::Unit::TestCase
  	def setup
  		@board = Board.new
  		@me = "O"
  		@opponent = "X"
  	end

    def test_computer_turn_takes_the_win_down
      @board.set_position(1, "O")
      @board.set_position(4, "O")
      @board.set_position(2, "X")
      @board.set_position(3, "X")
      @board.set_position(6, "X")
      assert_equal 7, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_computer_turn_takes_the_win_across
      @board.set_position(1, "O")
      @board.set_position(2, "O")
      @board.set_position(4, "X")
      @board.set_position(7, "X")
      @board.set_position(6, "X")
      assert_equal 3, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_computer_turn_takes_the_win_diagonal
      @board.set_position(1, "X")
      @board.set_position(2, "X")
      @board.set_position(3, "O")
      @board.set_position(5, "O")
      @board.set_position(6, "X")
      assert_equal 7, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_computer_turn_blocks_players_fork
      @board.set_position(1, "X")
      @board.set_position(2, "X")
      @board.set_position(4, "X")
      @board.set_position(5, "O")
      @board.set_position(6, "O")
      assert_equal 3, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_computer_turn_blocks_players_positioning_for_a_top_left_fork
      @board.set_position(2, "X")
      @board.set_position(4, "X")
      @board.set_position(5, "O")
      assert_equal 1, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_computer_turn_blocks_players_positioning_for_a_top_right_fork
      @board.set_position(2, "X")
      @board.set_position(6, "X")
      @board.set_position(5, "O")
      assert_equal 3, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_computer_turn_blocks_players_positioning_for_a_bottom_left_fork
      @board.set_position(4, "X")
      @board.set_position(8, "X")
      @board.set_position(5, "O")
      assert_equal 7, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_computer_turn_blocks_players_positioning_for_a_bottom_right_fork
      @board.set_position(6, "X")
      @board.set_position(8, "X")
      @board.set_position(5, "O")
      assert_equal 3, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_edge_case_for_computer_block
      @board.set_position(1, "X")
      @board.set_position(6, "X")
      @board.set_position(7, "X")
      @board.set_position(3, "O")
      @board.set_position(5, "O")
      assert_equal 4, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_computer_turn_blocks_player_across
      @board.set_position(1, "X")
      @board.set_position(2, "X")
      assert_equal 3, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_computer_turn_blocks_player_down
      @board.set_position(1, "X")
      @board.set_position(4, "X")
      assert_equal 7, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_computer_turn_blocks_player_down_the_middle
      @board.set_position(1, "O")
      @board.set_position(2, "X")
      @board.set_position(3, "O")
      @board.set_position(5, "X")
      @board.set_position(7, "X")
      assert_equal 8, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_computer_turn_blocks_player_diagonal
      @board.set_position(5, "X")
      @board.set_position(1, "X")
      assert_equal 9, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_on_opening_computer_turn_takes_middle_if_open
      @board.set_position(1, "X")
      assert_equal 5, ComputerAI.new.get_move(@board, @me, @opponent)
    end

    def test_on_opening_computer_turn_takes_middle_outter_if_open
      @board.set_position(5, "X")
      assert_equal 1, ComputerAI.new.get_move(@board, @me, @opponent)
    end
  end

end