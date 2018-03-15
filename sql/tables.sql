-- create user table
CREATE SEQUENCE user_id_seq
  START 1;

CREATE TABLE public.users (
	created date DEFAULT CURRENT_DATE,
    modified date DEFAULT CURRENT_DATE,
    id integer DEFAULT nextval('user_id_seq'),
    first_name text,
    last_name text,
    email text,
	password text,
	is_admin boolean,
	is_designer boolean,
    PRIMARY KEY (id)
);

ALTER TABLE public.users
    OWNER to phoenix_lib;

-- create label table
CREATE SEQUENCE label_id_seq
  START 1;

CREATE TABLE public.label (
	created date DEFAULT CURRENT_DATE,
    modified date DEFAULT CURRENT_DATE,
    id integer DEFAULT nextval('label_id_seq'),
	label_type_id integer,
    name text,
	description text,
    color text,
    PRIMARY KEY (id)
);

ALTER TABLE public.label
    OWNER to phoenix_lib;

-- create label_type table
CREATE SEQUENCE label_type_id_seq
  START 1;

CREATE TABLE public.label_type (
	created date DEFAULT CURRENT_DATE,
    modified date DEFAULT CURRENT_DATE,
    id integer DEFAULT nextval('label_type_id_seq'),
    name text,
    is_root boolean,
    PRIMARY KEY (id)
);

ALTER TABLE public.label_type
    OWNER to phoenix_lib;

-- create exercises table
CREATE SEQUENCE exercise_id_seq
  START 1;

CREATE TABLE public.exercise (
	created date DEFAULT CURRENT_DATE,
    modified date DEFAULT CURRENT_DATE,
    id integer DEFAULT nextval('exercise_id_seq'),
    name text,
	description text,
	springs smallint,
    photo_ref text,
    video_ref text,
    PRIMARY KEY (id)
);

ALTER TABLE public.exercise
    OWNER to phoenix_lib;

-- create categorisations table
CREATE TABLE public.categorisation (
    created date DEFAULT CURRENT_DATE,
    modified date DEFAULT CURRENT_DATE,
    exercise_id integer,
    parent_label_id integer,
    label_id integer
);

ALTER TABLE public.categorisation
    OWNER to phoenix_lib;

-- create categorisation_nesting table
CREATE TABLE public.categorisation_nesting (
    created date DEFAULT CURRENT_DATE,
    modified date DEFAULT CURRENT_DATE,
    parent_label_id integer,
    child_label_id integer
);

ALTER TABLE public.categorisation_nesting
    OWNER to phoenix_lib;

-- create class_status table
CREATE SEQUENCE class_status_id_seq
  START 1;

CREATE TABLE public.class_status (
	created date DEFAULT CURRENT_DATE,
    modified date DEFAULT CURRENT_DATE,
    id integer DEFAULT nextval('class_status_id_seq'),
    name text,
    PRIMARY KEY (id)
);

ALTER TABLE public.class_status
    OWNER to phoenix_lib;

-- create class table
CREATE SEQUENCE class_id_seq
  START 1;

CREATE TABLE public.class (
	created date DEFAULT CURRENT_DATE,
	modified date DEFAULT CURRENT_DATE,
    id integer DEFAULT nextval('class_id_seq'),
    name text,
    status_id integer,
    label_id integer,
    designer_user_id integer,
    notes text,
    PRIMARY KEY (id)
);

ALTER TABLE public.class
    OWNER to phoenix_lib;

-- create class_exercise_group table
CREATE SEQUENCE class_exercise_group_id_seq
  START 1;

CREATE TABLE public.class_exercise_group (
	created date DEFAULT CURRENT_DATE,
    modified date DEFAULT CURRENT_DATE,
    id integer DEFAULT nextval('class_exercise_group_id_seq'),
    index smallint,
    class_id integer,
    label_id integer,
    PRIMARY KEY (id)
);

ALTER TABLE public.class_exercise_group
    OWNER to phoenix_lib;

-- create class_group_exercise table
CREATE SEQUENCE class_group_exercise_id_seq
  START 1;

CREATE TABLE public.class_group_exercise (
	created date DEFAULT CURRENT_DATE,
    modified date DEFAULT CURRENT_DATE,
    id integer DEFAULT nextval('class_group_exercise_id_seq'),
    class_id integer,
    group_id integer,
    PRIMARY KEY (id)
);

ALTER TABLE public.class_group_exercise
    OWNER to phoenix_lib;
