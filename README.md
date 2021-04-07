# Viewed Webpages Code Challenge

## Tech Stack
- Docker
- Ruby 2.7.2
- MongoDB
- Sinatra
- Mongoid

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
dkcr page_views_api rspec -fdoc --trace
```

## IMPROVEMENTS
Log files handler is not good, to keep the data persisted consistent, right now when you ping the `most_webpages_views` the log file will be renamed with a timestamp, that way visits counter column is not increased with data that were already read and persisted, so when you want to see the `unique_webpages_views` or `most_webpages_views` again, you should add or rename the `webserver.log`, it's supposed to be new fresh log data and, that will populate the records counters.


When you ping the same endpoint twice and, the log file is not named as `webserver.log`, means that it was already consumed once and was renamed to `webserver#{TIMESTAMP}.log`; An exception message is displayed, warning that it needs a valid log file.

This kind of behavior could be avoided with some kind of Background Job that keeps listening to these log files and then performs the content sanitization, turning the data good to be recorded into the DB.
