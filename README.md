# Base Rails application

# Normal development flow

1. Start the server

   ./bin/dev

2. Open the browser and go to `http://localhost:3000`

3. Watch the tests

   bundle exec guard

## Initial setup

1. Install PostgreSQL if you haven't already

   brew install postgresql
   brew services start postgresql@14

2. Install `rvm` if you haven't already

   \curl -sSL https://get.rvm.io | bash -s stable

3. Install the version of ruby this project uses

   rvm install $(cat .ruby-version)

4. Once ruby is installed, you can then install bundler

   gem install bundler

5. Install the gems/dependencies for this project

   cd mybase
   bundle install

6. Create the database

   rails db:create db:migrate db:seed

7. Install commit hooks

   overcommit --install

8. Copy and set the environment variables

   cp .env.template .env

Now you can use the normal development flow documented above.

## Environment variables

Environment variables are stored in the `.env` file. This is not checked into source control on purpose as some environment variables are secrets (like API keys). You can copy the `.env.template` file to `.env` and set the values accordingly. In production, they are set by the server.

### Adding a new environment variable

Missing an environment variable from configuration have been known to cause issues and downtime. To help prevent that, whenever you add a new environment variable to the `.env` file, you should also add it two other places:

1. Add it to the `.env.template` file so that others will know to set it. Please also document the environment variables with instrucutions on where to find it or generate it.
1. Add it to the `config/initializers/dotenv.rb` file so that the application will fail to start if the environment variable is missing.

If you see the following error:

    `require_keys': Missing required configuration key: ["MISSING_API_KEY"] (Dotenv::MissingKeys)
    	from /.../mybase/config/initializers/dotenv.rb:8:in `<main>'

It means that an environment variable is missing and should be added to the configuration.
