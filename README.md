# VolunteerUP

VolunteerUP is an app that connects nonprofit organizations with eager volunteers. Users are able to register as volunteers, search for events in their area, and sign up for events as volunteers. Users are also able to register as organizers that administer their nonprofit organization pages, create a calendar of events, and request volunteers.

## Heroku Demo

https://volunteerup.herokuapp.com/

## Ruby Version

ruby 2.2.6

## Rails Version

5.0

## Database creation and configuration
In order to set up the database run the following commands:

```BASH
rake db:drop
rake db:create
rake db:migrate
rake db:setup
```

In order to run test using the seeded database, use the following commands after migrations:

```BASH
rake db:seed RAILS_ENV=test --trace
```

## To Seed Heroku Database
Instead of dropping the whole database, run this command to add more events: `heroku run rake db:seed extra=yes`
