--:
SELECT  * FROM DETALLE_ORDEN_TRABAJO
--:

GO
ALTER PROCEDURE spAddDetalleOrdenTrabajo
@ordentrabajoid numeric, @tecnicoid numeric, @servicioid numeric  
AS
	DECLARE @ID AS INT
	SELECT @ID = ISNULL(MAX(ID),0) + 1 FROM DETALLE_ORDEN_TRABAJO
	INSERT INTO DETALLE_ORDEN_TRABAJO VALUES(@ID, @ORDENTRABAJOID, @TECNICOID, @SERVICIOID)
GO
--:
SELECT  * FROM DETALLE_ORDEN_TRABAJO
SELECT * FROM ORDEN_TRABAJO
EXEC spAddDetalleOrdenTrabajo 1, 1,8
--:


--UPDATE
GO
CREATE PROCEDURE spUpdateDetalleOrdenTrabajo 
@id numeric = NULL, @ordentrabajoID numeric =NULL , @tecnicoID numeric =NULL, @servicioID numeric =NULL 
AS
	UPDATE DETALLE_ORDEN_TRABAJO SET
	ordenTrabajoID= ISNULL(@ordenTrabajoID, ordenTrabajoID),
	tecnicoId= ISNULL(@tecnicoID,tecnicoId),
	servicioID= ISNULL(@servicioID, servicioID)
	WHERE id=@id
GO

--:
SELECT * FROM DETALLE_ORDEN_TRABAJO
EXEC spUpdateDetalleOrdenTrabajo 1 ,@tecnicoID=2
select * from DETALLE_ORDEN_TRABAJO
--:

--DELETE
GO
CREATE PROCEDURE spDeleteDetalleOrdenTrabajo @id numeric
AS
	DELETE FROM DETALLE_ORDEN_TRABAJO WHERE id=@id
GO
--:
select * from DETALLE_ORDEN_TRABAJO
EXEC spDeleteDetalleOrdenTrabajo 2
select * from DETALLE_ORDEN_TRABAJO
