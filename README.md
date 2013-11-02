[![Build Status](https://travis-ci.org/codeforamerica/promptly.png?branch=master)](https://travis-ci.org/codeforamerica/promptly)

# Promptly
Promptly is a text message notification system originally built by 2013 Code for America fellows for the San Francisco Human Services Agency. [See the Code for America website](http://codeforamerica.org/?cfa_app=promptly) for more info on the project.

### Contribute
This project is young and in flux. Feel free to email sf@codeforamerica.org if you're interested in deploying or contributing.

### Requirements
Promptly is a Ruby on Rails application that uses Twilio to send out text messages.

If you need help setting up RVM, Ruby, and all that stuff, we recommend you check out [Moncef's](http://about.me/moncef) great tutorial on [setting up a Mac for development with Xcode, Homebrew, Git, RVM & Ruby](http://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/).

You'll also need to setup a [Twilio account](https://www.twilio.com/) and buy a phone number to use. You can get a development phone number for free but you'll need to pay to send out text messages. [Check our their pricing](https://www.twilio.com/sms/pricing).

### Install locally
1) Install Bundler
```sh
$ gem install bundler
```

2) Install the Heroku Toolbelt: [https://toolbelt.heroku.com/](https://toolbelt.heroku.com/)

3) Install PostgreSQL
- Mac: http://postgresapp.com/
- Other: http://www.postgresql.org/

4) Create a PostgreSQL application database
Open psql and run: `# create database promptly;`

5) Clone this repo
```sh
$ git clone https://github.com/codeforamerica/promptly.git
```

6) Install required gems
```sh
$ cd promptly
$ bundle install
```

7) Configure environment variables by renaming **.sample_env** to **.env** and editing it.
Promptly requires the following environment variables:
- TWILIO_NUMBER is your Twilio phone number (just numbers, no punctuation)
- TWILIO_SID is your Twilio account SID 
- TWILIO_TOKEN is your twilio auth token
- SECRET_TOKEN is used to prevent cookie tampering. Run `rake secret` to get a pseudo-random key to use.
- DATABASE_URL is the connection string to your database.
  - It should look like this: `postgres://<username>:<password>@<host>/<dbname>`
  - `<password>` is null by default, so omit the entire `:<password>` component
  - `<host>` is `localhost` for now
  - `<dbname>` is `promptly` (we created this in step #3)

*Confirm your .gitignore includes /.env so you don't publicize these keys!*

8) Create **config/database.yml** and leave it blank
Yes, this is just a [bug with rails](https://github.com/rails/rails/pull/9120).

9) Load database schema
```sh
$ rake db:schema:load
```

10) Start the server
```sh
$ foreman start
```
You should see the project at <a href="http://localhost:5000">http://localhost:5000</a>

11) Create a Promptly user
If you want to do anything in Promptly, you'll need to create an admin user from the command line

Run `$foreman run rails c` to start the rails console.

Then create a user:
```ruby
> User.create(
    :name => "Admin",
    :email => "admin@example.com",
    :password => "temppass",
    :password_confirmation => "temppass",
    :roles_mask => 1
)
```
Now you can login with admin@example.com/temppass at 
[http://localhost:5000/users/sign_in] and change your password at [http://localhost:5000/users/edit].

### Deploy to Heroku

<a href="#"><img src="https://a248.e.akamai.net/camo.github.com/e8ce7fcd025087eebe85499c7bf4b5ac57f12b1e/687474703a2f2f73746174732e636f6465666f72616d65726963612e6f72672f636f6465666f72616d65726963612f6366615f74656d706c6174652e706e67" alt="codeforamerica"/></a>