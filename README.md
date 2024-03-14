# Base Rails application

A base Ruby on Rails application trying to follow the modern conventions.

## Normal development flow

1.  Start the server

        ./bin/dev

2.  Open the browser and go to `http://localhost:3000`

3.  Watch the tests

        bundle exec guard

## Initial setup

1.  Install PostgreSQL if you haven't already

        brew install postgresql
        brew services start postgresql@14

1.  Install `rvm` if you haven't already

        \curl -sSL https://get.rvm.io | bash -s stable

1.  Install the version of ruby this project uses

        rvm install $(cat .ruby-version)

1.  Once ruby is installed, you can then install bundler

        gem install bundler

1.  Install the gems/dependencies for this project

        cd mybase
        bundle install

1.  Install NodeJS if you haven't already, and then install the node dependencies (which is just `mjml` for emails)

        brew install node
        npm install

1.  Create the database

        rails db:create db:migrate db:seed

1.  Install commit hooks

        overcommit --install

1.  Copy and set the environment variables. Each variable has instructions to follow.

        cp .env.template .env

Now you can use the normal development flow documented above.

## Environment variables

Environment variables are stored in the `.env` file. This is not checked into source control on purpose as some environment variables are secrets (like API keys). You can copy the `.env.template` file to `.env` and set the values accordingly. In production, they are set by the server.

### Adding a new environment variable

Missing an environment variable from configuration have been known to cause issues and downtime. To help prevent that, whenever you add a new environment variable to the `.env` file, you should also add it two other places:

1. Add it to the `.env.template` file so that others will know to set it. Please also document the environment variables with instructions on where to find it or generate it.
1. Add it to the `config/initializers/dotenv.rb` file so that the application will fail to start if the environment variable is missing.

If you see the following error:

    `require_keys': Missing required configuration key: ["MISSING_API_KEY"] (Dotenv::MissingKeys)
    	from /.../mybase/config/initializers/dotenv.rb:8:in `<main>'

It means that an environment variable is missing and should be added to the configuration.

## Email

We use [mjml](https://documentation.mjml.io/) as the templating language for emails. This was chosen after evaluating some other options:

- using a pre-made [template from Postmark](https://github.com/ActiveCampaign/postmark-templates) seemed quite limiting. They are not easy to edit or customize beyond what the template already provides.
- using TailwindCSS via [maizzle](https://github.com/maizzle). To use this we would need to test emails in all the various email clients like crazy as the tooling doesn't prevent you from shooting yourself in the foot.

MJML is annoying to have to learn a new templating language, but the docs are decent and it is limiting in the right way so you don't end up creating emails that look like garbage. The major downside if having to compile those templates using the `mjml` command line tool, which means you need a NodeJS runtime installed even in production. It hasn't been determined if this is a deal breaker yet, but before killing the idea, check out [mrml](https://github.com/sighmon/mjml-rails?tab=readme-ov-file#using-mrml-with-included-binaries).

For background on email/rails options, see: https://www.reddit.com/r/rails/comments/yz4w40/how_to_easily_build_email_templates_with/

### Development

To even sign into the application, you need the magic link in an email. This presents a challenge outside of production where there is no legitimate email sending. We have chosen to use [mailtrap](https://mailtrap.io/email-sandbox/) to solve this in the development environment. You can sign up for a free account and then update the credentials in your `.env` file. The `.env.template` file has instructions for getting the username and password.

We had considered using [mailcatcher](https://mailcatcher.me/), which looks OK, but at the time was not compatible with Ruby 3 and/or Rails 7. We also considered using [letter_opener](https://github.com/ryanb/letter_opener) which worked fine, but is a bit jarring to have a new tab open every time you sign in or receive an email.

By using Mailtrap, you can just keep one tab open to https://mailtrap.io/inboxes and see all the emails that are sent from the application. Plus, they analyze the email for spam and compatibility. Note that the free account is limited to 100 emails per month.
