USE master;
GO
CREATE DATABASE EmpresaSQL;
GO
USE EmpresaSQL;
GO

CREATE TABLE TDepartamento (
    nDepartamentoID INT IDENTITY(1,1) CONSTRAINT PK_TDepartamento PRIMARY KEY,
    cNombreDepartamento VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE TCargo (
    nCargoID INT IDENTITY(1,1) CONSTRAINT PK_TCargo PRIMARY KEY,
    cNombreCargo VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE TEmpleado (
    nEmpleadoID INT IDENTITY(1,1) CONSTRAINT PK_TEmpleado PRIMARY KEY,
    cNIF VARCHAR(20) UNIQUE,
    cNombre VARCHAR(50),
    cApellido VARCHAR(50),
    nDepartamentoID INT,
    nCargoID INT,
    dFechaContratacion DATE,
    nSalario DECIMAL(10,2)
);

ALTER TABLE TEmpleado 
ADD CONSTRAINT CHK_Empleado_Salario CHECK (nSalario > 300);

ALTER TABLE TEmpleado 
ADD CONSTRAINT DF_Empleado_FechaContratacion DEFAULT GETDATE() FOR dFechaContratacion;

ALTER TABLE TEmpleado 
ADD CONSTRAINT FK_TEmpleado_TDepartamento FOREIGN KEY (nDepartamentoID) REFERENCES TDepartamento(nDepartamentoID);

ALTER TABLE TEmpleado 
ADD CONSTRAINT FK_TEmpleado_TCargo FOREIGN KEY (nCargoID) REFERENCES TCargo(nCargoID);

CREATE TABLE TProyecto (
    nProyectoID INT IDENTITY(1,1) CONSTRAINT PK_TProyecto PRIMARY KEY,
    cNombreProyecto VARCHAR(150) NOT NULL,
    dFechaInicio DATE NOT NULL,
    dFechaFin DATE
);

CREATE TABLE TEmpleadoProyecto (
    nEmpleadoID INT,
    nProyectoID INT,
    CONSTRAINT PK_TEmpleadoProyecto PRIMARY KEY (nEmpleadoID, nProyectoID),
    CONSTRAINT FK_TEmpleadoProyecto_TEmpleado FOREIGN KEY (nEmpleadoID) REFERENCES TEmpleado(nEmpleadoID),
    CONSTRAINT FK_TEmpleadoProyecto_TProyecto FOREIGN KEY (nProyectoID) REFERENCES TProyecto(nProyectoID)
);

ALTER TABLE TEmpleado ADD cEmail VARCHAR(100);

ALTER TABLE TEmpleado ADD cTelefono VARCHAR(15);

ALTER TABLE TEmpleado ALTER COLUMN cNombre VARCHAR(100);

ALTER TABLE TEmpleado ALTER COLUMN cApellido VARCHAR(100);

ALTER TABLE TEmpleado ADD cDireccion VARCHAR(250);

ALTER TABLE TEmpleado ADD nEdad INT;

ALTER TABLE TEmpleado 
ADD CONSTRAINT CHK_Empleado_Edad CHECK (nEdad BETWEEN 18 AND 65);

ALTER TABLE TEmpleado 
ADD CONSTRAINT UQ_Empleado_Email UNIQUE (cEmail);

ALTER TABLE TEmpleado ADD bActivo BIT CONSTRAINT DF_Empleado_Activo DEFAULT 1;

ALTER TABLE TEmpleado DROP COLUMN cDireccion;

ALTER TABLE TEmpleado ALTER COLUMN cTelefono VARCHAR(20);

ALTER TABLE TEmpleado ADD cGenero CHAR(1);

ALTER TABLE TEmpleado 
ADD CONSTRAINT CHK_Empleado_Genero CHECK (cGenero IN ('M', 'F'));

ALTER TABLE TEmpleado ADD dFechaNacimiento DATE;

CREATE TABLE TSucursal (
    nSucursalID INT IDENTITY(1,1) CONSTRAINT PK_TSucursal PRIMARY KEY,
    cNombreSucursal VARCHAR(100) NOT NULL
);
INSERT INTO TDepartamento (cNombreDepartamento) VALUES 
('Tecnología'), ('Recursos Humanos'), ('Finanzas'), ('Mercadeo'), ('Operaciones');

INSERT INTO TCargo (cNombreCargo) VALUES 
('Desarrollador'), ('Analista'), ('Gerente'), ('Asistente'), ('Contador');

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, dFechaContratacion, nSalario, cEmail, cTelefono, nEdad, cGenero, dFechaNacimiento) VALUES
('101', 'Juan', 'Gomez', 1, 1, '2025-01-15', 1500.00, 'juan.gomez@empresa.com', '8888-1111', 28, 'M', '1997-05-10'),
('102', 'Maria', 'Lopez', 1, 2, '2025-02-20', 1200.00, 'maria.lopez@empresa.com', '8888-2222', 32, 'F', '1993-08-22'),
('103', 'Carlos', 'Garcia', 2, 3, '2024-06-10', 2500.00, 'carlos.garcia@empresa.com', '8888-3333', 45, 'M', '1980-11-05'),
('104', 'Ana', 'Martinez', 3, 5, '2025-03-01', 1300.00, 'ana.martinez@empresa.com', '8888-4444', 29, 'F', '1996-02-14'),
('105', 'Luis', 'Rodriguez', 4, 4, '2023-05-18', 450.00, 'luis.rodriguez@empresa.com', '8888-5555', 24, 'M', '2001-12-01'),
('106', 'Sofia', 'Gonzalez', 5, 4, '2025-04-12', 480.00, 'sofia.gonzalez@empresa.com', '8888-6666', 22, 'F', '2003-07-19'),
('107', 'Pedro', 'Sanchez', 1, 1, '2024-09-01', 1600.00, 'pedro.sanchez@empresa.com', '8888-7777', 35, 'M', '1990-03-30'),
('108', 'Elena', 'Ramirez', 3, 2, '2025-01-10', 1100.00, 'elena.ramirez@empresa.com', '8888-8888', 30, 'F', '1995-09-25'),
('109', 'Miguel', 'Torres', 2, 4, '2025-05-02', 400.00, 'miguel.torres@empresa.com', '8888-9999', 26, 'M', '1999-04-05'),
('110', 'Laura', 'Castro', 4, 3, '2022-11-20', 2200.00, 'laura.castro@empresa.com', '8888-0000', 40, 'F', '1985-01-01');

INSERT INTO TProyecto (cNombreProyecto, dFechaInicio, dFechaFin) VALUES
('Sistema ERP', '2026-01-01', '2026-12-31'),
('Campaña Navideña', '2026-10-01', '2026-12-25'),
('Auditoría Externa', '2026-02-15', NULL);

INSERT INTO TEmpleadoProyecto (nEmpleadoID, nProyectoID) VALUES 
(1, 1), (2, 1), (7, 1), (5, 2), (4, 3);

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, cEmail, nEdad, cGenero) 
VALUES ('111', 'Kevin', 'Espinoza', 1, 1, 950.00, 'kevin.es@empresa.com', 25, 'M');

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, dFechaContratacion, nSalario, cEmail, nEdad, cGenero)
VALUES ('112', 'Jose', 'Perez', 2, 4, '2026-02-01', 600.00, 'jose.perez@empresa.com', 33, 'M');

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, cEmail, nEdad, cGenero)
VALUES ('113', 'Clara', 'Blanco', 3, 2, 1050.00, 'clara.b@empresa.com', 27, 'F');

INSERT INTO TDepartamento (cNombreDepartamento) VALUES 
('Logística'), ('Legal'), ('Calidad');

UPDATE TEmpleado SET nSalario = nSalario * 1.10;

UPDATE TEmpleado SET nSalario = nSalario * 1.20 WHERE nDepartamentoID = 1;

UPDATE TEmpleado SET cEmail = 'juan.gomez.nuevo@empresa.com' WHERE nEmpleadoID = 1;

UPDATE TEmpleado SET nCargoID = 3 WHERE nEmpleadoID = 2;

UPDATE TEmpleado SET nDepartamentoID = 3 WHERE nEmpleadoID IN (5, 6);

UPDATE TEmpleado SET bActivo = 0 WHERE nSalario < 500;

UPDATE TProyecto SET dFechaFin = '2026-06-30' WHERE nProyectoID = 3;

INSERT INTO TEmpleadoProyecto (nEmpleadoID, nProyectoID) VALUES (3, 3);

DELETE FROM TEmpleado WHERE cNIF = '112';

DELETE FROM TEmpleadoProyecto WHERE nEmpleadoID IN (SELECT nEmpleadoID FROM TEmpleado WHERE bActivo = 0);
DELETE FROM TEmpleado WHERE bActivo = 0;

DELETE FROM TEmpleadoProyecto WHERE nProyectoID = 2;
DELETE FROM TProyecto WHERE nProyectoID = 2;

DELETE FROM TEmpleadoProyecto WHERE nEmpleadoID = 1;

DELETE FROM TDepartamento WHERE nDepartamentoID = 6;

SELECT * FROM TEmpleado ORDER BY cApellido ASC;

SELECT * FROM TEmpleado WHERE nSalario > 1000;

SELECT * FROM TEmpleado WHERE bActivo = 1;

SELECT * FROM TEmpleado WHERE YEAR(dFechaContratacion) = YEAR(GETDATE());

SELECT E.*, D.cNombreDepartamento 
FROM TEmpleado E
INNER JOIN TDepartamento D ON E.nDepartamentoID = D.nDepartamentoID;

SELECT E.*, C.cNombreCargo 
FROM TEmpleado E
INNER JOIN TCargo C ON E.nCargoID = C.nCargoID;

SELECT E.nEmpleadoID, E.cNombre, E.cApellido, P.cNombreProyecto
FROM TEmpleado E
INNER JOIN TEmpleadoProyecto EP ON E.nEmpleadoID = EP.nEmpleadoID
INNER JOIN TProyecto P ON EP.nProyectoID = P.nProyectoID;

SELECT nDepartamentoID, COUNT(*) AS TotalEmpleados 
FROM TEmpleado 
GROUP BY nDepartamentoID;

SELECT nDepartamentoID, AVG(nSalario) AS SalarioPromedio 
FROM TEmpleado 
GROUP BY nDepartamentoID;

SELECT nDepartamentoID, MAX(nSalario) AS SalarioMaximo, MIN(nSalario) AS SalarioMinimo 
FROM TEmpleado 
GROUP BY nDepartamentoID;

SELECT nProyectoID, COUNT(nEmpleadoID) AS TotalEmpleados
FROM TEmpleadoProyecto
GROUP BY nProyectoID
HAVING COUNT(nEmpleadoID) > 2;

SELECT * FROM TEmpleado WHERE cApellido LIKE 'G%';

SELECT * FROM TEmpleado ORDER BY nSalario DESC;

SELECT TOP 3 nSalario FROM TEmpleado ORDER BY nSalario DESC;

SELECT * FROM TEmpleado WHERE nEdad BETWEEN 25 AND 40;

SELECT COUNT(*) AS ActivosTotal FROM TEmpleado WHERE bActivo = 1;

SELECT COUNT(*) AS TotalProyectos FROM TProyecto;

ALTER TABLE TEmpleado DROP CONSTRAINT CHK_Empleado_Edad;

ALTER TABLE TEmpleado DROP CONSTRAINT UQ_Empleado_Email;

ALTER TABLE TEmpleado ADD CONSTRAINT CHK_Empleado_Edad CHECK (nEdad BETWEEN 18 AND 65);
ALTER TABLE TEmpleado ADD CONSTRAINT UQ_Empleado_Email UNIQUE (cEmail);

DROP TABLE TEmpleadoProyecto;

DROP TABLE TProyecto;

DROP TABLE TEmpleado;

DROP TABLE TCargo;

DROP TABLE TDepartamento;

DROP TABLE TSucursal;

USE master;
GO
DROP DATABASE EmpresaSQL;
GO


