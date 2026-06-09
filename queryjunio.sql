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

