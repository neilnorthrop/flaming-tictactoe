require 'sinatra'
require 'haml'
require './boardgame.rb'
require './computer_ai.rb'

set :game, BoardGame.new

set :computer_ai, ComputerAI

get '/' do
	settings.game.reset_board
	haml :game
end

post '/decide' do
	if params[:message] == 'computer'
		redirect '/computer'
	elsif params[:message] == 'player'
		redirect '/index'
	end	
end

get '/index' do
	haml :index
end

post '/index' do
	settings.game.set_position(params[:message].to_i, "X")
	settings.game.check_game
	settings.computer_ai.computer_turn(settings.game)
	settings.game.check_game
	haml :index
end

get '/computer' do
	haml :computer
end

post '/computer' do
	settings.computer_ai.computer_turn(settings.game)
	settings.game.check_game
	settings.game.set_position(params[:message].to_i, "X")
	settings.game.check_game
	haml :computer
end