require 'sinatra'
require 'haml'
require './game.rb'
require './player.rb'
require './board.rb'
require './board4x4.rb'
require './computer_ai.rb'
require 'pp'

def player_one
	session["player_one"]
end

def game
	session['game']
end

def next_move_and_toggle(params)
	game.next_move(params)
	game.toggle_players
end

enable :sessions
set :session_secret, 'So0perSeKr3t!'

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
	next_move_and_toggle(params)
	redirect '/board' if session['board'].game_over?
	redirect '/board' if game.current_player.mover.requires_interaction?
	next_move_and_toggle(params)
	redirect '/board'
end

not_found do
	halt 404, 'page not found!'
end