# frozen_string_literal: true

require 'bundler/setup'
require 'active_job'
require 'sneakers'

require './app/business/rules/page_view'
require './app//repositories/page_view'
require './app/models/page_view'

class PageViewJob < ActiveJob::Base
  queue_as :job_queue

  def perform
    apply_pageview_business_rules.call
  end

  private

  def apply_pageview_business_rules
    Business::Rules::PageView.new(
      handle_sys_files: handle_sys_files,
      pageview_repository: Repository::PageView.new(entity: PageView)
    )
  end

  def handle_sys_files
    HandleSysFiles.new(
      directory: './log_files/',
      filename: 'webserver.log'
    )
  end
end
