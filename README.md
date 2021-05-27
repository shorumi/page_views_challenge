# Viewed Webpages Code Challenge

## Description
The main purpose of this **Sinatra service** is at **every 2 minutes** look for a valid WebServer logfiles at `./log_files/` and then enqueue it 
to the **RabbitMQ**, process this enqueued job, apply the expected **Business Rules**, persist it to the **NoSQL DB**,
rename the executed WebServer logfile `log_files/webserver#{Timestamp}` with the execution Timestamp and then expose 
that through endpoints.

When there is no valid `./log_files/webserver.log` file, it will raise a WARN message to the `./log/crontab.log` file

## Test Coverage
<img width="1320" alt="Screen Shot 2021-05-27 at 00 35 39" src="https://user-images.githubusercontent.com/71681750/119767653-95556580-be8d-11eb-85ec-0a222e054253.png">


## RabbitMQ Management, queues
URL: `http://localhost:15672`

Username: `guest` / Password: `guest`

<img width="1433" alt="Screen Shot 2021-05-27 at 01 46 52" src="https://user-images.githubusercontent.com/71681750/119767698-ad2ce980-be8d-11eb-979d-ace50e6ecd7b.png">


## Logs
<img width="1440" alt="Screen Shot 2021-05-27 at 02 08 22" src="https://user-images.githubusercontent.com/71681750/119769238-7c9a7f00-be90-11eb-8bc3-e3f48f680661.png">



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


