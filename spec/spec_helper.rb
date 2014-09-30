require 'rack/test'
require 'bundler/setup'
require 'sinatra'
Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment
require 'rspec'
require File.expand_path '../../tictactoe.rb', __FILE__
# require File.dirname(__FILE__) + '/../config/boot'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }