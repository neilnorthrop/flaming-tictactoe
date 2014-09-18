require 'sinatra'
require 'haml'
require './boardgame.rb'
require './boardgame4x4.rb'
require './computer_ai.rb'

set :game, BoardGame.new
set :board, ""
set :computer_ai, ComputerAI.new

get '/' do
	haml :game
end

post '/decide' do
  if params[:board] == "4x4"
    settings.game = Board4x4.new
    settings.board = "4x4"
  else
    settings.game = Board.new
    settings.board = ""
  end
	settings.game.set_position(settings.computer_ai.get_move(settings.game, "O", "X"), "O")	if params[:first_turn] == 'Computer'
	redirect '/board'
end

get '/board' do
	haml :board
end

post '/turn' do
	settings.game.set_position(params[:player_move].to_i, "X")
	settings.game.set_position(settings.computer_ai.get_move(settings.game, "O", "X"), "O")
	redirect '/board'
end