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
  response = gets.chomp.to_i
  if response == 1
    @player_two = Player.new(ComputerMover.new(@board, @player_one.letter), "O")
  elsif response == 2
    @player_two = Player.new(ConsoleMover.new($stdin), "O");
  else
    setup_players
  end
end

def build_game
  @game = Game.new(@board, @player_one, @player_two)
end

def game_loop
  @game.game_loop
  play_again?
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

enter_game

__END__