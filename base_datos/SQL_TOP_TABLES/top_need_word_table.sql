CREATE TABLE top_need_word_table AS

SELECT palabra_inicio 
FROM pair_words
GROUP BY palabra_inicio
ORDER BY COUNT(*) DESC LIMIT 50;
