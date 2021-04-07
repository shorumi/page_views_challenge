# frozen_string_literal: true

require File.join(File.dirname(__FILE__), '..', '..', 'app')

require 'rack/test'

ENV['RACK_ENV'] ||= 'test'
Mongoid.load!(File.join(File.dirname(__FILE__), '..', '..', 'config', 'mongoid.yml'))

RSpec.configure do |config|
  config.after(:each) do
    PageView.all.delete

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

  include Rack::Test::Methods
end
