require 'sinatra'
require 'haml'
require './boardgame.rb'
require './computer_ai.rb'

set :game, BoardGame.new

set :computer_ai, ComputerAI

get '/' do
	settings.game = BoardGame.new
	haml :game
end

post '/decide' do
	settings.computer_ai.computer_turn(settings.game)	if params[:first_turn] == 'Computer'
	redirect '/board'
end

get '/board' do
	haml :board
end

post '/turn' do
	settings.game.set_position(params[:player_move].to_i, "X")
	settings.computer_ai.computer_turn(settings.game)
	redirect '/board'
end