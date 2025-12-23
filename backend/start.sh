#!/bin/sh
set -e

docker compose  -f ./backend/docker-compose.yml  up -d

# if [ -f .env ]; then
#   export $(cat .env | sed 's/#.*//g' | xargs)
# fi

echo "Running database migrations..."
migrate -path backend/migrations -database "postgres://${DB_USER}:${DB_PASSWORD}@localhost:5432/${DB_NAME}?sslmode=disable" up

echo "Starting application with nodemon $PORT ..."
nodemon --watch backend -e go --exec "go run backend/cmd/api/app.go"
