CREATE TABLE person_need
(
	need_id integer references need(need_id),
	person_id integer references person(person_id)
);
