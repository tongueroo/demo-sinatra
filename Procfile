# web: bundle exec puma --port 3000
# web: bundle exec rackup config.ru -p ${PORT:-3000}
# web: bin/web
web: bundle exec rackup config.ru -p 3000 -o 0.0.0.0
# Unsure if this Array is valid syntax
# web: ["bundle", "exec", "rackup", "config.ru", "-p", "3000", "-o", "0.0.0.0"]
worker: bin/worker
release: bin/release 1 2 3
