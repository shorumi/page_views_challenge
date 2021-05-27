# frozen_string_literal: true

require 'bundler/setup'
require 'active_job'
require 'sneakers'

require './app/services/handle_logfile_service'
require './app//repositories/page_view'
require './app/models/page_view'

class PageViewJob < ActiveJob::Base
  queue_as :job_queue

  def perform(handle_logfile_service)
    handle_logfile_service.call
  end
end
