#!/bin/bash

# Crea las tablas de emociones y contribuciones definidas en SQL_TOP_TABLES


puerto=5432
rol=superset
db=ecqq

create_table=`docker exec -it superset_db psql -h localhost -p $puerto -U $rol -c `
copy_csv=`docker exec -it superset_db psql -h localhost -p $puerto -U $rol -c `

echo "Borrando antigua bd $db"
docker exec -it superset_db  psql -h localhost -p 5432 -U superset -c "DROP DATABASE $db;"


echo "Creando bd $db"
docker exec -it superset_db psql -h localhost -p $puerto -U $rol -c "CREATE DATABASE $db;"
docker exec -it superset_db psql -h localhost -p $puerto -U $rol $db  -c "ALTER DATABASE $db SET datestyle TO \"ISO, DMY\";"
	
echo "Copiando archivos al contenedor"
	
docker cp CSV superset_db:/data

tables=(region comuna dialogue person emotion need pair_words need_pairs contribution person_contribution person_emotion person_need)

views=(person_view contribution_view need_view top_10_con_view top_50_con_view top_10_emo_view top_50_emo_view top_need_views)

tops=(top_10_con_table top_10_emo_table top_50_con_table top_50_emo_table top_need_word_table top_10_need_macro_table)

for file in "${tables[@]}"; do
	echo "creando tabla $file"
	table=$(cat SQL/$file.sql)
	docker exec -it superset_db psql -h localhost -p $puerto -U $rol $db -c "$table"
	echo "poblando $file"	
	if [[ "$file" == "contribution" ]]; then
		docker exec -it superset_db psql -h localhost -p $puerto -U $rol $db -f /data/CSV/contribution_data.sql
	elif [[ "$file" == "need" ]]; then
		docker exec -it superset_db psql -h localhost -p $puerto -U $rol $db -f /data/CSV/need_data.sql	
	else
		csv_query="COPY $file FROM '/data/CSV/$file.csv' WITH DELIMITER ',' CSV HEADER;"	
		docker exec -it superset_db psql -h localhost -p $puerto -U $rol $db  -c "$csv_query"	
	fi
done

for file in "${tops[@]}"; do
	echo "creando tabla $file"
	top=$(cat SQL_TOP_TABLES/$file.sql)
	docker exec -it superset_db psql -h localhost -p $puerto -U $rol $db -c "$top"		
done


for file in "${views[@]}"; do
	echo "creando vista $file"
	view=$(cat VIEWS_SQL/$file.sql)
	docker exec -it superset_db psql -h localhost -p $puerto -U $rol $db -c "$view"		
done

