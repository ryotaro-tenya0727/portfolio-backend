FROM ruby:2.7.4
RUN apt-get update
RUN apt-get install -y build-essential
WORKDIR /api
COPY Gemfile /api/
RUN bundle install
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD bundle exec puma -C config/puma.rb
