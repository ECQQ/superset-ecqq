CREATE TABLE need
(
	need_id integer PRIMARY KEY,
	name varchar(128),
	actor varchar(128),
	role varchar(512),
	role_token json,
	macro varchar(128)
);
