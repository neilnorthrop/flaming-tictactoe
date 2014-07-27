require 'sinatra'
require 'haml'
require './boardgame.rb'
require './computer_ai.rb'

set :game, BoardGame.new

set :computer_ai, ComputerAI

get '/' do
	settings.game.reset_board
	haml :index
end

post '/index' do
	settings.game.set_position(params[:message].to_i, "X")
	settings.game.check_game
	settings.computer_ai.computer_turn(settings.game)
	settings.game.check_game
	haml :index
end