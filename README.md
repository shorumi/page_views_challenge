# Viewed Webpages Code Challenge

## Tech Stack
- Docker
- Ruby 2.7.2
- MongoDB
- Sinatra
- Mongoid
- RabbitMQ
- Async JOB

## Starting the project
- Create a brand new `.env` file:
```shell
cp -a .env.development .env
```
- In a unix terminal tab run: 
```shell
docker-compose up --build
```

## Implemented endpoints
### /most_webpages_views
it returns the Most Webpages views ordered in descending order and as JSON
```json
[
  {
    "route": "/about/2",
    "total_visits": 90
  },
  {
    "route": "/contact",
    "total_visits": 89
  },
  {
    "route": "/index",
    "total_visits": 82
  },
  {
    "route": "/about",
    "total_visits": 81
  },
  {
    "route": "/help_page/1",
    "total_visits": 80
  },
  {
    "route": "/home",
    "total_visits": 78
  }
]
```

### /unique_webpages_views
it returns the Unique Webpages views ordered in descending order and as JSON
```json
[
  {
    "route": "/index",
    "unique_views": 23
  },
  {
    "route": "/home",
    "unique_views": 23
  },
  {
    "route": "/help_page/1",
    "unique_views": 23
  },
  {
    "route": "/contact",
    "unique_views": 23
  },
  {
    "route": "/about/2",
    "unique_views": 22
  },
  {
    "route": "/about",
    "unique_views": 21
  }
]
```

## Running the RSpec tests
- In a terminal tab run the rspec tests: 
```shell
docker-compose run page_views_api rspec -fdoc
```


