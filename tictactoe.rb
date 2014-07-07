require 'sinatra'

set :player, 'X'
set :sessions, true

get '/' do
	"Hello! Player One will play as '#{settings.player}'"
end

get '/looking' do
	"Looking for a page"
end
