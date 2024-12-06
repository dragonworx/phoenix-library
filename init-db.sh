#!/bin/bash
set -e

# Check if the database is already initialized
if [ -d "/var/lib/postgresql/data/pgdata" ]; then
    echo "Database already initialized."
else
    echo "Initializing database..."
    
    # More specific pg_isready command with all connection parameters
    until pg_isready -h "localhost" -p 5432 -U "$POSTGRES_USER"; do
        echo "Waiting for PostgreSQL to start..."
        sleep 1
    done

    echo "PostgreSQL is ready. Running initialization SQL..."
    PGPASSWORD="$POSTGRES_PASSWORD" psql -h localhost -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/remote.sql
fi

# Don't exit - let the script continue to the main postgres process