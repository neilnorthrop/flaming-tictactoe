require 'sinatra'
require 'haml'
require './game.rb'
require './player.rb'
require './board.rb'
require './board4x4.rb'
require './computer_ai.rb'
enable :sessions

get '/' do
	haml :game
end

post '/decide' do
	session['player_one'] = Player.new(WebMover.new, "X")
  if params[:board] == "4x4"
    session['board'] = Board4x4.new
  else
    session['board'] = Board.new
  end
	session['player_two'] = Player.new(ComputerMover.new(session['board'], session['player_one'].letter), "O") if params[:opponent] == 'Computer'
	session['player_two'] = Player.new(WebMover.new, "O") if params[:opponent] == 'Player'
	session['game'] = Game.new(session['board'], session['player_one'], session['player_two'])
	redirect '/board'
end

get '/board' do
	haml :board
end

post '/turn' do
	session['game'].set(params[:player_move].to_i, session['player_one'].letter)
	redirect '/board' if session['board'].game_over?
	session['game'].set(session['player_two'].get_move, session['player_two'].letter)
	redirect '/board'
end