CREATE TABLE top_need_word_table (
    palabra_inicio varchar(64),
    macro varchar(128)
);

CREATE OR REPLACE FUNCTION getTop10WordsByMacro() RETURNS void AS $$
declare
    TEMPROW record;
BEGIN
FOR temprow IN
        SELECT * FROM top_10_need_macro_table
    LOOP
        INSERT INTO top_need_word_table
        SELECT pair_words.palabra_inicio, need.macro 
        FROM pair_words, need_pairs, need
        WHERE 
          pair_words.pair_id = need_pairs.pair_id AND
          need_pairs.need_id = need.need_id AND
          need.macro = temprow.macro
        GROUP BY pair_words.palabra_inicio, need.macro
        ORDER BY COUNT(*) DESC LIMIT 10;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM getTop10WordsByMacro();