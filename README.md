My Three Best
-------------


Setup
=======
In App directory run the bundle command to install pending dependencies:

     bundle install --without staging production

Create database if you don't have it already

     rake db:create

Run any pending migration

     rake db:create


Running
========
Start application using rails server command:

     rails s

You can use also Thin instead of default WEBRick:

     rails s thin
