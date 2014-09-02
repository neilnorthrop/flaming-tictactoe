#! /usr/bin/env ruby
require 'pp'
require './board.rb'
require './board4x4.rb'
require './computer_ai.rb'

def enter_game
  board_size
  get_opponent
  assign_board_instance
  game_loop
end

def board_size
  print `clear` + <<-EOF
What size of board do you want to play?
1 - 3x3
2 - 4x4
EOF
  gets.chomp.to_i
  if $_ !~ /1|2/
    board_size
  else
    @boardsize = $_.to_i
  end
end

def get_opponent
  print `clear` + <<-EOF
Do you want to play a computer or player?
1 - Computer
2 - Player
EOF
  gets.chomp.to_i
  if $_ !~ /1|2/
    get_opponent
  else
    @opponent = $_.to_i
  end
end

def assign_board_instance
  if @boardsize == 1
    @game = Board.new
    @boardsize = 3
  elsif @boardsize == 2
    @game = Board4x4.new
    @boardsize = 4
  end
end

def game_loop
  player_one_turn
  
  check_for_win
  
  if @opponent == 1
    ComputerAI.computer_turn(@game)
  elsif @opponent == 2
    player_two_turn
  end
  
  check_for_win
  
  game_loop
end

def player_one_turn
  print `clear` + <<-EOF
Player One, please pick a place to play:
EOF
  display(@game)
  gets.chomp
  player_position = if $_ =~ /\d/
                      $_.to_i
                    else
                      player_one_turn
                    end
  
  if @game.set_position(player_position, "X") == false
    player_one_turn
  else
    @game.set_position(player_position, "X")
  end
end

def player_two_turn
  print `clear` + <<-EOF
Player Two, please pick a place to play:
EOF
  display(@game)
  gets.chomp
  player_position = if $_ =~ /\d/
                      $_.to_i
                    else
                      player_two_turn
                    end

  if @game.set_position(player_position, "O") == false
    player_two_turn
  else
    @game.set_position(player_position, "O")
  end
end

def check_for_win
  if @game.game_over?
    puts @game.game_over_message
    play_again?
  end
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

def display(game)
  game.display_board.map {|num| "%2s" % num }.each_slice(game.board_dimension) { |row| print row, "\n" }
end

enter_game

__END__