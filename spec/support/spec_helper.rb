# frozen_string_literal: true

require File.join(File.dirname(__FILE__), '..', '..', 'app')

require 'rack/test'
require 'factory_bot'

ENV['RACK_ENV'] ||= 'test'
Mongoid.load!(File.join(File.dirname(__FILE__), '..', '..', 'config', 'mongoid.yml'))

RSpec.configure do |config|
  config.before(:each) do
    PageView.all.delete
  end

  config.after(:each) do
    unless Dir.glob('./spec/support/fixtures/*-UTC.log').empty?
      Dir.each_child('./spec/support/fixtures/') do |file|
        File.rename(
          "./spec/support/fixtures/#{file}",
          './spec/support/fixtures/webserver_fixture.log'
        )
      end
    end
  end

  config.order = 'random'

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  include Rack::Test::Methods
end
