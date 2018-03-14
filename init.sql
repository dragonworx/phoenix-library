-- create db
CREATE DATABASE phoenix_lib
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

-- create connection user
CREATE USER phoenix_lib WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '****';

-- create users table
CREATE SEQUENCE user_id_seq
  START 1;

CREATE TABLE public.users (
	created date NOT NULL,
    id smallint NOT NULL DEFAULT nextval('user_id_seq'),
    first_name text NOT NULL,
    last_name text,
    email text NOT NULL,
	password text NOT NULL,
	admin boolean,
    PRIMARY KEY (id)
);

ALTER TABLE public.users
    OWNER to phoenix_lib;

-- create labels table
CREATE SEQUENCE labels_id_seq
  START 1;

CREATE TABLE public.labels (
	created date NOT NULL,
    id smallint NOT NULL DEFAULT nextval('labels_id_seq'),
	type smallint NOT NULL,
    name text NOT NULL,
	description text,
    color text,
    PRIMARY KEY (id)
);

ALTER TABLE public.labels
    OWNER to phoenix_lib;

-- create exercises table
CREATE SEQUENCE exercises_id_seq
  START 1;

CREATE TABLE public.exercises (
	created date NOT NULL,
    id smallint NOT NULL DEFAULT nextval('exercises_id_seq'),
    name text NOT NULL,
	description text,
    color text,
    PRIMARY KEY (id)
);

ALTER TABLE public.exercises
    OWNER to phoenix_lib;