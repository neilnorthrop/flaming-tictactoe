ENV['RACK_ENV'] = 'test'

require './tictactoe'
require 'spec_helper'
require 'capybara'
require 'capybara/dsl'
require 'rspec'
require 'rack/test'
require 'pp'
print `clear`

RSpec.describe "the website" do
	it "shows 'Tic Tac Toe' on the homepage" do
		get '/'
		expect(last_response).to be_ok
		expect(last_response.body).to include('Pick your opponent:')
	end
end

# class TictactoeTest < Minitest::Test
# 	include Rack::Test::Methods

# 	def app
# 		Sinatra::Application
# 	end

# 	def test_gets_response_from_root
# 		get '/'
# 		assert last_response.ok?
# 	end

	# def test_says_looking
 	#   browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
	# 	browser.get '/looking'
	# 	assert browser.last_response.ok?
	# 	refute !browser.last_response.ok?
	# 	assert_equal 'Looking for a page', browser.last_response.body
	# 	assert_equal true, browser.last_response.ok?
	# end
# end

# class TictactoeTest < Minitest::Test
# 	include Capybara::DSL
# 	# Capybara.default_driver = :selenium # <-- use Selenium driver

# 	def setup
# 		Capybara.app = Sinatra::Application.new
# 	end

# 	def test_it_works
# 		visit '/'
# 		assert page.has_content?('Tic Tac Toe')
# 	end

# 	def test_posting_to_index
# 		visit '/'
# 		fill_in('message', :with => 1)
# 		click_button('pick')
# 		assert page.has_content?("X")
# 		assert page.has_content?("O")
# 	end

# 	def test_reposting_to_index
# 		visit '/'
# 		fill_in('message', :with => 1)
# 		click_button('pick')
# 		assert page.has_content?("X")
# 		assert page.has_content?("O")

# 		fill_in('message', :with => 2)
# 		click_button('pick')
# 		assert page.has_content?("X")
# 		assert page.has_content?("O")
# 	end

# 	def test_computer_winner
# 		visit '/'
# 		fill_in('message', :with => 1)
# 		click_button('pick')
# 		fill_in('message', :with => 2)
# 		click_button('pick')
# 		fill_in('message', :with => 3)
# 		click_button('pick')

# 		assert page.has_content?('COMPUTER'), "#{body}"
# 		assert find_button('pick').disabled?, "#{find_button('pick')}"
# 	end

# 	def test_draw
# 		visit '/'
# 		fill_in('message', :with => 1)
# 		click_button('pick')
# 		fill_in('message', :with => 2)
# 		click_button('pick')
# 		fill_in('message', :with => 7)
# 		click_button('pick')
# 		fill_in('message', :with => 6)
# 		click_button('pick')
# 		fill_in('message', :with => 8)
# 		click_button('pick')

# 		assert page.has_content?('DRAW'), "#{body}"
# 		assert find_button('pick').disabled?, "#{find_button('pick')}"
# 	end
# end




































