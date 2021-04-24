# frozen_string_literal: true

require './libs/utils/handle_sys_files'

class PageViewService
  ROUTES_IP_REGEX = %r{(/[^\s]+) (\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b)}.freeze

  def initialize(handle_sys_files:, pageview_repository:)
    @handle_sys_files = handle_sys_files
    @pageview_repository = pageview_repository
  end

  def most_webpages_views
    handle_log_file
    most_webpages_viewed_order_desc
  end

  def unique_webpages_views
    handle_log_file
    unique_webpage_views_order_desc
  end

  private

  def handle_log_file
    read_log_file ||= handle_sys_files.read_file

    read_log_file.each do |item|
      route, ip = match_routes_ip_from_log_file(item)
      persist_page_view_data(route, ip)
    end

    handle_sys_files.rename_with_timestamp
  end

  def persist_page_view_data(route, ip)
    page_view = pageview_repository.find_or_create_by_route_and_ip!(route, ip)
    increment_visits_column(:visits, page_view.id) unless page_view.blank?
  end

  def match_routes_ip_from_log_file(item)
    item.match(ROUTES_IP_REGEX).captures
  end

  def most_webpages_viewed_order_desc
    pageview_repository.find_most_webpages_viewed
  end

  def unique_webpage_views_order_desc
    pageview_repository.find_unique_webpage_views
  end

  def increment_visits_column(visits, page_view_id)
    pageview_repository.increment_counter_column(visits, page_view_id)
  end

  attr_reader :handle_sys_files, :pageview_repository
end
