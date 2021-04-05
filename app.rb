# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/reloader'
require 'mongoid'

require './app/models/init'
require './config/init'
require './config/routes/init'

if Sinatra::Base.environment == :development
  require 'dotenv'
  Dotenv.load
end

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :server, :puma

  configure :development do
    register Sinatra::Reloader
  end

  enable :logging

  use PageViewRoutes
end
