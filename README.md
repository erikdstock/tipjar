![travis](https://travis-ci.org/erikdstock/tipjar.svg?branch=master)
[![Test Coverage](https://codeclimate.com/github/erikdstock/tipjar/badges/coverage.svg)](https://codeclimate.com/github/erikdstock/tipjar/coverage)
[![Code Climate](https://codeclimate.com/github/erikdstock/tipjar/badges/gpa.svg)](https://codeclimate.com/github/erikdstock/tipjar)

# tipjar
Favorite Musician Processor.
Tip bands you love since you don't pay for music any more.

## Build and run
This build uses docker. It's easy.
* copy .docker.env.example to .docker.env and fill in the values
* With a docker machine or docker for mac active:
  * `docker-compose up` to run the app
  * `docker-compose run app rake` to run tests

### Thanks - sources
- https://semaphoreci.com/community/tutorials/dockerizing-a-ruby-on-rails-application for heavy inspiration on docker-compose structure
- https://github.com/eadonj/multiple_oauth_with_devise for approach to multiple account oauths
