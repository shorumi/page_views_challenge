# frozen_string_literal: true

require File.join(File.dirname(__FILE__), '..', '..', 'app')

require 'rack/test'

ENV['RACK_ENV'] ||= 'test'
Mongoid.load!(File.join(File.dirname(__FILE__), '..', '..', 'config', 'mongoid.yml'))

RSpec.configure do |config|
  # Run each test inside a DB transaction
  #   config.around(:each) do |test|
  #     ActiveRecord::Base.transaction do
  #       test.run
  #       raise ActiveRecord::Rollback
  #     end
  #   end

  config.order = 'random'

  include Rack::Test::Methods

  def app
    App.new
  end
end
