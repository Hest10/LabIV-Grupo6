/*Listado de Alumnos*/
SELECT a.Legajo, a.Dni, a.Nombre, a.Apellido, a.FechaNac, a.Direccion,
pa.descripcion AS Nacionalidad, pr.descripcion AS Provincia, 
lo.descripcion AS Localidad, c.Descripcion_carrera FROM alumnos a
JOIN carreras c ON a.idCarrera = c.idCarrera 
JOIN paises pa ON a.idPais = pa.idPais
JOIN provincias pr ON a.idProvincia = pr.idProvincia
JOIN localidades lo ON a.idLocalidad = lo.idLocalidad;

/*Listado Profesores*/
SELECT d.Legajo, d.Dni, d.Nombre, d.Apellido, d.FechaNac, d.Direccion,
pa.descripcion AS Nacionalidad, pr.descripcion AS Provincia, 
lo.descripcion AS Localidad, c.Descripcion_carrera FROM docentes d
JOIN carreras c ON d.idCarrera = c.idCarrera
JOIN paises pa ON d.idPais = pa.idPais
JOIN provincias pr ON d.idProvincia = pr.idProvincia
JOIN localidades lo ON d.idLocalidad = lo.idLocalidad; 

/*Listado de Cursos */
SELECT c.idCurso,m.Descripcion_Materia, c.Descripcion_curso, c.Semestre,
 c.Año, d.Nombre, d.Apellido, car.Descripcion_carrera FROM cursos c
LEFT JOIN materias m ON c.idMateria = m.idMateria
LEFT JOIN docentes d ON c.idDocente = d.idDocente
LEFT JOIN carreras car ON d.idCarrera = car.idCarrera;

/*alumnosxcurso en general*/
SELECT axc.idAlumnosxcurso,a.Nombre, a.Apellido,c.Descripcion_curso, axc.estado, axc.parcial1, axc.parcial2, axc.recuperatorio1, 
axc.recuperatorio2 FROM  alumnosxcurso axc
LEFT JOIN cursos c ON axc.idCurso = c.idCurso
LEFT JOIN docentes d ON c.idDocente = d.idDocente
LEFT JOIN alumnos a ON axc.idAlumno = a.idAlumno;


/****Hacer Stored procedures****/
/*Materias que tiene una carrera
(El administrador para inscrir el docente a un curso 
de una Materia -antes tiene que ver si esa materia está en la carrera donde figura el docente
)Si un profesor se inscribió a una materia que no esta en determinada carrera, 
hay que modificar el campo idCarrera del Docente(NOT NULL) y modificar el campo idDocente(not null) 
de un registro de la tabla cursos, en el supuesto podria darse de baja el registro de curso y 
volverlo a crear con los datos actualizados. Controlar en los JSP que no se muestren varios registros repitiendo la carrera.*/
SELECT car.Descripcion_carrera,m.Descripcion_Materia FROM materiasxcarrera mxc
LEFT JOIN  carreras car ON  mxc.idCarrera_Mat = car.idCarrera
LEFT JOIN materias m ON  mxc.IdMateria_Mat = m.idMateria
ORDER BY car.idCarrera ASC;

/*Cursos de un determinado docente*/
SELECT c.idCurso,m.Descripcion_Materia, c.Descripcion_curso, c.Semestre,
 c.Año, d.Nombre, d.Apellido, car.Descripcion_carrera FROM cursos c 
LEFT JOIN materias m ON c.idMateria = m.idMateria
LEFT JOIN docentes d ON c.idDocente = d.idDocente
LEFT JOIN carreras car ON d.idCarrera = car.idCarrera
WHERE d.Legajo="123456";


/*alumnosxcurso Profesor solicita ver Un alumno en Un determinado curso
(Evitar que un alumno se inscriba dos veces al mismo curso) Esto se chequea fuera de la base*/
SELECT axc.idAlumnosxcurso,a.Nombre, a.Apellido,c.Descripcion_curso, axc.estado, axc.parcial1, axc.parcial2, axc.recuperatorio1, 
axc.recuperatorio2 FROM  alumnosxcurso axc
LEFT JOIN cursos c ON axc.idCurso = c.idCurso
LEFT JOIN docentes d ON c.idDocente = d.idDocente
LEFT JOIN alumnos a ON axc.idAlumno = a.idAlumno
WHERE a.Legajo = 12111 AND c.idCurso=1;

SELECT axc.idAlumnosxcurso,a.Nombre, a.Apellido,c.Descripcion_curso, axc.estado, axc.parcial1, axc.parcial2, axc.recuperatorio1, 
axc.recuperatorio2 FROM  alumnosxcurso axc
LEFT JOIN cursos c ON axc.idCurso = c.idCurso
LEFT JOIN docentes d ON c.idDocente = d.idDocente
LEFT JOIN alumnos a ON axc.idAlumno = a.idAlumno
WHERE a.Legajo LIKE '%12111%' AND c.idCurso LIKE '%1%';

/*Manejar bajas lógicas y no físicas ¿que significa? 
¿que no se borren los registros en la base de datos pero si en los JSP (carga de datos)?*/







