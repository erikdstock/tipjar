FROM erikdstock/ruby-yarn
# ENTRYPOINT ["bundle", "exec"]
# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1
ENV INSTALL_PATH /src
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY src/Gemfile* src/package.json ./

# Bundle
RUN echo $BUNDLE_PATH && bundle install && yarn install

COPY src .

# For puma in development mode [+ webpack task]
CMD ["foreman", "start"]
# The default command that gets ran will be to start the Unicorn server. [NOT USING]
# CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb"]
