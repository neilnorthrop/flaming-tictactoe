require 'sinatra'
require 'haml'
require './boardgame.rb'
require './boardgame4x4.rb'
require './computer_ai.rb'

set :game, BoardGame.new
set :board, ""
set :computer_ai, ComputerAI

get '/' do
	haml :game
end

post '/decide' do
  if params[:board] == "4x4"
    settings.game = BoardGame4x4.new
    settings.board = "4x4"
  else
    settings.game = BoardGame.new
    settings.board = ""
  end
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