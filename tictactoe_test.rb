ENV['RACK_ENV'] = 'test'

require './tictactoe'
require 'capybara'
require 'capybara/dsl'
require 'test/unit'
require 'rack/test'
puts `clear`

class GameTest < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	def test_gets_response_from_root
		get '/'
		assert last_response.ok?
	end

	# def test_says_looking
 	#   browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
	# 	browser.get '/looking'
	# 	assert browser.last_response.ok?
	# 	refute !browser.last_response.ok?
	# 	assert_equal 'Looking for a page', browser.last_response.body
	# 	assert_equal true, browser.last_response.ok?
	# end
end

class HelloWorldTest < Test::Unit::TestCase
	include Capybara::DSL
	# Capybara.default_driver = :selenium # <-- use Selenium driver

	def setup
		Capybara.app = Sinatra::Application.new
	end

	def test_it_works
		visit '/'
		assert page.has_content?('Tic Tac Toe')
	end
end