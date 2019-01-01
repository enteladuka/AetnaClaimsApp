### DEVELOPMENT ###
FROM ruby:2.5.1-alpine3.7 as development

RUN apk update && \
    apk add postgresql-dev nodejs alpine-sdk less tzdata && \
    rm -rf /var/cache/apk/*

WORKDIR /app

RUN adduser \
  # Login shell
  -s /bin/sh \
  # User id
  -u 1001 \
  # Group
  -G root \
  # Home directory
  -h /app \
  # Create a system user
  -S \
  # Don't assign a password
  -D rails \
  && chown rails /app

USER rails

COPY --chown=rails:root . .

ENV BUNDLE_PATH vendor/bundle
RUN bundle install --jobs=4 --without development test
RUN bundle clean

CMD echo "Run ./script/server for the mounts n stuff."

### PRODUCTION ###
FROM development as production

ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true

RUN bin/rails assets:precompile

EXPOSE 8080
CMD ["bin/rails", "server", "--port=8080"]
