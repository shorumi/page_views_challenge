# frozen_string_literal: true

require 'support/spec_helper'
require './app/workers/page_view_job'
require './app/services/handle_logfile_service'
require './libs/utils/handle_sys_files'
require './app/models/page_view'
require './app/repositories/page_view'

RSpec.describe PageViewJob, type: :job do
  include ActiveJob::TestHelper

  let(:handle_sys_files) do
    HandleSysFiles.new(
      directory: './spec/support/fixtures/',
      filename: 'webserver_fixture.log'
    )
  end

  after(:each) do
    clear_enqueued_jobs
  end

  describe 'perform_later' do
    ActiveJob::Base.queue_adapter = :test

    it 'queues the job' do
      expect { PageViewJob.perform_later('abc') }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it 'is in job_queue' do
      expect(PageViewJob.new.queue_name).to eq('job_queue')
    end
  end

  describe '#perform' do
    describe 'Perform the job' do
      let(:perform_page_view_job) do
        PageViewJob.perform_now(
          HandleLogfileService.new(
            handle_sys_files: handle_sys_files,
            pageview_repository: Repository::PageView.new(entity: PageView)
          )
        )
      end

      after(:each) do
        unless Dir.glob('./spec/support/fixtures/*-+0000.log').empty?
          Dir.each_child('./spec/support/fixtures/') do |file|
            File.rename(
              "./spec/support/fixtures/#{file}",
              './spec/support/fixtures/webserver_fixture.log'
            )
          end
        end
      end

      it 'PageView is persisted' do
        ActiveJob::Base.queue_adapter = :test

        perform_page_view_job

        expect(PageView.all.count).to eq(135)
      end
    end
  end
end
