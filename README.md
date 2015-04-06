[ ![Codeship Status for postcode/promptly](https://www.codeship.io/projects/ec855670-2bd6-0132-f980-1e923bfe56e2/status)](https://www.codeship.io/projects/38700)
[![Build Status](https://travis-ci.org/postcode/promptly.png?branch=master)](https://travis-ci.org/postcode/promptly)
[![Stories in Ready](https://badge.waffle.io/codeforamerica/promptly.png?label=ready)](https://waffle.io/codeforamerica/promptly)


# Promptly
Promptly is a text message notification system originally built by 2013 Code for America fellows for the San Francisco Human Services Agency. See [promptly.io](http://promptly.io) for more info on the project. See our [wiki](https://github.com/postcode/promptly/wiki) for documentation.

### Contribute
This project is not actively maintained.

### Requirements

Promptly is a Ruby on Rails application that uses Twilio to send text messages.

If you need help setting up RVM, Ruby, and all that stuff, we recommend [Moncef's](http://about.me/moncef) great tutorial on [setting up a Mac for development with Xcode, Homebrew, Git, RVM & Ruby](http://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/).

If you are installing on Windows try [RailsInstaller](http://railsinstaller.org/en). Installing Rails on Windows can be tricky. There is a fork that is being actively developed within a Windows environment at SF HSA. You can have a look at their fork here: [https://github.com/sf-hsa/promptly](https://github.com/sf-hsa/promptly) Some users have run into an error bundling on Windows because of a `kgio` error. See [http://stackoverflow.com/questions/11199620/rails-on-windows-without-kgio](http://stackoverflow.com/questions/11199620/rails-on-windows-without-kgio) For a solution, hint: you can comment out `gem unicorn` and use a different web server for local development.

You'll also need to setup a [Twilio account](https://www.twilio.com/) and buy a Twilio phone number. You can get a development phone number for free but you'll need to pay to send text messages. [Check our their pricing](https://www.twilio.com/sms/pricing).

### Install locally
1) Install Bundler
```sh
$ gem install bundler
```

2) Install the Heroku Toolbelt: [https://toolbelt.heroku.com/](https://toolbelt.heroku.com/)

3) Install and run PostgreSQL
- Mac: http://postgresapp.com/
- Other: http://www.postgresql.org/

Make sure PostgreSQL is running. If you're using Postgres.app, just run the application and then look for a cute elephant in the menu bar.

4) Clone this repo
```sh
$ git clone https://github.com/postcode/promptly.git
```

5) Install required gems
```sh
$ cd promptly
$ bundle install
```

6) Configure environment variables by renaming **.sample_env** to **.env** and adding your (secret) keys
```sh
$ mv .sample_env .env
```

Promptly requires the following environment variables:
- TWILIO_NUMBER is your Twilio phone number (just numbers, no punctuation)
- TWILIO_SID is your Twilio account SID 
- TWILIO_TOKEN is your twilio auth token
- SECRET_TOKEN is used to prevent cookie tampering. Run `$ rake secret` to get a pseudo-random key to use.

Add one variable per line in the .env file like this:
```
TWILIO_NUMBER=5105555555
TWILIO_SID=AC1365ff47...
...
```

7) Create the file **config/database.yml**
Insert the text below into database.yml. You will have to include your PostgreSQL username. Postgres.app creates a default user $USER with no password. Otherwise you'll have to make one yourself.

```ruby
development:
  adapter: postgresql
  host: localhost
  username: [PostgreSQL username]
  #password: [Optional PostgreSQL password]
  database: promptly
```

8) Setup the database
```sh
$ rake db:setup

# Equivalent to:
# rake db:create
# rake db:schema:load
# rake db:seed
```

9) Start the server
```sh
$ foreman start
```
You should see something this in the console:

```
12:01:14 worker.1 | started with pid 3228
12:01:14 web.1    | started with pid 3227
12:01:16 web.1    | I, [2013-11-11T12:01:16.139986 #3227]  INFO -- : listening on addr=0.0.0.0:5000 fd=7
12:01:16 web.1    | I, [2013-11-11T12:01:16.140103 #3227]  INFO -- : worker=0 spawning...
12:01:16 web.1    | I, [2013-11-11T12:01:16.142336 #3227]  INFO -- : master process ready
12:01:16 web.1    | I, [2013-11-11T12:01:16.144046 #3229]  INFO -- : worker=0 spawned pid=3229
12:01:16 web.1    | I, [2013-11-11T12:01:16.144531 #3229]  INFO -- : Refreshing Gem list
12:01:20 web.1    | I, [2013-11-11T12:01:20.205813 #3229]  INFO -- : worker=0 ready
```

You can now visit Promptly at <a href="http://localhost:5000">http://localhost:5000</a>

You can sign in with email=**admin@example.com** and pass=**administrator**.

### Deploy to Heroku
[Signup for Heroku](https://id.heroku.com/signup) if you havn't already.

1) Create a Heroku app and push your code
```sh
$ heroku login
$ heroku create
$ git push heroku master
```

2) Add the Heroku PostgreSQL addon and promote it
```sh
$ heroku addons:add heroku-postgresql
$ heroku pg:promote HEROKU_POSTGRESQL_[YOUR COLOR]_URL
```

3) Configure Heroku environment variables
```sh
$ heroku config:add TWILIO_NUMBER=[your Twilio phone number]
```
Repeat for TWILIO_SID, TWILIO_TOKEN, and SECRET_TOKEN using the values from your .env file ([see above for details](#install-locally)).

4) Setup the database
```sh
$ heroku run rake db:setup
```

At this point you can run `$ heroku open` to see the project. We're almost done!

5) Add a worker dyno

Promptly requires a worker dyno to queue the text message reminders. Please note this will **cost you money**. See the Heroku dev center for details on [delayed job](https://devcenter.heroku.com/articles/delayed-job) and [pricing](https://devcenter.heroku.com/categories/billing).

```sh
$ heroku ps:scale worker=1
```

6) Add the Heroku scheduler addon

For annoying reasons we won't go into here, Promptly requires a periodic rake task to update the conversations model with incoming text messages from users. You can do this on Heroku using the scheduler addon.

```sh
$ heroku addons:add scheduler
$ heroku addons:open scheduler
```
Run the task `rake update_conversations` every 10 minutes:
![heroku scheduler addon](http://postcode.github.io/promptly/heroku-scheduler-addon.png)

7) Change the admin password
```sh
$ heroku open
```

Sign in with email=**admin@example.com** and password=**administrator**. Click *Welcome, Admin* in the top right and update your password.

And you're all set!

<a href="#"><img src="https://a248.e.akamai.net/camo.github.com/e8ce7fcd025087eebe85499c7bf4b5ac57f12b1e/687474703a2f2f73746174732e636f6465666f72616d65726963612e6f72672f636f6465666f72616d65726963612f6366615f74656d706c6174652e706e67" alt="codeforamerica"/></a>
