![travis](https://travis-ci.org/erikdstock/tipjar.svg?branch=master)
[![Test Coverage](https://codeclimate.com/github/erikdstock/tipjar/badges/coverage.svg)](https://codeclimate.com/github/erikdstock/tipjar/coverage)
[![Code Climate](https://codeclimate.com/github/erikdstock/tipjar/badges/gpa.svg)](https://codeclimate.com/github/erikdstock/tipjar)

# tipjar
Tip bands you love since you don't pay for music any more.

## Build and run
This build uses docker.
* copy .docker.env.example to .docker.env and fill in the values
* With a docker machine active:
  * `docker-compose build` (takes about 10 minutes)
  * `docker-compose up` to run the app
  * `docker-compose run app rake spec` to run tests

### Progress
  Currently working on the back end, fetching and parsing top artists from lastfm and running jobs to update their data in the background. next step will be fuller integration with the give.to api and views to support it.
  REACT EH

### Thanks - sources
- https://semaphoreci.com/community/tutorials/dockerizing-a-ruby-on-rails-application
