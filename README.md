# OWL Diff Service

A small webservice written in jruby, that uses the owl2vcs jar (https://github.com/utapyngo/owl2vcs) to create a structural diff between two ontologies hosted online.
This service was build to integrate the owl2vcs diff in a gitlab installation.

## Installation & Usage

Method 1: Jruby
====
1. Install Jruby (very easy via RVM https://rvm.io/)
2. Call `bundle install` from within the project directory
3. `jruby app.rb`
4. Visit `localhost:4567`

Method 2: Docker
====
1. Install Docker https://www.docker.com/
2. Build Docker Image `sudo docker build -t diff_service .`
3. Run it `sudo docker run -p 4567:4567 -it diff-service`
4. Visit `localhost:4567`

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

TODO: Write history

## Credits

TODO: Write credits

## License

TODO: Write license
