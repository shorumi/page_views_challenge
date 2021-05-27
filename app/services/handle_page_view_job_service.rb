# frozen_string_literal: true

require './app/services/handle_logfile_service'

class HandlePageViewJobService
  def initialize(handle_sys_files:, logger:)
    @handle_sys_files = handle_sys_files
    @logger = logger
  end

  def call
    execute_persist_page_view_job
  end

  private

  attr_reader :handle_sys_files, :logger

  def execute_persist_page_view_job
    return logger.warn(ExceptionMessages::NotFoundFile.message) unless handle_sys_files.file_exists?

    PageViewJob.perform_later(
      HandleLogfileService.new(
        handle_sys_files: handle_sys_files,
        pageview_repository: Repository::PageView.new(entity: PageView)
      )
    )
  end
end
