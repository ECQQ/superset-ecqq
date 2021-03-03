CREATE VIEW top_50_emo AS
	
SELECT 
	p.person_id, 
	p.sex, p.education, 
	p.region_iso, 
	p.region_name, 
	p.comuna_name, 
	p.date, 
	p.age, 
	p.age_range, 
	e.name
	
FROM 
	person_view as p, 
	emotion as e, 
	person_emotion as pe
WHERE 
	p.person_id=pe.person_id AND 
	e.emo_id=pe.emo_id AND 
	e.name IN 
		(SELECT e.name from emotion as e, person_emotion as pe WHERE pe.emo_id=e.emo_id GROUP BY name ORDER BY COUNT(*) DESC LIMIT 50);
