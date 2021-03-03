CREATE VIEW person_view AS

SELECT 
	person_id,
	age,
	sex,
	level as education,
	age_range, 
	region.iso as region_iso, 
	region.name as region_name, 
	region.numero as region_number, 
	comuna.name as comuna_name,
	dialogue.date as date

FROM
	person,
	comuna,
	region,
	dialogue
LEFT JOIN person ON person.comuna = comuna.id
LEFT JOIN comuna ON comuna_region_iso = region.iso
LEFT JOIN person ON person.file_id = dialogue.file_id;
