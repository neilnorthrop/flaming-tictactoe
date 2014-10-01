require 'rack/test'
require 'bundler/setup'
require 'sinatra'
Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment
require 'rspec'
require 'capybara'
require 'capybara/rspec'
require File.expand_path '../../tictactoe.rb', __FILE__
# require File.dirname(__FILE__) + '/../config/boot'

module RSpecMixin
  include Rack::Test::Methods
  include Capybara::DSL
end

RSpec.configure { |c| c.include RSpecMixin; }