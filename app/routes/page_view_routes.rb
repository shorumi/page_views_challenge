# frozen_string_literal: true

require 'sinatra/json'
require 'sinatra/reloader'

require './app/models/page_view'
require './app/repositories/page_view'
require './app/business/rules/page_view'
require './app/custom/exception_messages/error_message'

class PageViewRoutes < Sinatra::Application
  def initialize(
    app = nil,
    page_view_business_rules: Business::Rules::PageView.new(
      pageview_repository: Repository::PageView.new(entity: PageView)
    )
  )
    super(app)
    @page_view_business_rules = page_view_business_rules
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/most_webpages_viewed' do
    most_webpage_views = page_view_business_rules.most_webpages_views

    body json(most_webpage_views)
    status 200
  end

  get '/unique_webpages_viewed' do
    unique_webpage_views = page_view_business_rules.unique_webpages_views

    body json(unique_webpage_views)
    status 200
  end

  private

  attr_reader :page_view_business_rules
end
