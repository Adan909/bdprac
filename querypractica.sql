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
	edad int not null Constraint CK_Paciente_Edad CHECK (edad > 0),
	Correo nvarchar(100) NOT NULL Constraint UQ_Correo UNIQUE,
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
create table Personal.Medicos (
	IdMedico int PRIMARY KEY IDENTITY(1,1),
	Nombre nvarchar(100) NOT NULL,
	Apellido nvarchar(100) NOT NULL,
	Correo nvarchar(100) NOT NULL Constraint UQ_CorreoMedico UNIQUE,
	IdEspecialidad int NOT NULL,
	created_at datetime DEFAULT GETDATE(),
	updated_at datetime DEFAULT GETDATE(),
	deleted_at datetime

	constraint FK_Medico_Especialidad FOREIGN KEY (IdEspecialidad) REFERENCES Personal.Especialidades(IdEspecialidad)
);



create table Gestion.Citas (
	IdCita int PRIMARY KEY IDENTITY(1,1),
	IdPaciente int NOT NULL,
	IdMedico int NOT NULL,
	FechaCita datetime NOT NULL,
	created_at datetime DEFAULT GETDATE(),
	updated_at datetime DEFAULT GETDATE(),
	deleted_at datetime,
	FOREIGN KEY (IdPaciente) REFERENCES Hospital.Pacientes(IdPaciente),
	FOREIGN KEY (IdMedico) REFERENCES Personal.Medicos(IdMedico)
);

create table Gestion.Recetas (
	IdReceta int PRIMARY KEY IDENTITY(1,1),
	IdCita int NOT NULL,
	Medicamento nvarchar(100) NOT NULL,
	Dosis nvarchar(100) NOT NULL,
	created_at datetime DEFAULT GETDATE(),
	updated_at datetime DEFAULT GETDATE(),
	deleted_at datetime,
	FOREIGN KEY (IdCita) REFERENCES Gestion.Citas(IdCita)
);

create table Hospital.Habitaciones (
	IdHabitacion int PRIMARY KEY IDENTITY(1,1),
	Numero nvarchar(10) NOT NULL,
	Tipo nvarchar(50) NOT NULL,
	Precio decimal(18, 2) NOT NULL,
	created_at datetime DEFAULT GETDATE(),
	updated_at datetime DEFAULT GETDATE(),
	deleted_at datetime
);

create table Gestion.Tratamientos (
	IdTratamiento int PRIMARY KEY IDENTITY(1,1),
	Nombre nvarchar(100) NOT NULL,
	Descripcion nvarchar(255) NOT NULL,
	Precio decimal(18, 2) NOT NULL,
	created_at datetime DEFAULT GETDATE(),
	updated_at datetime DEFAULT GETDATE(),
	deleted_at datetime
);

create table Gestion.Medicamentos (
	IdMedicamento int PRIMARY KEY IDENTITY(1,1),
	Nombre nvarchar(100) NOT NULL,
	Descripcion nvarchar(255) NOT NULL,
	Precio decimal(18, 2) NOT NULL,
	created_at datetime DEFAULT GETDATE(),
	updated_at datetime DEFAULT GETDATE(),
	deleted_at datetime
);







