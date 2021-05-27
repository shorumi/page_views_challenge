# frozen_string_literal: true

require 'active_job'
require './app/services/handle_logfile_service'
require './app/models/page_view'

class HandleLogfileServiceSerializer < ActiveJob::Serializers::ObjectSerializer
  def serialize?(argument)
    argument.is_a? HandleLogfileService
  end

  def serialize(handle_logfile_service)
    super(
      'handle_sys_files' => handle_logfile_service.handle_sys_files
    )
  end

  def deserialize(hash)
    HandleLogfileService.new(
      handle_sys_files: HandleSysFiles.new(
        directory: hash['handle_sys_files']['directory'],
        filename: hash['handle_sys_files']['filename']
      ),
      pageview_repository: Repository::PageView.new(entity: PageView)
    )
  end
end
