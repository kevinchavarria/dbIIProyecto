use ProyectoDBII_Last
SELECT * FROM DISPONIBILIDAD_TECNICOS
--ADD
GO
ALTER PROCEDURE spAddDisponibilidadTecnico @tecnicoID numeric, @estado varchar, @desde datetime, @hasta datetime
AS
DECLARE @id numeric
SELECT @id=ISNULL(MAX(id),0)+1 FROM DISPONIBILIDAD_TECNICOS
INSERT INTO DISPONIBILIDAD_TECNICOS(id, tecnicoID, estado,desde, hasta) VALUES
(@id, @tecnicoID, @estado,@desde, @hasta)
GO

SELECT * FROM TECNICOS
EXEC spAddDisponibilidadTecnico 3, 'O', '07-11-2021 12:00', '07-11-2021 16:00'

--UPDATE
GO
ALTER PROCEDURE spUpdateDisponibilidadTecnico @tecnicoID numeric , @estado varchar =NULL, @desde datetime = NULL, @hasta datetime = NULL
AS
UPDATE DISPONIBILIDAD_TECNICOS SET 
estado=ISNULL(@estado, estado),
desde=ISNULL(@desde, desde),
hasta=ISNULL(@hasta, hasta)
WHERE tecnicoID=@tecnicoID
GO

EXEC spUpdateDisponibilidadTecnico 3, @estado='D'
SELECT * FROM DISPONIBILIDAD_TECNICOS

--DELETE
GO
ALTER PROCEDURE spDeleteDisponibilidadTecnico @registroID numeric
AS
	DELETE FROM DISPONIBILIDAD_TECNICOS WHERE id= @registroID
GO

--TESTS
EXEC spAddDisponibilidadTecnico 
EXEC spDeleteDisponibilidadTecnico 3

ALTER TABLE DISPONIBILIDAD_TECNICOS ADD id numeric not null primary key