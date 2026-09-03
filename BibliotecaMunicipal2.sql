
USE master;
GO

IF DB_ID('BibliotecaMunicipal2') IS NOT NULL
BEGIN
    ALTER DATABASE BibliotecaMunicipal2
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE BibliotecaMunicipal2;
END;
GO

CREATE DATABASE BibliotecaMunicipal2;
GO

USE BibliotecaMunicipal2;
GO


CREATE TABLE Nacionalidad
(
    Id INT IDENTITY(1,1) NOT NULL,
    Pais VARCHAR(100) NOT NULL,
    Nacionalidad VARCHAR(100) NOT NULL,

    CONSTRAINT pkNacionalidad_Id
        PRIMARY KEY (Id)
);
GO


CREATE TABLE Autor
(
    Id INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    Apellido VARCHAR(100) NULL,
    TipoAutor VARCHAR(30) NOT NULL,
    IdNacionalidad INT NULL,

    CONSTRAINT pkAutor_Id
        PRIMARY KEY (Id),

    CONSTRAINT fkAutor_Nacionalidad
        FOREIGN KEY (IdNacionalidad)
        REFERENCES Nacionalidad(Id)
);
GO


CREATE TABLE Ubicacion
(
    Id INT IDENTITY(1,1) NOT NULL,
    Pais VARCHAR(100) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,

    CONSTRAINT pkUbicacion_Id
        PRIMARY KEY (Id)
);
GO


CREATE TABLE Editorial
(
    Id INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    IdUbicacion INT NOT NULL,

    CONSTRAINT pkEditorial_Id
        PRIMARY KEY (Id),

    CONSTRAINT fkEditorial_Ubicacion
        FOREIGN KEY (IdUbicacion)
        REFERENCES Ubicacion(Id)
);
GO


CREATE TABLE Tipo
(
    Id INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,

    CONSTRAINT pkTipo_Id
        PRIMARY KEY (Id)
);
GO


CREATE TABLE Publicacion
(
    Id INT IDENTITY(1,1) NOT NULL,
    Titulo VARCHAR(200) NOT NULL,
    Anio INT NOT NULL,
    ISBN VARCHAR(20) NULL,
    IdTipo INT NOT NULL,
    IdEditorial INT NOT NULL,

    CONSTRAINT pkPublicacion_Id
        PRIMARY KEY (Id),

    CONSTRAINT fkPublicacion_Tipo
        FOREIGN KEY (IdTipo)
        REFERENCES Tipo(Id),

    CONSTRAINT fkPublicacion_Editorial
        FOREIGN KEY (IdEditorial)
        REFERENCES Editorial(Id)
);
GO


CREATE TABLE Volumen
(
    Id INT IDENTITY(1,1) NOT NULL,
    Numero INT NOT NULL,
    Anio INT NULL,
    IdPublicacion INT NOT NULL,

    CONSTRAINT pkVolumen_Id
        PRIMARY KEY (Id),

    CONSTRAINT fkVolumen_Publicacion
        FOREIGN KEY (IdPublicacion)
        REFERENCES Publicacion(Id)
);
GO


CREATE TABLE Descriptor
(
    Id INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,

    CONSTRAINT pkDescriptor_Id
        PRIMARY KEY (Id)
);
GO


CREATE TABLE Autor_Publicacion
(
    Id INT IDENTITY(1,1) NOT NULL,
    IdAutor INT NOT NULL,
    IdPublicacion INT NOT NULL,

    CONSTRAINT pkAutor_Publicacion_Id
        PRIMARY KEY (Id),

    CONSTRAINT fkAutorPublicacion_Autor
        FOREIGN KEY (IdAutor)
        REFERENCES Autor(Id),

    CONSTRAINT fkAutorPublicacion_Publicacion
        FOREIGN KEY (IdPublicacion)
        REFERENCES Publicacion(Id)
);
GO


CREATE TABLE Publicacion_Descriptor
(
    Id INT IDENTITY(1,1) NOT NULL,
    IdPublicacion INT NOT NULL,
    IdDescriptor INT NOT NULL,

    CONSTRAINT pkPublicacion_Descriptor_Id
        PRIMARY KEY (Id),

    CONSTRAINT fkPublicacionDescriptor_Publicacion
        FOREIGN KEY (IdPublicacion)
        REFERENCES Publicacion(Id),

    CONSTRAINT fkPublicacionDescriptor_Descriptor
        FOREIGN KEY (IdDescriptor)
        REFERENCES Descriptor(Id)
);
GO


INSERT INTO Nacionalidad
    (Pais, Nacionalidad)
VALUES
    ('Colombia', 'Colombiana'),
    ('Argentina', 'Argentina'),
    ('España', 'Española'),
    ('Reino Unido', 'Británica');
GO


INSERT INTO Autor
    (Nombre, Apellido, TipoAutor, IdNacionalidad)
VALUES
    ('Gabriel', 'García Márquez', 'Persona', 1),
    ('Jorge Luis', 'Borges', 'Persona', 2),
    ('Miguel', 'de Cervantes', 'Persona', 3),
    ('J. K.', 'Rowling', 'Persona', 4),
    ('Organización Mundial de la Salud', NULL, 'Corporativo', NULL),
    ('Universidad Nacional de Colombia', NULL, 'Corporativo', 1);
GO


INSERT INTO Ubicacion
    (Pais, Ciudad)
VALUES
    ('Colombia', 'Bogotá'),
    ('Colombia', 'Medellín'),
    ('Argentina', 'Buenos Aires'),
    ('España', 'Madrid'),
    ('Reino Unido', 'Londres');
GO


INSERT INTO Editorial
    (Nombre, IdUbicacion)
VALUES
    ('Editorial Sudamericana', 1),
    ('Planeta', 1),
    ('Alfaguara', 4),
    ('Salamandra', 5),
    ('Editorial Universidad Nacional', 1);
GO


INSERT INTO Tipo
    (Nombre)
VALUES
    ('Libro'),
    ('Revista'),
    ('Periódico'),
    ('Tesis');
GO


INSERT INTO Publicacion
    (Titulo, Anio, ISBN, IdTipo, IdEditorial)
VALUES
    ('Cien años de soledad', 1967, '9780307474728', 1, 1),
    ('El amor en los tiempos del cólera', 1985, '9780307389732', 1, 2),
    ('El Aleph', 1949, '9788420633137', 1, 3),
    ('Don Quijote de la Mancha', 1605, '9788420412145', 1, 3),
    ('Harry Potter y la piedra filosofal', 1997, '9788478884452', 1, 4),
    ('Revista de Ciencia y Tecnología', 2026, NULL, 2, 2),
    ('El Tiempo', 2026, NULL, 3, 2),
    ('Impacto de la inteligencia artificial en la educación superior', 2025, NULL, 4, 5);
GO


INSERT INTO Volumen
    (Numero, Anio, IdPublicacion)
VALUES
    (1, 2026, 6),
    (2, 2026, 6);
GO


INSERT INTO Descriptor
    (Nombre)
VALUES
    ('Literatura'),
    ('Novela'),
    ('Realismo mágico'),
    ('Fantasía'),
    ('Ciencia y tecnología'),
    ('Clásicos'),
    ('Educación'),
    ('Inteligencia artificial'),
    ('Actualidad');
GO


INSERT INTO Autor_Publicacion
    (IdAutor, IdPublicacion)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5),
    (5, 6),
    (6, 8);
GO


INSERT INTO Publicacion_Descriptor
    (IdPublicacion, IdDescriptor)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 2),
    (3, 1),
    (3, 6),
    (4, 1),
    (4, 2),
    (4, 6),
    (5, 2),
    (5, 4),
    (6, 5),
    (7, 9),
    (8, 7),
    (8, 8);
GO