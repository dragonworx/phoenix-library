Copyright 2018 Ali Chamas, Liz Chamas - all rights reserved.

# Installing Postgres

Docker can be used to install Postgres and provide a `postgres1` container with exposed ports to the host.

Created a bridged network:

`docker network create --driver bridge postgres-network`

Then create a container from the postgres image.

`docker run --name postgres1 --network postgres-network -v /home/ali/pgdata:/var/lib/postgresql/data -e POSTGRES_DB=phoenix_lib -e POSTGRES_USER=phoenix_lib -e POSTGRES_PASSWORD=Escher01! -d -p 5432:5432 postgres`

Start the container, no need to build after first time:

`docker start postgres1`

Stop the container if needed:

`docker stop postgres1`

Remove the container if needed, to rebuild.

`docker rm postgres1`

Run pgadmin:

`docker run --name pgadmin --network postgres-network -p 8080:80 -e "PGADMIN_DEFAULT_EMAIL=user@example.com" -e "PGADMIN_DEFAULT_PASSWORD=admin" -d dpage/pgadmin4`

# Environment Variables

Export postgres connection settings.

```
export PHOENIX_DB=phoenix_lib
export PHOENIX_USER=phoenix_lib
export PHOENIX_PASSWORD=Escher01!
```

Export the storage settings.

```
export MASSTORAGE_KEY_ID=<app_key>
export MASSTORAGE_SECRET=<secret>
export PHOENIX_ENV=<env>
```

## Initialising Database

For first time setup - in postgres admin client, execute in order:

* `./sql/db_user.sql` to create database and access user.
* `./sql/sequences.sql` to create autoincrement sequences
* `./sql/tables.sql` to create tables
* `./sql/admin.sql` to create admin user

For existing database - If moving from dev to prod, **backup** local db and **restore** on prod. Reverse is true to bring down prod for local testing

# Building

## Custom Postgres Database

To build the Docker image from the Dockerfile, tag it as phoenixdb, and push it to AWS ECR, follow these steps:
Build the Docker image:

`docker build -t phoenixdb:latest -f Dockerfile .`

Tag the new image:

`docker tag phoenixdb:latest 431067074586.dkr.ecr.ap-southeast-2.amazonaws.com/phoenix/lib:latest`

Log in to your AWS ECR (Elastic Container Registry):
`aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin
431067074586.dkr.ecr.ap-southeast-2.amazonaws.com`

Push the image to AWS ECR:

`docker push 431067074586.dkr.ecr.ap-southeast-2.amazonaws.com/phoenix/lib:latest`

## Server

The server tier is the express app which provides the view routes and apis.

This is built with:

* `yarn server-dev` - run locally for development, uses `nodemon` to restart app when changes in `./server` are detected.
* `yarn server` - run for production as is.

## Client

The client tier is the React/Material UI web front end. It provides the member and admin sections.

This is built with:

* `yarn build-watch` - build for local development, watches for changes and rebuilds.
* `yarn build` - build for prod development.

Each build produces bundle files in the `./static` folder, according to the builds defined in the webpack config.

Database must be running, client bundles must be built, and server must be running to use app.
