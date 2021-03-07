# Start with Ruby base image
FROM ruby:2.6.0

ENV RAILS_ROOT /var/www/factoro
RUN mkdir -p $RAILS_ROOT

# Set working directory
WORKDIR $RAILS_ROOT

# Setting env up
ENV RAILS_ENV='production'
ENV RAKE_ENV='production'

# Install bundler 2
#RUN gem install bundler -v 2.2.12

# Adding gems
COPY Gemfile Gemfile

# Add Gemfile lock
COPY Gemfile.lock Gemfile.lock

# Install dependencies
RUN bundle install --jobs 20 --retry 5 --without development test

# Adding project files
COPY . .

# Run the workers
# Output the date as a first line, to trigger logging
CMD date && crono