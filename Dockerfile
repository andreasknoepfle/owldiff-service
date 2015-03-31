FROM jruby
ADD . /home/www
WORKDIR /home/www

ENV RACK_ENV production

# Install bundler to handle gem dependencies
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc

RUN gem install bundler --no-ri --no-rdoc

# install all gems required by the application
RUN bundle install --without test development

EXPOSE 4567

# This will be run when you call "docker run..."

CMD ["jruby","app.rb","-s","Puma"]
