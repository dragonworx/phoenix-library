-- create user sequence
CREATE SEQUENCE user_id_seq
  START 1;

-- create label sequence
CREATE SEQUENCE label_id_seq
  START 1;

-- create label_type sequence
CREATE SEQUENCE label_type_id_seq
  START 1;

-- create exercises sequence
CREATE SEQUENCE exercise_id_seq
  START 1;

-- create class_status sequence
CREATE SEQUENCE class_status_id_seq
  START 1;

-- create class sequence
CREATE SEQUENCE class_id_seq
  START 1;

-- create class_exercise_group sequence
CREATE SEQUENCE class_exercise_group_id_seq
  START 1;

-- create class_group_exercise sequence
CREATE SEQUENCE class_group_exercise_id_seq
  START 1;

-- create test sequence
CREATE SEQUENCE test_id_seq
  START 1;

-- grant phoenix_lib user permission to all sequences
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO phoenix_lib