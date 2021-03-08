# README

This project contains the solution for the planets problem. Built with Rails 6.

It runs on Docker living in a Digital Ocean public droplet.

The droplet is accesible through the IP: 159.89.46.130

4 api methods are exposed:

- GET /planets
- GET /planets/:id
- GET /weather?page=1&size=20
- GET /weather/:day

Things you may want to cover:

* Ruby version
2.6

* Database creation
rake db:create

* Database initialization
rake db:migrate

* How to run the test suite
rspec

* Services (job queues, cache servers, search engines, etc.)


* Deployment instructions
