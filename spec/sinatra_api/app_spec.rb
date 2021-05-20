# frozen_string_literal: true

require 'support/spec_helper'
require './app/models/page_view'
require './app/repositories/page_view'

RSpec.describe App do
  before(:each) do
    FactoryBot.create(:page_view, route: '/ojuara', ip: '192.168.10.1', visits: 10)
    FactoryBot.create(:page_view, route: '/cuca_beludo', ip: '192.168.10.2', visits: 5)
    FactoryBot.create(:page_view, route: '/cuca_beludo', ip: '192.168.10.3', visits: 1)
    FactoryBot.create(:page_view, route: '/cuca_beludo', ip: '192.168.10.4', visits: 2)
    FactoryBot.create(:page_view, route: '/melo_rego', ip: '192.168.10.3', visits: 10)
    FactoryBot.create(:page_view, route: '/melo_rego', ip: '192.168.10.4', visits: 7)
  end

  let(:app) do
    PageViewRoutes.new(
      page_view_service: ::PageViewService.new(pageview_repository: ::Repository::PageView.new(entity: PageView))
    )
  end
  let(:attributes) { JSON.parse(last_response.body) }

  describe 'GET /most_webpages_viewed' do
    let(:expected_attrs) do
      [
        { 'route' => '/melo_rego', 'total_visits' => 17 },
        { 'route' => '/ojuara', 'total_visits' => 10 },
        { 'route' => '/cuca_beludo', 'total_visits' => 8 }
      ]
    end
    it 'should return most webpages viewed in descending order' do
      get '/most_webpages_viewed'

      expect(last_response).to be_ok
      expect(attributes.size).to eq(3)
      expect(attributes).to eq(expected_attrs)
    end
  end

  describe 'GET /unique_webpages_viewed' do
    let(:response_hash_sorted) { attributes.sort_by! { |hash| hash['route'] } }
    let(:expected_attrs) do
      [
        { 'route' => '/cuca_beludo', 'unique_views' => 3 },
        { 'route' => '/melo_rego', 'unique_views' => 2 },
        { 'route' => '/ojuara', 'unique_views' => 1 }
      ]
    end
    it 'should return unique webpages viewed in descending order' do
      get '/unique_webpages_viewed'

      expect(last_response).to be_ok
      expect(attributes.size).to eq(3)
      expect(response_hash_sorted).to eq(expected_attrs.sort_by! { |hash| hash['route'] })
    end
  end
end
