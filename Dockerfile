FROM ruby:3.0.4

WORKDIR /blog

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

COPY Gemfile .

COPY Gemfile.lock .

RUN bundle install

COPY . .

RUN rails db:seed
RUN rails tailwindcss:install
RUN rails assets:precompile

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
