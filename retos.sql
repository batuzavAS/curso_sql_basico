SELECT *
FROM platzi.alumnos
FETCH FIRST 5 ROWS ONLY;

SELECT *
FROM platzi.alumnos
LIMIT 5;

SELECT *
FROM (
	SELECT ROW_NUMBER() OVER() AS row_id,*
	FROM platzi.alumnos
) AS alumnos_with_row_num
WHERE row_id <= 5;



SELECT *
FROM platzi.alumnos
WHERE id NOT IN (
	SELECT id
	FROM platzi.alumnos
	WHERE tutor_id = 30
)


SELECT 	EXTRACT(YEAR FROM fecha_incorporacion) AS anio_incorporacion,
		EXTRACT(MONTH FROM fecha_incorporacion) AS mes_incorporacion,
		EXTRACT(DAY FROM fecha_incorporacion) AS dia_incorporacion,
		EXTRACT(HOUR FROM fecha_incorporacion) AS hora_incorporacion,
		EXTRACT(MINUTE FROM fecha_incorporacion) AS minuto_incorporacion,
		EXTRACT(SECOND FROM fecha_incorporacion) AS segundo_incorporacion
FROM platzi.alumnos;

SELECT DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion,
		DATE_PART('MONTH', fecha_incorporacion) AS mes_incorporacion,
		DATE_PART('DAY', fecha_incorporacion) AS dia_incorporacion,
		DATE_PART('HOUR', fecha_incorporacion) AS hora_incorporacion,
		DATE_PART('MINUTE', fecha_incorporacion) AS minuto_incorporacion,
		DATE_PART('SECOND', fecha_incorporacion) AS segundo_incorporacion
FROM platzi.alumnos;


SELECT *
    FROM platzi.alumnos
    WHERE (EXTRACT(YEAR FROM fecha_incorporacion)) = 2018
        AND (EXTRACT(MONTH FROM fecha_incorporacion)) = 05;



SELECT "alumnosId", COUNT(*) AS count
    FROM platzi.alumnos
    GROUP BY "alumnosId"
    HAVING COUNT(*) > 1;


-- El minimo (solo nombre)

SELECT MIN(nombre)
FROM platzi.alumnos;

-- El minimo por id de tutor ordenados por ID

SELECT tutor_id,MIN(nombre)
FROM platzi.alumnos
GROUP BY tutor_id
ORDER BY tutor_id;


SELECT AVG(alumnos_por_tutor) AS promedio_alumnos
FROM(
SELECT CONCAT(t.nombre,' ',	t.apellido) AS tutor,
		COUNT(*)   AS alumnos_por_tutor
FROM platzi.alumnos AS a
	INNER JOIN platzi.alumnos AS t ON a.tutor_id=t.id

GROUP BY tutor	
ORDER BY alumnos_por_tutor DESC
) AS promedio

SELECT AVG(dc.tutor_por_carrera)
FROM(

SELECT 	CONCAT(t.nombre,' ',	t.apellido) AS tutor,
		COUNT(*) AS tutor_por_carrera,
		a.carrera_id
FROM platzi.alumnos AS a
	INNER JOIN platzi.alumnos AS t ON a.tutor_id=t.id 
			AND a.carrera_id=t.tutor_id
GROUP BY tutor, a.carrera_id	
ORDER BY tutor_por_carrera DESC) AS dc



SELECT platzi.alumnos.nombre, platzi.alumnos.apellido, platzi.alumnos.carrera_id,
	   platzi.carreras.id, platzi.carreras.carrera
FROM platzi.alumnos
	LEFT JOIN platzi.carreras
	ON platzi.alumnos.carrera_id = platzi.carreras.id;



SELECT lpad('sql', id, '*')
FROM platzi.alumnos
WHERE id < 10;


SELECT lpad('\', id, '/') 
FROM generate_series(0,50) as id```