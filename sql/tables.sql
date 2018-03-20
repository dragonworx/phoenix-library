-- create user table
CREATE TABLE public.users (
	created timestamp DEFAULT CURRENT_TIMESTAMP,
    modified timestamp DEFAULT CURRENT_TIMESTAMP,
    id integer DEFAULT nextval('user_id_seq'),
    first_name text,
    last_name text,
    email text,
	password text,
	is_admin boolean,
    is_super boolean,
	is_designer boolean,
    last_login timestamp DEFAULT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE public.users
    OWNER to phoenix_lib;

-- create label table
CREATE TABLE public.label (
	created timestamp DEFAULT CURRENT_TIMESTAMP,
    modified timestamp DEFAULT CURRENT_TIMESTAMP,
    id integer DEFAULT nextval('label_id_seq'),
	type integer,
    name text,
	description text,
    color text,
    PRIMARY KEY (id)
);

ALTER TABLE public.label
    OWNER to phoenix_lib;

-- create exercises table
CREATE TABLE public.exercise (
	created timestamp DEFAULT CURRENT_TIMESTAMP,
    modified timestamp DEFAULT CURRENT_TIMESTAMP,
    id integer DEFAULT nextval('exercise_id_seq'),
    name text,
	description text,
	springs text,
    photo text,
    video text,
    thumbnail text,
    PRIMARY KEY (id)
);

ALTER TABLE public.exercise
    OWNER to phoenix_lib;

-- create exercise_label table
CREATE TABLE public.exercise_label (
    created timestamp DEFAULT CURRENT_TIMESTAMP,
    modified timestamp DEFAULT CURRENT_TIMESTAMP,
    exercise_id integer,
    genre_id integer,
    movement_id integer
);

ALTER TABLE public.exercise_label
    OWNER to phoenix_lib;

-- create class_status table
CREATE TABLE public.class_status (
	created timestamp DEFAULT CURRENT_TIMESTAMP,
    modified timestamp DEFAULT CURRENT_TIMESTAMP,
    id integer DEFAULT nextval('class_status_id_seq'),
    name text,
    PRIMARY KEY (id)
);

ALTER TABLE public.class_status
    OWNER to phoenix_lib;

-- create class table
CREATE TABLE public.class (
	created timestamp DEFAULT CURRENT_TIMESTAMP,
	modified timestamp DEFAULT CURRENT_TIMESTAMP,
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
CREATE TABLE public.class_exercise_group (
	created timestamp DEFAULT CURRENT_TIMESTAMP,
    modified timestamp DEFAULT CURRENT_TIMESTAMP,
    id integer DEFAULT nextval('class_exercise_group_id_seq'),
    index smallint,
    class_id integer,
    label_id integer,
    PRIMARY KEY (id)
);

ALTER TABLE public.class_exercise_group
    OWNER to phoenix_lib;

-- create class_group_exercise table
CREATE TABLE public.class_group_exercise (
	created timestamp DEFAULT CURRENT_TIMESTAMP,
    modified timestamp DEFAULT CURRENT_TIMESTAMP,
    id integer DEFAULT nextval('class_group_exercise_id_seq'),
    class_id integer,
    group_id integer,
    PRIMARY KEY (id)
);

ALTER TABLE public.class_group_exercise
    OWNER to phoenix_lib;

-- create test table
CREATE TABLE public.test (
	created timestamp DEFAULT CURRENT_TIMESTAMP,
    modified timestamp DEFAULT CURRENT_TIMESTAMP,
    id integer DEFAULT nextval('test_id_seq'),
    foo text,
    bar text,
    PRIMARY KEY (id)
);

ALTER TABLE public.test
    OWNER to phoenix_lib;
