USE [proyecto2] ;

CREATE TABLE Genre (
  [id] INT NOT NULL IDENTITY,
  [name] VARCHAR(50) NOT NULL,
  PRIMARY KEY ([id]))
;

CREATE TABLE TitleType (
  [id] INT NOT NULL IDENTITY,
  [name] VARCHAR(50) NOT NULL,
  PRIMARY KEY ([id]))
;

CREATE TABLE Title (
  id INT NOT NULL IDENTITY,
  TitleType_id INT NOT NULL,
  primaryTitle VARCHAR(100) NOT NULL,
  originalTitle VARCHAR(100) NOT NULL,
  isAdult INT NOT NULL,
  startYear VARCHAR(11) NOT NULL,
  endyear VARCHAR(11) NOT NULL,
  runtime INT NOT NULL,
  PRIMARY KEY ([id]),
  FOREIGN KEY ([TitleType_id]) REFERENCES TitleType ([id])
	)

CREATE TABLE TitleGenre (
  Genre_id INT NOT NULL,
  Title_id INT NOT NULL
  primary key (Genre_id, Title_id),
  FOREIGN KEY (Genre_id) REFERENCES Genre (id),
  FOREIGN KEY (Title_id)REFERENCES Title (id)
  )

CREATE TABLE Region (
  [id] INT NOT NULL IDENTITY,
  [name] VARCHAR(50) NOT NULL,
  PRIMARY KEY ([id]))
;

CREATE TABLE Language (
  [id] INT NOT NULL IDENTITY,
  [name] VARCHAR(70) NOT NULL,
  PRIMARY KEY ([id]))
;

CREATE TABLE AlternativeType (
  [id] INT NOT NULL IDENTITY,
  [name] VARCHAR(50) NOT NULL,
  PRIMARY KEY ([id]))
;

CREATE TABLE AlternativeAttribute (
  [id] INT NOT NULL IDENTITY,
  [name] VARCHAR(50) NOT NULL,
  PRIMARY KEY ([id]))
;

CREATE TABLE AlternativeTitle (
  [id] INT NOT NULL IDENTITY,
  [Title_id] INT NOT NULL,
  [Region_id] INT NOT NULL,
  [Language_id] INT NOT NULL,
  [AlternativeType_id] INT NOT NULL,
  [AlternativeAttribute_id] INT NOT NULL,
  [title] VARCHAR(100) NOT NULL,
  [ordering] INT NOT NULL,
  [isOriginal] INT NOT NULL,
  PRIMARY KEY ([id]),
  FOREIGN KEY ([Title_id]) REFERENCES Title ([id]),
  FOREIGN KEY ([Region_id]) REFERENCES Region ([id]),
  FOREIGN KEY ([Language_id]) REFERENCES Language ([id]),
  FOREIGN KEY ([AlternativeType_id]) REFERENCES AlternativeType ([id]),
  FOREIGN KEY ([AlternativeAttribute_id]) REFERENCES AlternativeAttribute ([id]))

CREATE TABLE Category (
  [id] INT NOT NULL IDENTITY,
  [name] VARCHAR(100) NOT NULL,
  PRIMARY KEY ([id]))
;

CREATE TABLE Name (
  [id] INT NOT NULL IDENTITY,
  [primaryName] VARCHAR(100) NOT NULL,
  [birthYear] VARCHAR(4) NOT NULL,
  [deathYear] VARCHAR(4) NULL,
  PRIMARY KEY ([id]))
;

CREATE TABLE Principal (
  [id] INT NOT NULL IDENTITY,
  [Name_id] INT NOT NULL,
  [Title_id] INT NOT NULL,
  [Category_id] INT NOT NULL,
  [jobId] INT NULL,
  [order] INT NULL,
  [character] INT NULL,
  PRIMARY KEY ([id]),
  FOREIGN KEY ([Name_id]) REFERENCES Name ([id]),
  FOREIGN KEY ([Title_id]) REFERENCES Title ([id]),
  FOREIGN KEY ([Category_id]) REFERENCES Category ([id]))

CREATE TABLE KnowForTitle (
  [Name_id] INT NOT NULL,
  [Title_id] INT NOT NULL
  FOREIGN KEY ([Name_id]) REFERENCES Name ([id]),
  FOREIGN KEY ([Title_id]) REFERENCES Title ([id]))

CREATE TABLE Diretor (
  [Name_id] INT NOT NULL,
  [Title_id] INT NOT NULL
  FOREIGN KEY ([Name_id]) REFERENCES Name ([id]),
  FOREIGN KEY ([Title_id]) REFERENCES Title ([id]))

CREATE TABLE Writer (
  [Name_id] INT NOT NULL,
  [Title_id] INT NOT NULL
  primary key(Name_id,Title_id)
  FOREIGN KEY ([Name_id]) REFERENCES Name ([id]),
  FOREIGN KEY ([Title_id]) REFERENCES Title ([id]))

CREATE TABLE Episode (
  [id] INT NOT NULL IDENTITY,
  [Title_id] INT NOT NULL,
  [parent_id] INT NOT NULL,
  [season] INT NOT NULL,
  [episode] INT NOT NULL,
  PRIMARY KEY ([id]),
  FOREIGN KEY ([Title_id]) REFERENCES Title ([id]),
  FOREIGN KEY ([parent_id]) REFERENCES Title ([id]))

CREATE TABLE Rating (
  [id] INT NOT NULL IDENTITY,
  [Title_id] INT NOT NULL,
  [averageRating] INT NULL,
  [numVotes] INT NULL,
  PRIMARY KEY ([id]),
  FOREIGN KEY ([Title_id]) REFERENCES Title ([id]))

CREATE TABLE Profession (
  [id] INT NOT NULL IDENTITY,
  [name] VARCHAR(100) NOT NULL,
  PRIMARY KEY ([id]))
;

CREATE TABLE NameProfession (
  [Profession_id] INT NOT NULL,
  [Name_id] INT NOT NULL,
  FOREIGN KEY ([Profession_id]) REFERENCES Profession ([id]),
  FOREIGN KEY ([Name_id]) REFERENCES Name ([id]))


insert into TitleType(name) values('Extranjera')
INSERT INTO [dbo].[Title]
           ([TitleType_id]
           ,[primaryTitle]
           ,[originalTitle]
           ,[isAdult]
           ,[startYear]
           ,[endyear]
           ,[runtime])
     VALUES
           (1,
           'Batman',
           'Batman el caballero de la noche'
           ,1
           ,'2012'
           ,'2014'
           ,0)
GO
