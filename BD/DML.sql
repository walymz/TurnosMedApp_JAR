use bdturnos;

-- DML

-- horas
insert into horas (nombre) values ('09:00');
insert into horas (nombre) values ('09:30');
insert into horas (nombre) values ('10:00');
insert into horas (nombre) values ('10:30');
insert into horas (nombre) values ('11:00');
insert into horas (nombre) values ('11:30');
insert into horas (nombre) values ('12:00');
insert into horas (nombre) values ('12:30');
insert into horas (nombre) values ('13:00');
insert into horas (nombre) values ('13:30');
insert into horas (nombre) values ('14:00');
insert into horas (nombre) values ('14:30');
insert into horas (nombre) values ('15:00');
insert into horas (nombre) values ('15:30');
insert into horas (nombre) values ('16:00');

insert into especialidades (nombre) 
               values ("OBSTETRICIA");
insert into especialidades  (nombre) 
               values ("ODONTOLOGÍA");
insert into especialidades (nombre) 
               values ("DERMATOLOGÍA");
insert into especialidades (nombre) 
               values ("OTORRINOLARINGOLOGÍA");
insert into especialidades (nombre) 
               values ("PEDIATRÍA");
insert into especialidades (nombre) 
               values ("FONOAUDIOLOGÍA");

-- especialistas:

insert into especialistas (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, titulo, idEspecialidad) 
               values ("DNI","11111111","Roberto","Lara", '1992-01-09', "MASCULINO","2121212121", "2121212121", "roberto@hotmail.com", "Jujuy 310", "3C","ODONTÓLOGO",2);

insert into especialistas (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, titulo, idEspecialidad) 
               values ("DNI","22222222","Andrea","Méndez", '1999-03-09', "FEMENINO","2323232323", "2323232323", "andrea@hotmail.com","Perón 700", "4F","OBSTETRA",1);

insert into especialistas (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, titulo, idEspecialidad) 
               values ("DNI","33333333","José","Hernández", '1999-11-09', "MASCULINO","3434343434", "5351452321", "jose@gmail.com", "Belgrano 2500", "2A","ODONTÓLOGO",2);
               
insert into especialistas (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, titulo, idEspecialidad) 
               values ("DNI","44444444","Bello","Naranjo", '2003-11-20', "MASCULINO","3535353535", "3535353535", "bello@gmail.com","Lima 1230", "3C","DERMATÓLOGO",3);

insert into especialistas (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, titulo, idEspecialidad) 
               values ("PASS","55555555","Ninoska","Pérez", '2002-07-21', "FEMENINO","5500550055", "5500550055", "ninoska@hotmail.com","Gallardo 1200", "1B","PEDIATRA",5);

insert into especialistas (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, titulo, idEspecialidad) 
               values ("DNI","66666666","Andrés","Mijares", '2004-02-05', "MASCULINO","1133225500", "1133225500", "andres@gmail.com", "Uruguay 210", "2B","OTORRINOLARINGÓLOGO",4);
               
insert into especialistas (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, titulo, idEspecialidad) 
               values ("DNI","77777777","Alfredo","Ortega", '1999-01-01', "MASCULINO","5544663322", "5544663322","alfredo@gmail.com", "Lima 815", "1D","DERMATÓLOGO",3);

-- pacientes:

insert into pacientes (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, prepaga) 
               values ("DNI","12121212","Clara","López", '1987-10-17', "FEMENINO","11457899", "11457899","clara@hotmail.com", "Rivadavia 521", "1A", "OMINTDAS");

insert into pacientes (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, prepaga) 
               values ("PASS","13131313","Gabriel","Guerra", '1992-11-12', "MASCULINO","22553344", "1122334466","gabriel@hotmail.com", "Loyola 5300", "2A", "OMINTDAS");

insert into pacientes (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, prepaga)  
               values ("LC","14141414","Karina","Ríos", '2000-03-18', "FEMENINO","1123325511", "9988776655", "karina@hotmail.com","Pellegrini 1300", "8A", "MEDICUS");

insert into pacientes (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, prepaga) 
               values ("DNI","15151515","Facundo","Ferrer", '2010-12-30', "MASCULINO","1133445577", "1133445577", "facundo@hotmail.com","Perú 500", "10C", "OSDE");

insert into pacientes (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, prepaga) 
               values ("DNI","17171717","Eduardo","Ramos", '2009-10-10', "MASCULINO","7788991155", "7788991155", "eduardo@gmail.com","Avellaneda 350", "7D", "OSDE");

insert into pacientes (tipoDocumento, numDocumento, nombre, apellido, fechanac, sexo, tlf_cel, tlf_casa, email, calle, dpto_casa, prepaga) 
               values ("DNI","18181818","Makaela","Otero", '2011-12-11', "FEMENINO","777777777", "777777777","mikaela@hotmail.com", "Medrano 350", "1C", "OSDE");

-- turnos
insert into turnos (fecha, IdHora, idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values (curdate(), 14, 2, 2, 1, false);
insert into turnos (fecha, IdHora,  idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values (curdate(), 15, 3, 2, 1, false);
insert into turnos (fecha, IdHora,  idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values (curdate(), 13, 1, 2, 1, false);
insert into turnos (fecha, IdHora,  idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values ('2020-06-03', 5, 1, 2, 1, false);
insert into turnos (fecha, IdHora,  idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values ('2020-05-11', 3, 3, 3, 2, true);
insert into turnos (fecha, IdHora,  idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values ('2020-05-10', 1, 4, 5, 5, false);
insert into turnos (fecha, IdHora,  idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values ('2020-03-10', 13, 5, 4, 3, true);
insert into turnos (fecha, IdHora,  idEspecialista, idPaciente, idEspecialidad,cancelado)  
		  values ('2017-08-10', 14, 6, 5, 5, false);
insert into turnos (fecha, IdHora,  idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values ('2020-06-10', 14, 4, 1, 2, false);
insert into turnos (fecha, IdHora,  idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values ('2018-06-15', 8, 4, 1, 2, false);
insert into turnos (fecha, IdHora,  idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values ('2019-06-15', 6, 4, 1, 2, false);
insert into turnos (fecha, IdHora,  idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values ('2020-06-18', 10, 2, 1, 2, false);
insert into turnos (fecha, IdHora, idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values ('2020-06-19', 11, 5, 1, 2, true);
insert into turnos (fecha, IdHora, idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values ('2020-06-22', 11, 5, 1, 2, true);
insert into turnos (fecha, IdHora, idEspecialista, idPaciente, idEspecialidad,cancelado) 
		  values ('2020-06-26', 11, 5, 1, 2, false);
       