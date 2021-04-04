FROM lambci/lambda:build-ruby2.7

RUN yum install -y --skip-broken \
    https://yum.postgresql.org/11/redhat/rhel-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm 
RUN yum install -y postgresql-devel

RUN gem update bundler

RUN mkdir /app
WORKDIR /app
