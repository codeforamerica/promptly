# LandShark
A text message reminder system for San Francisco Human Services Agency.

#### Contribute
This project is young and in flux. Feel free to email sf@codeforamerica.org if you're interested in deploying or contributing.

#### Install
1) Install Rails and bundler if you don't already have them
```
gem install rails
gem install bundler
```

2) Clone this repo
```
git clone https://github.com/codeforamerica/landshark.git
```

3) Install required gems
```
cd landshark
bundle install
```

4) Setup environment variables

LandShark requires four env vars: RACK_ENV, TWILIO_NUMBER, TWILIO_SID, and TWILIO_TOKEN.

There are many ways to do this. Heroku has a good overview <a href="https://devcenter.heroku.com/articles/config-vars">here</a>. The easiest way is to use foreman and a .env file in the root directory. You can edit .sample_env and rename it to .env.

*Make sure your .gitignore includes /.env so you don't publicize your secret keys.*

5) Start the server
```
foreman start
```

6) You should see the project at http://localhost:5000

<a href="#"><img src="https://a248.e.akamai.net/camo.github.com/e8ce7fcd025087eebe85499c7bf4b5ac57f12b1e/687474703a2f2f73746174732e636f6465666f72616d65726963612e6f72672f636f6465666f72616d65726963612f6366615f74656d706c6174652e706e67" alt="codeforamerica"/></a>