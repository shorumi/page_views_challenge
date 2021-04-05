class PageView
  include Mongoid::Document

  field :uri, type: String
  field :ip, type: String
  field :visits, type: Integer

  validates :ip, :uri, uniqueness: true
  validates :ip, :uri, :visits, presence: true
end
