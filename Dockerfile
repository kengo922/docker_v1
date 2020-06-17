FROM ruby:2.6.4
ENV LANG C.UTF-8
ENV APP_ROOT /my_app
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    nodejs \
 && rm -rf /var/lib/apt/lists/* \
 && gem install bundler \
                rails:5.2.3 \
                nokogiri \
                mysql2:0.5.2
WORKDIR $APP_ROOT
COPY Gemfile Gemfile.lock $APP_ROOT/
RUN bundle install --jobs=4 --retry=3
COPY . $APP_ROOT
ENV RAILS_SERVE_STATIC_FILES=1
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
