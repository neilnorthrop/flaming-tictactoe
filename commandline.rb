#! /usr/bin/env ruby
require 'pp'
require './lib/player.rb'
require './lib/game.rb'
require './lib/board.rb'
require './lib/board4x4.rb'
require './lib/computer_ai.rb'

def enter_game
  board_size
  setup_players
  build_game
  game_loop
end

def board_size
  print `clear` + <<-EOF
What size of board do you want to play?
1 - 3x3
2 - 4x4
EOF
  response = gets.chomp.to_i
  if response == 1
    @board = Board.new
  elsif response == 2
    @board = Board4x4.new
  else
    board_size
  end
end

def setup_players
  @player_one = Player.new(ConsoleMover.new($stdin), 'X')
  print `clear` + <<-EOF
Do you want to play a computer or player?
1 - Computer
2 - Player
EOF
  response = gets.chomp.to_i
  if response == 1
    @player_two = Player.new(ComputerMover.new(@board, @player_one.letter), 'O')
  elsif response == 2
    @player_two = Player.new(ConsoleMover.new($stdin), 'O')
  else
    setup_players
  end
end

def build_game
  @game = Game.new(@board, @player_one, @player_two)
end

def game_loop
  display(@game.board)
  @game.next_move(@board)
  check_for_win(@game.board)
  @game.toggle_players
  game_loop
end

def check_for_win(board)
  puts board.game_over_message if board.game_over?
  play_again? if board.game_over?
end

def play_again?
  print <<-EOF
Do you want to play again?
1 - Yes
2 - No
EOF
  answer = gets.chomp
  if answer.to_i == 1
    enter_game
  else
    puts 'Too baddie...'
    exit
  end
end

def display(board)
  print `clear`
  board.board.map { |num| '%2s' % num }.each_slice(board.board_dimension) { |row| print row, "\n" }
end

enter_game

__END__
