# frozen_string_literal: true

class HandlePageViewJob
  def initialize(handle_sys_files:, logger:)
    @handle_sys_files = handle_sys_files
    @logger = logger
  end

  def call
    execute_persist_page_view_job?
  end

  private

  attr_reader :handle_sys_files, :logger

  def execute_persist_page_view_job?
    if handle_sys_files.file_exists?
      PageViewJob.perform_later
    else
      logger.warn({ status: 404, message: 'There is no valid Log File, please provide one!' })
    end
  end
end
