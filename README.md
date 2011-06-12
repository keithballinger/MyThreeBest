My Three Best
-------------


Setup
=======
Install Redis using your package manager or compile and install it from
sources.

In App directory run the bundle command to install pending dependencies:

     bundle install --without staging production

Create database if you don't have it already

     rake db:create

Run any pending migration

     rake db:create


Running App
============
Before run application you must start Redis server, ex.:

     $ redis-server

Start application using Foreman:

     foreman start

Running Tests
==============
All the code is tested using RSpec, you can run specs with:

     rake spec

Before run tests you must run Redis and Resque (sorry, I'm working in
avoid it on tests)

You can use Spork for run your tests fasters and InfinityTest for
continous testing
