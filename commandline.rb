#! /usr/bin/env ruby
require './boardgame.rb'
require './computer_ai.rb'

def enter_game
  puts "Do you want to play a game? Please type 'yes' or 'no'"
  answer = gets.chomp.downcase
  puts

  case answer
  when 'yes'
    puts "okay, lets play\n\n" + "*" * 30 + "\n\nYou'll start first and be the letter 'x'\n\n" + "*" * 30 + "\n\n"
    @game = BoardGame.new
    game_loop
  when 'no'
    print `clear`
    puts "too bad dude/dudette\n\n"
    exit
  else
    puts "you need to pick 'yes' or 'no'\n\n"
    enter_game
  end
end

def display(board)
  print "[#{board[0]}, #{board[1]}, #{board[2]}]\n[#{board[3]}, #{board[4]}, #{board[5]}]\n[#{board[6]}, #{board[7]}, #{board[8]}]\n"
end

def player_turn
  print `clear`
  puts "Please pick the number to where you want to play:\n"

  display(@game.display_board)

  gets.chomp

  player_position = if $_ =~ /\d/
                      if $_.to_i < 10
                        $_.to_i
                      else
                        puts "* " * 15 + "Please pick a number 1-9" + " *" * 15
                        player_turn
                      end
                    else
                      puts "* " * 15 + "Please pick a number 1-9" + " *" * 15
                      player_turn
                    end

  if @game.set_position(player_position, "X") == nil
    player_turn
  else
    @game.set_position(player_position, "X")
  end
end

def game_win
  if @game.game_over?
    puts @game.game_over_message
    enter_game
  end
end

def game_loop
  print `clear`
  player_turn
  game_win

  ComputerAI.computer_turn(@game)
  game_win

  game_loop
end

enter_game

__END__

