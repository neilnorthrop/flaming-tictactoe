#! /usr/bin/env ruby
require 'pp'
require './player.rb'
require './game.rb'
require './board.rb'
require './board4x4.rb'
require './computer_ai.rb'

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
  @player_one = Player.new(ConsoleMover.new($stdin), "X")
  print `clear` + <<-EOF
Do you want to play a computer or player?
1 - Computer
2 - Player
EOF
  gets.chomp.to_i
  if $_ !~ /1|2/
    get_opponent
  else
    if $_ == 1
      @player_two = Player.new(ComputerMover.new(@board, @player_one), "O")
    else
      @player_two = Player.new(ConsoleMover.new($stdin), "O")
    end
  end
end

def build_game
  @game = Game.new(@board, @player_one, @player_two)
end

def game_loop
  display(@game.board)
  @game.game_loop
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
    puts "Too baddie..."
    exit
  end
end

def display(board)
  board.display_board.map {|num| "%2s" % num }.each_slice(board.board_dimension) { |row| print row, "\n" }
end

enter_game

__END__