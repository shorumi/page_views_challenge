class PageViewRoutes < Sinatra::Base
  get '/most_viewed_webpages' do
    body PageView.all.to_json
    status 200
  end
end
