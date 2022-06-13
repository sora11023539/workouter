FROM ruby:3.0.2

RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN set -x && apt-get update -y -qq && apt-get install -yq nodejs yarn

# 「app」と書かれている部分はディレクトリ名に応じて変更します。
RUN mkdir /workouter
WORKDIR /workouter
COPY Gemfile /workouter/Gemfile
COPY Gemfile.lock /workouter/Gemfile.lock
RUN bundle install
COPY . /workouter
