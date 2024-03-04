# Base Rails application

# Normal development flow

1. Start the server

   ./bin/dev

2. Open the browser and go to `http://localhost:3000`

3. Watch the tests

   bundle exec guard

## Initial setup

1. Install psql if you haven't already

   brew install postgresql
   brew services start postgresql@14

2. Install rvm if you haven't already

   \curl -sSL https://get.rvm.io | bash -s stable

3. Install the correct version of ruby

   rvm install $(cat .ruby-version)

4. Install bundler

   gem install bundler

5. Install the gems

   cd mybase
   bundle install

6. Create the database

   rails db:create db:migrate db:seed
