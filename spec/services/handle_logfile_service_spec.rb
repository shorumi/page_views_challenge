# frozen_string_literal: true

require 'support/spec_helper'
require './app/services/handle_logfile_service'
require './libs/utils/handle_sys_files'

RSpec.describe HandleLogfileService do
  let(:handle_logfile_service) do
    described_class.new(
      handle_sys_files: handle_sys_files,
      pageview_repository: page_view_repo
    )
  end
  let(:handle_sys_files) do
    HandleSysFiles.new(
      directory: './spec/support/fixtures/',
      filename: 'webserver_fixture.log'
    )
  end
  let(:page_view_repo) do
    Repository::PageView.new(entity: PageView)
  end

  before(:each) do
    handle_logfile_service.call
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

  describe '#call' do
    context 'PageView table' do
      it { expect(PageView.all.to_a).to_not be_empty }
    end

    context 'Logfile' do
      it 'is expected to be renamed' do
        expect(Dir.glob('./spec/support/fixtures/*-+0000.log')).to_not be_empty
      end
    end
  end
end

