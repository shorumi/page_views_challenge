# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'sneakers/tasks'

require './app/workers/page_view_job'
require './libs/utils/handle_sys_files'
require './app/services/handle_page_view_job'
require './bin/worker'

desc 'Load the environment'
task :environment do
  @env = ENV['RACK_ENV'] || 'development'
end

namespace :whenever do
  desc 'Persists Page Views to the DB'
  task(persist_page_view_task: :environment) do
    HandlePageViewJob.new(
      handle_sys_files: HandleSysFiles.new(
        directory: './log_files/',
        filename: 'webserver.log'
      ),
      logger: Logger.new($stdout)
    ).call
  end
end
