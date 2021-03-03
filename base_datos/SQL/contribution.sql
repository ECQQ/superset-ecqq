CREATE TABLE contribution
(
	con_id integer PRIMARY KEY,
	text varchar(256),
	tokens json,
	macro varchar(64)
);
