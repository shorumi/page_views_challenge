# frozen_string_literal: true

require 'support/spec_helper'

RSpec.describe App do
  let(:app) do
    PageViewRoutes.new(
      page_view_service: ::PageViewService.new(
        handle_sys_files: ::HandleSysFiles.new(
          directory: './spec/support/fixtures/',
          filename: 'webserver_fixture.log'
        ),
        pageview_repository: ::Repository::PageView.new(entity: PageView)
      )
    )
  end
  let(:attributes) { JSON.parse(last_response.body) }

  describe 'GET /most_webpages_viewed' do
    let(:expected_attrs) do
      [
        { 'route' => '/about/2', 'total_visits' => 90 },
        { 'route' => '/contact', 'total_visits' => 89 },
        { 'route' => '/index', 'total_visits' => 82 },
        { 'route' => '/about', 'total_visits' => 81 },
        { 'route' => '/help_page/1', 'total_visits' => 80 },
        { 'route' => '/home', 'total_visits' => 78 }
      ]
    end
    it 'should return most webpages viewed in descending order' do
      get '/most_webpages_viewed'

      expect(last_response).to be_ok
      expect(attributes.size).to eq(6)
      expect(attributes).to eq(expected_attrs)
    end
  end

  describe 'GET /unique_webpages_viewed' do
    let(:response_hash_sorted) { attributes.sort_by! { |hash| hash['route'] } }
    let(:expected_attrs) do
      [
        { 'route' => '/contact', 'unique_views' => 23 },
        { 'route' => '/index', 'unique_views' => 23 },
        { 'route' => '/home', 'unique_views' => 23 },
        { 'route' => '/help_page/1', 'unique_views' => 23 },
        { 'route' => '/about/2', 'unique_views' => 22 },
        { 'route' => '/about', 'unique_views' => 21 }
      ]
    end
    it 'should return unique webpages viewed in descending order' do
      get '/unique_webpages_viewed'

      expect(last_response).to be_ok
      expect(attributes.size).to eq(6)
      expect(response_hash_sorted).to eq(expected_attrs.sort_by! { |hash| hash['route'] })
    end
  end
end
