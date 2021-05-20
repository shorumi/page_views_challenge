# frozen_string_literal: true

class PageViewService
  def initialize(pageview_repository:)
    @pageview_repository = pageview_repository
  end

  def most_webpages_views
    most_webpages_viewed_order_desc
  end

  def unique_webpages_views
    unique_webpage_views_order_desc
  end

  private

  def most_webpages_viewed_order_desc
    pageview_repository.find_most_webpages_viewed
  end

  def unique_webpage_views_order_desc
    pageview_repository.find_unique_webpage_views
  end

  attr_reader :pageview_repository
end
