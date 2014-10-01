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

def capy_app
	Capybara.app = Sinatra::Application.new
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

RSpec.describe "when player one picks the 3x3 or 4x4 option" do
	capy_app

	it "shows a 3x3 board" do
		visit '/'
		choose '3x3'
		click_button('Computer')
		expect(page).to have_css('.board')
	end

	it "shows a 4x4 board" do
		visit '/'
		choose '4x4'
		click_button('Player')
		expect(page).to have_css('.board4x4')
	end
end

RSpec.describe "when player one picks a cell" do
	capy_app

	it "posts a move to the game board" do
		visit '/'
		choose '3x3'
		click_button('Computer')
		click_button('1')
		expect(page).to have_css('#X')
	end
end






















