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
	salario decimal(18, 2) NOT NULL Constraint CK_Medico_Salario CHECK (salario > 0),
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


ALTER TABLE Gestion.Tratamientos ADD IdPaciente INT;
ALTER TABLE Gestion.Tratamientos ADD CONSTRAINT FK_Tratamientos_Pacientes 
    FOREIGN KEY (IdPaciente) REFERENCES Hospital.Pacientes(IdPaciente);

ALTER TABLE Gestion.Medicamentos ADD IdTratamiento INT;
ALTER TABLE Gestion.Medicamentos ADD CONSTRAINT FK_Medicamentos_Tratamientos 
    FOREIGN KEY (IdTratamiento) REFERENCES Gestion.Tratamientos(IdTratamiento);


ALTER TABLE Hospital.Habitaciones ADD IdPaciente INT;
ALTER TABLE Hospital.Habitaciones ADD CONSTRAINT FK_Habitaciones_Pacientes 
    FOREIGN KEY (IdPaciente) REFERENCES Hospital.Pacientes(IdPaciente);




ALTER TABLE Hospital.Pacientes ADD Telefono NVARCHAR(20);
ALTER TABLE Hospital.Pacientes ADD Direccion NVARCHAR(150);
ALTER TABLE Hospital.Pacientes ADD Genero CHAR(1);
ALTER TABLE Hospital.Pacientes ADD Tipo_Sangre VARCHAR(5);
ALTER TABLE Hospital.Pacientes ADD Fecha_Nacimiento DATE;
ALTER TABLE Hospital.Pacientes ALTER COLUMN Nombre NVARCHAR(150) NOT NULL;
ALTER TABLE Hospital.Pacientes ALTER COLUMN Direccion NVARCHAR(250);
ALTER TABLE Personal.Medicos ADD Experiencia INT;
ALTER TABLE Personal.Medicos ADD Turno NVARCHAR(20);
ALTER TABLE Personal.Medicos ADD Observaciones NVARCHAR(255);
ALTER TABLE Personal.Medicos DROP COLUMN Observaciones;
ALTER TABLE Gestion.Citas ADD Estado NVARCHAR(20) DEFAULT 'Pendiente';
ALTER TABLE Gestion.Citas ADD Costo_Consulta DECIMAL(18,2);
ALTER TABLE Gestion.Citas ALTER COLUMN Costo_Consulta DECIMAL(12,2);
ALTER TABLE Hospital.Habitaciones ADD Disponibilidad BIT DEFAULT 1;







