# frozen_string_literal: true

require 'support/spec_helper'
require './app/business/rules/page_view'

RSpec.describe Business::Rules::PageView do
  describe '#call' do
    before do
      FactoryBot.create(:page_view)
    end

    let(:service) do
      described_class.new(
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
