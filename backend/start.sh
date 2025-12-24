#!/bin/sh

echo "IDX  PORT $PORT..."
set -e

# Source environment variables if .env file exists
# if [ -f .env ]; then
#   export $(cat .env | sed 's/#.*//g' | xargs)
# fi

# # Ensure PORT is set, default to 8080 if not
# if [ -z "$PORT" ]; then
#   export PORT=8080
# fi

# Start PostgreSQL container
# Redirecting stderr to stdout to avoid "Error:" prefix in some log viewers
docker compose -f ./backend/docker-compose.yml up -d 2>&1

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready on port 5432..."
# Using a more robust check for health status
while [ "$(docker inspect -f '{{.State.Health.Status}}' backend-postgres-1 2>/dev/null)" != "healthy" ]; do
  sleep 1
done

# Run database migrations
echo "Running database migrations..."
# migrate output can be noisy and sent to stderr, redirecting to stdout
migrate -path backend/migrations -database "postgres://${DB_USER}:${DB_PASSWORD}@localhost:5432/${DB_NAME}?sslmode=disable" up 2>&1 || echo "Migration finished (might have had no changes)"

# Start the application with nodemon
echo "Starting application with nodemon on PORT $PORT..."
# Using exec to replace the shell process with nodemon
exec nodemon --watch backend --ext go --exec "go run backend/cmd/api/app.go"
