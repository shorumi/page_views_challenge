# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require File.join(File.dirname(__FILE__), '..', '..', 'app')

require 'rack/test'
require 'factory_bot'

ENV['RACK_ENV'] ||= 'test'
Mongoid.load!(File.join(File.dirname(__FILE__), '..', '..', 'config', 'mongoid.yml'))

RSpec.configure do |config|
  config.before(:each) do
    PageView.all.delete
  end

  config.order = 'random'

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  include Rack::Test::Methods
end
