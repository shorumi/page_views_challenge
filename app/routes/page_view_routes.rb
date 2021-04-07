# frozen_string_literal: true

require 'sinatra/json'
require 'sinatra/reloader'

require './app/services/page_view_service'
require './app/repositories/page_view'
require './app/custom/exception_messages/error_message'

class PageViewRoutes < Sinatra::Application
  def initialize(
    app = nil,
    page_view_service: PageViewService.new(
      handle_sys_files: HandleSysFiles.new(
        directory: './log_files/',
        filename: 'webserver.log'
      ),
      pageview_repository: Repository::PageView.new(entity: PageView)
    )
  )
    super(app)
    @page_view_service = page_view_service
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/most_webpages_viewed' do
    begin
      most_webpage_views = page_view_service.most_webpages_views
    rescue Errno::ENOENT => e
      error 404, json(ExceptionMessages::LogFileNotFoundErrorMessage.error_message(e))
    end

    body json(most_webpage_views)
    status 200
  end

  get '/unique_webpages_viewed' do
    begin
      unique_webpage_views = page_view_service.unique_webpages_views
    rescue Errno::ENOENT => e
      error 404, json(ExceptionMessages::LogFileNotFoundErrorMessage.error_message(e))
    end

    body json(unique_webpage_views)
    status 200
  end

  private

  attr_reader :page_view_service
end