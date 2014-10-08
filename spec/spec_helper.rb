require 'rspec'
require 'capybara'
require 'capybara/rspec'
require File.expand_path '../../tictactoe.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  include Capybara::DSL
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :my_firefox_driver do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end

RSpec.configure { |c| c.include RSpecMixin; }