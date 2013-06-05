[![Build Status](https://travis-ci.org/codeforamerica/landshark.png?branch=master)](https://travis-ci.org/codeforamerica/landshark)

# LandShark
### A text message reminder system for San Francisco Human Services Agency

This is just a basic rails app right now. 
#### Here is how to install:
1) Make sure you have rails
```
gem install rails
```
2) Grab a copy of this code
```
git clone https://github.com/codeforamerica/landshark.git
```
3) Install everything you need
```
cd landshark
bundle update
```
4) Setup your environment

You'll need to setup your environment variables. Heroku has a good overview <a href="https://devcenter.heroku.com/articles/config-vars">here</a>. You can store these in an .env file in your root directory. You'll want things like your Twilio account info to go in here. *Make sure you don't put your environment variables on github or otherwise expose them publicly!*

5) Start up your server
```
rails s
```
6) You should see the project at http://localhost:3000

<a href="#"><img src="https://a248.e.akamai.net/camo.github.com/e8ce7fcd025087eebe85499c7bf4b5ac57f12b1e/687474703a2f2f73746174732e636f6465666f72616d65726963612e6f72672f636f6465666f72616d65726963612f6366615f74656d706c6174652e706e67" alt="codeforamerica"/></a>