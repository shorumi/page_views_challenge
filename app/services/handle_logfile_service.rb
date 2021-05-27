# frozen_string_literal: true

class HandleLogfileService
  ROUTES_IP_REGEX = %r{(/[^\s]+) (\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b)}.freeze

  def initialize(handle_sys_files:, pageview_repository:)
    @handle_sys_files = handle_sys_files
    @pageview_repository = pageview_repository
  end

  def call
    record_log_file_data
    rename_log_file_with_timestamps
  end

  attr_reader :handle_sys_files, :pageview_repository

  private

  def record_log_file_data
    read_log_file = handle_sys_files.read_file

    read_log_file.each do |item|
      route, ip = match_routes_ip_from_log_file(item)
      persist_page_view_data(route, ip)
    end
  end

  def rename_log_file_with_timestamps
    handle_sys_files.rename_with_timestamp
  end

  def persist_page_view_data(route, ip)
    page_view = pageview_repository.find_or_create_by_route_and_ip!(route, ip)
    increment_visits_column(:visits, page_view.id)
  end

  def match_routes_ip_from_log_file(item)
    item.match(ROUTES_IP_REGEX).captures
  end

  def increment_visits_column(visits, page_view_id)
    pageview_repository.increment_counter_column(visits, page_view_id)
  end
end
