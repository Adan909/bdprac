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

