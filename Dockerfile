# syntax = docker/dockerfile:1
FROM ruby:3.2.3-slim AS base

# Create a directory for the Lambda function
ENV APP_ROOT=/app
RUN mkdir -p ${APP_ROOT}
WORKDIR ${APP_ROOT}

ENV BUNDLE_PATH="/usr/local/bundle"
ENV BUNDLE_WITHOUT="development test"
ENV RACK_ENV="production"

###############################################################
# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages for app build
# Default apt build_stage packages
RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends build-essential curl git jq libxml2 pkg-config unzip

ENV PATH="/usr/local/bundle/bin:${PATH}"
ARG BUNDLE_GITHUB__COM

RUN gem install bundler --no-document
COPY Gemfile Gemfile.lock ./

RUN bundle lock --add-platform $(ruby -e 'puts RUBY_PLATFORM')
RUN bundle install

ARG AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_REGION
ENV AWS_ACCESS_KEY_ID=""
ENV AWS_SECRET_ACCESS_KEY=""
ENV AWS_SESSION_TOKEN=""
ENV AWS_REGION=""

# Copy application code
RUN cp Gemfile.lock Gemfile.lock.bak
COPY . .
RUN mv Gemfile.lock.bak Gemfile.lock

###############################################################
# Final stage for app image
FROM base AS deployment

# Install packages needed for deployment
# Default apt deployment_stage packages
RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends curl libxml2 unzip && rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build $APP_ROOT $APP_ROOT

# Run and own only the runtime files as a non-root user for security
# RUN useradd deploy --create-home --shell /bin/bash
# USER deploy:deploy

CMD ["bin/web"]
