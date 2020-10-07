drop database if exists bdturnos;
create database bdturnos;
use bdturnos;

-- DDL
drop table if exists horas;
drop table if exists pacientes;
drop table if exists especialidades;
drop table if exists especialistas;
drop table if exists turnos;

create table horas(
    id int auto_increment primary key,
    nombre varchar(5)
    )
ENGINE = InnoDB;

create table pacientes(
    id int auto_increment primary key,
    tipoDocumento enum('DNI', 'LC', 'LE', 'PASS'),
    numDocumento varchar(8) not null,
    nombre varchar(25) not null,
    apellido varchar(25) not null,
    fechanac date not null,
    sexo enum('MASCULINO','FEMENINO') not null,
    tlf_cel varchar(10) not null,
    tlf_casa varchar(10),
    email varchar(25),
    calle varchar(25) not null,
    dpto_casa varchar(10) not null,
    prepaga enum('OSDE','OMINTDAS','MEDICUS','ObSBA', 'OMINIS')
)
ENGINE = InnoDB;

alter table pacientes 
    add constraint U_pacientes_tipoDocumento_numDocumento
    unique(tipoDocumento, numDocumento);
    
create table especialidades(
    id int auto_increment primary key,
    nombre varchar(25) not null
)

ENGINE = InnoDB;

create table especialistas(
    id int auto_increment primary key,
    tipoDocumento enum('DNI', 'LC', 'LE', 'PASS'),
    numDocumento varchar(8) not null,
    nombre varchar(25) not null,
    apellido varchar(25) not null,
    fechanac date not null,
    sexo enum('MASCULINO','FEMENINO') not null,
    tlf_cel varchar(10) not null,
    tlf_casa varchar(10),
    email varchar(25),
    calle varchar(25) not null,
    dpto_casa varchar(10) not null,
    titulo varchar(25) not null,
    idEspecialidad int not null
)
ENGINE = InnoDB;

alter table especialistas 
    add constraint FK_especialistas_idEspecialidad
    foreign key(idEspecialidad)
    references especialidades(id)
    on delete cascade;
    
create table turnos(
    id int auto_increment primary key,
    fecha date not null,
    idHora int not null,
    idEspecialista int not null,
    idPaciente int not null,
    idEspecialidad int not null,
    cancelado boolean
    -- primary key(fecha, dia,IdHora,idEspecialidad,idEspecialista)
)
ENGINE = InnoDB;

alter table turnos 
    add constraint U_turnos_fecha_idPaciente_idEspecialista_idEspecialidad
    unique(fecha, idHora, idEspecialista);

-- hora
alter table turnos 
    add constraint FK_turnos_idHora
    foreign key(idHora)
    references horas(id)
    on delete cascade;

alter table turnos 
    add constraint FK_turnos_idPaciente
    foreign key(idPaciente)
    references pacientes(id)
    on delete cascade;

alter table turnos 
    add constraint FK_turnos_idEspecialista
    foreign key(idEspecialista)
    references especialistas(id)
    on delete cascade;

alter table turnos 
    add constraint FK_turnos_idEspecialidad
    foreign key(idEspecialidad)
    references especialidades(id)
    on delete cascade;
