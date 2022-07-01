USE proyecto2
go
IF OBJECT_ID('dbo.sp_crea_pelicula') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_crea_pelicula
    IF OBJECT_ID('dbo.sp_crea_pelicula') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.sp_crea_pelicula >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.sp_crea_pelicula >>>'
END
go
-- crea el stored procedure
        CREATE PROC dbo.sp_crea_pelicula (                				
		  @i_primaryTitle varchar(100),
		  @i_averageRating int,
          @i_numVotes int
		  )
        as

/****************************************************************************
  Archivo: sp_crea_peliculas										*
  Stored procedure:   sp_crea_peliculas       			            *
  Base de datos: proyecto2                    			      	      			*
  Producto: Base de datos 2      				              			*
  Disenado por: Grupo de bases				  	              					*
  Fecha de escritura: 30/06/2022		                                    *
  URL documentaci¢n SP: 													*
*****************************************************************************
              		PROPOSITO	              		      					*
  Crear una pelicula, replicarla y relacionarla en su respectivo raiting    *	      																			
****************************************************************************/
--Primero vamos a verificar que exista la pelicula
declare
@w_id_pelicula int = 0,
@w_ID int = 0,
@w_TitleType_id int,
@w_primaryTitle varchar(100),
@w_originalTitle varchar(100),
@w_isAdult int, 
@w_startYear varchar(11), 
@w_endyear varchar(11),
@w_runtime int

if exists(Select opn.TitleType_id,opn.primaryTitle FROM OPENQUERY([AAAAA],
     '
	  SELECT
          TitleType_id,
           primaryTitle
     FROM Title'
  
) AS opn
where opn.primaryTitle = @i_primaryTitle)
begin
--insertar en la base de datos de netflix
 
 insert into [B].[proyecto2].dbo.Title (TitleType_id,primaryTitle,originalTitle,isAdult, startYear, endyear,runtime)
 Select opn.TitleType_id,opn.primaryTitle,opn.originalTitle,opn.isAdult, opn.startYear, opn.endyear,opn.runtime
 FROM OPENQUERY([AAAAA],
     '
	  SELECT
           TitleType_id,
           primaryTitle,
           originalTitle,
           isAdult, 
           startYear, 
           endyear,
           runtime
     FROM Title'
  
) AS opn
where opn.primaryTitle = @i_primaryTitle
  
--realizar insert a rating imbd

Select opn.TitleType_id 'Titulo',opn.primaryTitle 'Nombre',opn.originalTitle 'Nombre Orginal',opn.isAdult 'Apta para adultos',
opn.startYear 'Año incio', opn.endyear 'Año fin' ,opn.runtime 'Tiempo produccion', opn.averageRating 'Promedio Rating', opn.numVotes 'Votos'
 FROM OPENQUERY([AAAAA],
     '
	  SELECT
	       a.id,
           a.TitleType_id,
           a.primaryTitle ,
           a.originalTitle,
           a.isAdult, 
           a.startYear, 
           a.endyear,
           a.runtime,
		   b.averageRating,
		   b.numVotes
     FROM Title a, Rating b
	 where a.id = b.Title_id'
  
) AS opn
where opn.primaryTitle = @i_primaryTitle


end
	else
begin
      RAISERROR (9999,-1,-1, 'No existe pelicula');  
      return 1
end


return 0

go
IF OBJECT_ID('dbo.sp_crea_pelicula') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.sp_crea_pelicula >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.sp_crea_pelicula >>>'
go
