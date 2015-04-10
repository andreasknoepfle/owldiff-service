# OWL Diff Service

[![Build Status](https://travis-ci.org/andreasknoepfle/owldiff-service.svg?branch=master)](https://travis-ci.org/andreasknoepfle/owldiff-service) [![Code Climate](https://codeclimate.com/github/andreasknoepfle/owldiff-service/badges/gpa.svg)](https://codeclimate.com/github/andreasknoepfle/owldiff-service) [![Test Coverage](https://codeclimate.com/github/andreasknoepfle/owldiff-service/badges/coverage.svg)](https://codeclimate.com/github/andreasknoepfle/owldiff-service)

A small webservice written in jruby, that uses the owl2vcs jar (https://github.com/utapyngo/owl2vcs) to create a structural diff between two ontologies hosted online.
This service was build to integrate the owl2vcs diff in a gitlab installation.

## Installation & Usage

### Method 1: Jruby

1. Install Jruby (very easy via RVM https://rvm.io/)
2. Call `bundle install` from within the project directory
3. `jruby app.rb`
4. Visit `localhost:4567`

### Method 2: Docker

1. Install Docker https://www.docker.com/
2. Build Docker Image `sudo docker build -t diff-service .`
3. Run it `sudo docker run -p 4567:4567 -it diff-service`
4. Visit `localhost:4567`

### Method 3: WAR File

1. Install Jruby (s.o.)
2. Call `bundle install`
3. Call `warble`
4. Copy the created WAR-Archive to any Java Application Server Container (e.g. Jetty)

## Demo

A Demo runs on heroku

https://peaceful-escarpment-8597.herokuapp.com/

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Tests

Execute tests with
`ruby test.rb`

### Dismiss coverage warning
`export JRUBY_OPTS="$JRUBY_OPTS --debug"`


## Thanks to OWL2VCS

https://github.com/utapyngo/owl2vcs

## License

LGPL v3
