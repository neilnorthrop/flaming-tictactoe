ENV['RACK_ENV'] = 'test'

require './tictactoe'
require 'spec_helper'
require 'capybara'
require 'capybara/dsl'
require 'rspec'
require 'rack/test'
require 'pp'
print `clear`

def get_app
	get '/'
	expect(last_response).to be_ok
end

RSpec.describe "when visiting the website" do
	def app
		Sinatra::Application
	end

	it "shows 'Pick your opponent' on the homepage" do
		get_app

		expect(last_response.body).to include('Pick your opponent:')
	end
end

RSpec.describe "when player one picks the 3x3 option" do
	Capybara.app = Sinatra::Application.new

	it "shows a 3x3 board" do
		visit '/'
		choose '3x3'
		click_button('Computer')
	end
end