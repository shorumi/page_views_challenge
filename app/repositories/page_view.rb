# frozen_string_literal: true

require 'mongoid'

module Repository
  class PageView
    def initialize(entity:)
      @entity = entity
    end

    def find_unique_webpage_views
      entity.collection.aggregate(
        [
          {
            '$sortByCount' => '$route'
          },
          {
            '$project' =>
            {
              "_id": 0,
              'route' => '$_id',
              'unique_views' => '$count'
            }
          }
        ]
      )
    end

    def find_most_webpages_viewed
      entity.collection.aggregate(
        [
          {
            '$group' =>
            {
              '_id': '$route',
              'totalVisits' =>
              {
                '$sum' => '$visits'
              }
            }
          },
          {
            '$sort' =>
            {
              'totalVisits' => -1
            }
          },
          {
            '$project' =>
            {
              "_id": 0,
              'route' => '$_id',
              'total_visits' => '$totalVisits'
            }
          }
        ]
      )
    end

    def find_or_create_by_route_and_ip!(route, ip)
      entity.find_or_create_by!(route: route, ip: ip)
    end

    def increment_counter_column(column, id)
      entity.increment_counter(column, id)
    end

    private

    attr_reader :entity
  end
end
