# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/reloader'

class PageViewsApiApp < Sinatra::Base
  set :server, :puma

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello world!'
  end
end
