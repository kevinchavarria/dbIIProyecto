USE ProyectoDBII_Last

SELECT * FROM FACTURA_SERVICIO

--ADD
GO
ALTER PROCEDURE spAddFacturaServicio  @servicioID numeric, @valor float, @fecha datetime, @ordenID numeric
AS
DECLARE @id numeric
SELECT @id=ISNULL(MAX(id),0)+1 FROM FACTURA_SERVICIO
INSERT INTO FACTURA_SERVICIO(id, servicioID, valor, fecha, ordenID) VALUES
(@id, @servicioID, @valor, @fecha, @ordenID)
GO
--:
SELECT * FROM SERVICIOS
SELECT * FROM ORDEN_TRABAJO
SELECT * FROM FACTURA_SERVICIO
EXEC spAddFacturaServicio 1, 5000, '07-11-2021 11:30', 1
--:

--UPDATE
GO
ALTER PROCEDURE spUpdateFacturaServicio @id numeric ,@ordenID numeric =NULL, @servicioID NUMERIC = NULL, @valor FLOAT =NULL, @fecha DATETIME = NULL 
AS
UPDATE FACTURA_SERVICIO SET
ordenID= ISNULL(@ordenID,ordenID),
servicioID= ISNULL(@servicioID, servicioID), 
valor= ISNULL(@valor, valor), 
fecha = ISNULL(@fecha, fecha)

WHERE id=@id
GO
--:
SELECT * FROM FACTURA_SERVICIO
EXEC spUpdateFacturaServicio 1, @ordenId=2
--:

--DELETE
GO
CREATE PROCEDURE spDeleteFacturaServicio @id numeric
AS
DELETE FROM FACTURA_SERVICIO WHERE id=@id
GO
--:
EXEC spDeleteFacturaServicio 2
SELECT * FROM FACTURA_SERVICIO