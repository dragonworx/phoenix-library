#!/bin/bash
set -e

# Check if the database is already initialized
if [ -d "/var/lib/postgresql/data/pgdata" ]; then
    echo "Database already initialized."
else
    echo "Initializing database..."
    # Run the default entrypoint script to initialize the database
    /usr/local/bin/docker-entrypoint.sh postgres &
    pid="$!"

    # Wait for PostgreSQL to start
    until pg_isready -h localhost; do
        sleep 1
    done

    # Run the SQL file to initialize the database
    psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/remote.sql

    # Stop PostgreSQL
    kill "$pid"
    wait "$pid"
fi

# Start PostgreSQL
exec postgres