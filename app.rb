# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/reloader'
require 'mongoid'

require './app/models/init'
require './config/init'
require './config/routes/init'

# :nocov:
if Sinatra::Base.environment == :development
  require 'dotenv'
  Dotenv.load
end
# :nocov:

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

class App < Sinatra::Application
  set :server, :puma

  configure :development do
    register Sinatra::Reloader
  end

  enable :logging

  use PageViewRoutes
end
