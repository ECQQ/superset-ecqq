CREATE TABLE need_pairs
(
	need_id integer references need(need_id),
	pair_id integer references pair_words(pair_id)
);
