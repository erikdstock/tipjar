FROM ruby:2.3.1
# ENTRYPOINT ["bundle", "exec"]
# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1
ENV INSTALL_PATH /src
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH



# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - npm: Install node modules
# - yarn: Install & manage node modules [should make npm obsolete]
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client-9.4: In case you want to talk directly to postgres
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -qq -y build-essential nodejs yarn \
  libpq-dev postgresql-client-9.4 --fix-missing --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

COPY app/Gemfile* ./

# Bundle
RUN echo $BUNDLE_PATH && bundle install

COPY app .

# Unclobber the updated gemfile.lock
# RUN mv $bundle_path/Gemfile.lock ./

# For puma (rails default in script)
CMD ["rails", "s", "-b", "0.0.0.0"]
# The default command that gets ran will be to start the Unicorn server. [NOT USING]
# CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb"]