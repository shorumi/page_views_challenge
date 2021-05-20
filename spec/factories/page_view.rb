FactoryBot.define do
  factory :page_view do
    route { '/abc' }
    ip { '192.168.1.1' }
    visits { 1 }
  end
end
