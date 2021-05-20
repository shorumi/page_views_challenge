
#!/bin/bash -i

# Checks if the dependencies listed in Gemfile are satisfied by currently installed gems
bundle clean --force

# Check whether or not gems are installed, and install it case not installed.
bundle check || bundle install --jobs=$(nproc) --retry=5

./libs/scripts/wait-for-it.sh rabbitmq:15672 mongodb:27017 -- "$@"

