CREATE TABLE needs
(
	need_id integer PRIMARY KEY,
	name varchar(16),
	actor varchar(16),
	role varchar(256),
	role_token json,
	macro varchar(128)
);
