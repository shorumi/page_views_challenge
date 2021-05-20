# frozen_string_literal: true

require 'mongoid'

class PageView
  include Mongoid::Document

  field :route, type: String
  field :ip, type: String
  field :visits, type: Integer, default: 0

  validates :ip, :route, presence: true
end
