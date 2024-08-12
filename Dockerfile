FROM ruby:3.2.5
ENV TZ Asia/Tokyo
RUN apt-get update
RUN apt-get install -y build-essential \
  libpq-dev \
  sudo
WORKDIR /backend
COPY Gemfile /backend/
RUN gem update --system
RUN bundle install
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD bundle exec puma -C config/puma.rb
