# frozen_string_literal: true

require 'support/spec_helper'
require './app/services/page_view_service'

RSpec.describe PageViewService do
  describe '#call' do
    let(:service) do
      described_class.new(
        handle_sys_files: ::HandleSysFiles.new(
          directory: './spec/support/fixtures/',
          filename: 'webserver_fixture.log'
        ),
        pageview_repository: ::Repository::PageView.new(entity: PageView)
      )
    end
    context '.most_webpages_views' do
      it { expect(service.most_webpages_views.to_a).to_not be_empty }
    end
    context '.unique_webpages_views' do
      it { expect(service.unique_webpages_views.to_a).to_not be_empty }
    end
  end
end
