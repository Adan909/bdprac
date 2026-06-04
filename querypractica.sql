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

CREATE TABLE #Temporal (Id INT);
DROP TABLE #Temporal; 


ALTER TABLE Hospital.Pacientes DROP CONSTRAINT CK_Paciente_Edad;


ALTER TABLE Personal.Medicos DROP CONSTRAINT UQ_CorreoMedico;

ALTER TABLE Hospital.Pacientes ADD ColumnaPrueba INT;
ALTER TABLE Hospital.Pacientes DROP COLUMN ColumnaPrueba;

CREATE TABLE Hospital.Auditoria (
	Id INT, 
	Accion NVARCHAR(100)
);
DROP TABLE Hospital.Auditoria;


CREATE TABLE Hospital.Logs (Id INT, Error NVARCHAR(255));
DROP TABLE Hospital.Logs;


ALTER TABLE Personal.Medicos DROP CONSTRAINT FK_Medico_Especialidad;

ALTER TABLE Personal.Medicos ADD CONSTRAINT FK_Medico_Especialidad 
    FOREIGN KEY (IdEspecialidad) REFERENCES Personal.Especialidades(IdEspecialidad);


CREATE TABLE Gestion.MedicamentosPrueba (Id INT);
DROP TABLE Gestion.MedicamentosPrueba;


CREATE TABLE Hospital.TablaPruebas (Id INT);
DROP TABLE Hospital.TablaPruebas;


CREATE DATABASE Hospital_Pruebas;
GO
DROP DATABASE Hospital_Pruebas;
GO



INSERT INTO Personal.Especialidades (Nombre) VALUES 
('Cardiología'), ('Pediatría'), ('Dermatología'), ('Ginecología'), ('Traumatología');


INSERT INTO Personal.Medicos (Nombre, Apellido, salario, Correo, IdEspecialidad, Experiencia, Turno) VALUES
('Carlos', 'Pérez', 3500.00, 'carlos@gmail.com', 1, 10, 'Mañana'),
('Ana', 'Gómez', 4000.00, 'ana@gmail.com', 2, 8, 'Tarde'),
('Luis', 'Martínez', 3200.00, 'luis@gmail.com', 3, 5, 'Mañana'),
('María', 'Rodríguez', 4500.00, 'maria@gmail.com', 4, 12, 'Noche'),
('Jorge', 'López', 3800.00, 'jorge@gmail.com', 5, 7, 'Tarde'),
('Laura', 'Sánchez', 3600.00, 'laura@gmail.com', 1, 6, 'Mañana'),
('Pedro', 'Ramírez', 4100.00, 'pedro@gmail.com', 2, 9, 'Tarde'),
('Elena', 'Fernández', 4800.00, 'elena@gmail.com', 4, 15, 'Noche'),
('David', 'González', 3300.00, 'david@gmail.com', 3, 4, 'Mañana'),
('Sofia', 'Díaz', 3900.00, 'sofia@gmail.com', 5, 8, 'Tarde');


INSERT INTO Hospital.Pacientes (Nombre, Apellido, edad, Correo, Telefono, Direccion, Genero, Tipo_Sangre, Fecha_Nacimiento) VALUES
('Juan', 'Castro', 25, 'juan@mail.com', '5555-0101', 'Av. Central 123', 'M', 'O+', '2001-05-12'),
('Marta', 'Villa', 34, 'marta@mail.com', '5553-0102', 'Calle 10 #45', 'F', 'A+', '1992-08-22'),
('Diego', 'Rojas', 45, 'diego@mail.com', '5551-0103', 'Carrera 8 #22', 'M', 'O-', '1981-03-14'),
('Lucía', 'Mejía', 19, 'lucia@mail.com', '5553-0104', 'Circular 4 #78', 'F', 'B+', '2007-11-02'),
('Andrés', 'Mendoza', 60, 'andres@mail.com', '5555-0105', 'Av. Poblado 50', 'M', 'AB+', '1966-01-30'),
('Rosa', 'Palacios', 28, 'rosa@mail.com', '5559-0106', 'Calle Luna 12', 'F', 'O+', '1998-07-19'),
('Sergio', 'Torres', 52, 'sergio@mail.com', '5556-0107', 'Av. Sol 89', 'M', 'A-', '1974-04-25'),
('Clara', 'Soto', 31, 'clara@mail.com', '5553-0108', 'Calle 50 #12', 'F', 'O+', '1995-12-05'),
('Javier', 'Ríos', 23, 'javier@mail.com', '5557-0109', 'Av. Playa 44', 'M', 'B-', '2003-09-15'),
('Camila', 'Luna', 41, 'camila@mail.com', '5550-0110', 'Carrera 15 #90', 'F', 'A+', '1985-06-18'),
('Manuel', 'Cruz', 67, 'manuel@mail.com', '5551-0111', 'Calle Vieja 3', 'M', 'O+', '1959-02-11'),
('Gabriela', 'Ortega', 12, 'gabi@mail.com', '5545-0112', 'Av. Niños 8', 'F', 'AB-', '2014-10-29'),
('Fernando', 'Herrera', 38, 'fer@mail.com', '5553-0113', 'Calle Nueva 100', 'M', 'O-', '1988-05-24'),
('Patricia', 'Ruiz', 55, 'patricia@mail.com', '5515-0114', 'Av. Lima 61', 'F', 'A+', '1971-03-08'),
('Ricardo', 'Marín', 48, 'ricardo@mail.com', '5545-0115', 'Calle Sur 45', 'M', 'B+', '1978-07-07'),
('Natalia', 'Giraldo', 29, 'natalia@mail.com', '5535-0116', 'Av. Norte 22', 'F', 'O+', '1997-11-21'),
('Hugo', 'Morales', 33, 'hugo@mail.com', '5525-0117', 'Calle Este 7', 'M', 'A-', '1993-01-13'),
('Valeria', 'Acosta', 26, 'valeria@mail.com', '5155-0118', 'Av. Oeste 99', 'F', 'O+', '2000-04-04'),
('Oscar', 'Suárez', 71, 'oscar@mail.com', '1555-0119', 'Pasaje Azul 4', 'M', 'AB+', '1955-08-30'),
('Beatriz', 'Pineda', 37, 'beatriz@mail.com', '5255-0120', 'Calle Verde 15', 'F', 'O-', '1989-10-12');


INSERT INTO Gestion.Citas (IdPaciente, IdMedico, FechaCita, Estado, Costo_Consulta) VALUES
(1, 1, GETDATE(), 'Completada', 50.00),
(2, 2, GETDATE(), 'Completada', 60.00),
(3, 3, '2026-07-10 10:00:00', 'Pendiente', 50.00), 
(4, 4, '2026-08-15 15:30:00', 'Pendiente', 70.00), 
(5, 5, '2026-09-01 09:00:00', 'Pendiente', 55.00), 
(6, 6, GETDATE(), 'Cancelada', 50.00),
(7, 7, '2026-06-20 11:15:00', 'Pendiente', 60.00),
(8, 8, GETDATE(), 'Completada', 80.00),
(9, 9, '2026-07-22 08:30:00', 'Pendiente', 50.00),
(10, 10, '2026-06-18 14:00:00', 'Pendiente', 55.00),
(11, 1, GETDATE(), 'Pendiente', 50.00),
(12, 2, '2026-08-05 16:00:00', 'Pendiente', 60.00),
(13, 3, GETDATE(), 'Completada', 50.00),
(14, 4, '2026-07-11 11:00:00', 'Pendiente', 70.00),
(15, 5, '2026-06-30 10:30:00', 'Cancelada', 55.00);


INSERT INTO Hospital.Habitaciones (Numero, Tipo, Precio, Disponibilidad, IdPaciente) VALUES
('101', 'Individual', 150.00, 0, 1),
('102', 'Individual', 150.00, 1, NULL),
('103', 'Compartida', 90.00, 0, 2),
('104', 'Compartida', 90.00, 1, NULL),
('201', 'Suite', 300.00, 0, 5),
('202', 'Suite', 300.00, 1, NULL),
('203', 'UCI', 500.00, 0, 11),
('204', 'UCI', 500.00, 1, NULL),
('301', 'Individual', 160.00, 1, NULL),
('302', 'Compartida', 95.00, 1, NULL);


INSERT INTO Gestion.Tratamientos (Nombre, Descripcion, Precio, IdPaciente) VALUES
('Fisioterapia', 'Activo - 10 sesiones de rodilla', 200.00, 1),
('Quimioterapia', 'Activo - Ciclo 3 de tratamiento', 1500.00, 2),
('Tratamiento Conductual', 'Finalizado - Control de ansiedad', 350.00, 3),
('Antibióticos IV', 'Activo - Infección severa', 120.00, 4),
('Dieta Post-Infarto', 'Finalizado - Plan nutricional', 80.00, 5),
('Rehabilitación Pulmonar', 'Activo - Post-COVID', 250.00, 6),
('Insulina basal', 'Activo - Control diabetes', 90.00, 7),
('Yeso por Fractura', 'Finalizado - Retirado con éxito', 180.00, 8),
('Tratamiento Acné', 'Activo - Tópico y oral', 110.00, 9),
('Control Hipertensión', 'Activo - Monitoreo diario', 75.00, 10);


INSERT INTO Gestion.Medicamentos (Nombre, Descripcion, Precio, IdTratamiento) VALUES
('Paracetamol', 'Analgésico 500mg', 5.00, 1),
('Ibuprofeno', 'Antiinflamatorio 400mg', 6.50, 1),
('Amoxicilina', 'Antibiótico 500mg', 12.00, 4),
('Omeprazol', 'Protector gástrico 20mg', 4.00, 4),
('Metformina', 'Antidiabético 850mg', 15.00, 7),
('Atorvastatina', 'Control colesterol 20mg', 22.00, 5),
('Losartán', 'Antihipertensivo 50mg', 10.50, 10),
('Tramadol', 'Analgésico fuerte 50mg', 18.00, 2),
('Clonazepam', 'Ansiolítico 2mg', 14.00, 3),
('Fluoxetina', 'Antidepresivo 20mg', 16.50, 3),
('Loratadina', 'Antihistamínico 10mg', 5.50, 9),
('Isotretinoína', 'Tratamiento acné 20mg', 45.00, 9),
('Salbutamol', 'Inhalador broncodilatador', 11.00, 6),
('Ceftriaxona', 'Antibiótico inyectable', 25.00, 4),
('Enoxaparina', 'Anticoagulante', 35.00, 2),
('Diclofenaco', 'Gel antiinflamatorio', 8.00, 8),
('Insulina Glargina', 'Análogo de insulina', 55.00, 7),
('Metoprolol', 'Betabloqueador 50mg', 13.00, 10),
('Vitamina C', 'Suplemento 1g (Vencido Prueba)', 3.00, NULL),
('Aspirina', 'Antiagregante 100mg', 4.50, 5);


UPDATE Hospital.Pacientes SET Telefono = '555-9999' WHERE IdPaciente = 1;


UPDATE Hospital.Pacientes SET Direccion = 'Nueva Avenida Siempre Viva 742' WHERE IdPaciente = 2;

UPDATE Personal.Medicos SET salario = 5200.00 WHERE IdMedico = 4;

UPDATE Personal.Medicos SET Turno = 'Noche' WHERE IdMedico = 1;

UPDATE Gestion.Citas SET Estado = 'Completada' WHERE IdCita = 3;


UPDATE Gestion.Citas SET Costo_Consulta = 65.00 WHERE IdCita = 5;


UPDATE Personal.Especialidades SET Nombre = 'Traumatología y Ortopedia' WHERE IdEspecialidad = 5;


UPDATE Hospital.Habitaciones SET Disponibilidad = 1, IdPaciente = NULL WHERE Numero = '101';


UPDATE Gestion.Tratamientos SET Descripcion = 'Activo - Extendida a 15 sesiones' WHERE IdTratamiento = 1;


UPDATE Gestion.Medicamentos SET Precio = 7.00 WHERE Nombre = 'Ibuprofeno';

UPDATE Hospital.Pacientes SET Correo = 'juan_nuevo@mail.com' WHERE IdPaciente = 1;


UPDATE Personal.Medicos SET Correo = 'carlos_jefe@hospital.com' WHERE IdMedico = 1;


UPDATE Gestion.Citas SET FechaCita = '2026-07-15 11:00:00' WHERE IdCita = 4;


UPDATE Personal.Medicos SET Experiencia = 11 WHERE IdMedico = 1;


UPDATE Hospital.Pacientes SET Tipo_Sangre = 'O-' WHERE IdPaciente = 6;



DELETE FROM Gestion.Recetas WHERE IdCita = 15; 
DELETE FROM Gestion.Citas WHERE IdCita = 15;


DELETE FROM Hospital.Pacientes WHERE IdPaciente = 20;


DELETE FROM Gestion.Medicamentos WHERE IdMedicamento = 20; -- Aspirina

DELETE FROM Hospital.Habitaciones WHERE IdHabitacion = 10;


UPDATE Gestion.Medicamentos SET IdTratamiento = NULL WHERE IdTratamiento = 5; 
DELETE FROM Gestion.Tratamientos WHERE IdTratamiento = 5;


DELETE FROM Gestion.Citas WHERE Estado = 'Cancelada';


DELETE FROM Hospital.Pacientes 
WHERE IdPaciente NOT IN (SELECT DISTINCT IdPaciente FROM Gestion.Citas);


DELETE FROM Hospital.Habitaciones WHERE Disponibilidad = 1 AND IdPaciente IS NULL;


DELETE FROM Gestion.Medicamentos WHERE Descripcion LIKE '%Vencido%';


DELETE FROM Gestion.Tratamientos WHERE Nombre LIKE '%Prueba%';


SELECT * FROM Hospital.Pacientes;

SELECT * FROM Personal.Medicos;


SELECT * FROM Personal.Especialidades;


SELECT * FROM Gestion.Citas;


SELECT * FROM Hospital.Pacientes ORDER BY Apellido ASC;


SELECT * FROM Personal.Medicos ORDER BY salario DESC;


SELECT * FROM Gestion.Citas 
WHERE CAST(FechaCita AS DATE) = CAST(GETDATE() AS DATE);

SELECT * FROM Hospital.Habitaciones WHERE Disponibilidad = 1;


SELECT COUNT(*) AS Total_Pacientes FROM Hospital.Pacientes;


SELECT M.Nombre, M.Apellido, COUNT(C.IdCita) AS Cantidad_Citas
FROM Personal.Medicos M
LEFT JOIN Gestion.Citas C ON M.IdMedico = C.IdMedico
GROUP BY M.IdMedico, M.Nombre, M.Apellido;






