use master
go

create database HospitalDB
go


CREATE SCHEMA Hospital;
go

CREATE SCHEMA Personal
GO

CREATE SCHEMA Gestion;
go


create table Hospital.Pacientes (
	IdPaciente int PRIMARY KEY IDENTITY(1,1),
	Nombre nvarchar(100) NOT NULL,
	Apellido nvarchar(100) NOT NULL,
	FechaNacimiento datetime NOT NULL,
	created_at datetime DEFAULT GETDATE(),
	updated_at datetime DEFAULT GETDATE(),
	deleted_at datetime
);

create table Personal.Medicos (
	IdMedico int PRIMARY KEY IDENTITY(1,1),
	Nombre nvarchar(100) NOT NULL,
	Apellido nvarchar(100) NOT NULL,
	Especialidad nvarchar(100) NOT NULL,
	created_at datetime DEFAULT GETDATE(),
	updated_at datetime DEFAULT GETDATE(),
	deleted_at datetime
);

create table Personal.Especialidades (
	IdEspecialidad int PRIMARY KEY IDENTITY(1,1),
	Nombre nvarchar(100) NOT NULL,
	created_at datetime DEFAULT GETDATE(),
	updated_at datetime DEFAULT GETDATE(),
	deleted_at datetime
);
	


