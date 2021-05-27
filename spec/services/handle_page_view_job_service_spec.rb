# frozen_string_literal: true

require 'support/spec_helper'
require './app/workers/page_view_job'
require './app/services/handle_page_view_job_service'
require './app/services/handle_logfile_service'
require './libs/utils/handle_sys_files'

RSpec.describe HandlePageViewJobService do
  let(:handle_page_view_job_service) do
    described_class.new(
      handle_sys_files: handle_sys_files,
      logger: logger
    )
  end
  let(:handle_sys_files) do
    HandleSysFiles.new(
      directory: './spec/support/fixtures/',
      filename: 'webserver_fixture.log'
    )
  end
  let(:logger) { object_double(Logger.new($stdout), warn: nil) }

  describe '#call' do
    context 'When there is no WebServer Logfile' do
      let(:handle_sys_files) do
        HandleSysFiles.new(
          directory: '',
          filename: ''
        )
      end

      it do
        handle_page_view_job_service.call

        expect(logger).to have_received(:warn).with(
          {
            status_code: 404,
            message: 'There is no valid Log File, please provide one!'
          }
        )
      end
    end

    context 'When there is a WebServer Logfile' do
      it do
        allow(PageViewJob).to receive(:perform_later).and_return('abc')

        expect(handle_page_view_job_service.call).to be('abc')
      end
    end
  end
end
