CREATE PROCEDURE spAddContrato @clienteID numeric, @fechaInicio date,@fechafinal date ,@tecnicoID numeric
AS
DECLARE @id NUMERIC
SELECT @id =isnull(MAX(id),0)+1 FROM CONTRATOS
insert into CONTRATOS(id, clienteID,fechaContrato, fechaFinalizacion, tecnicoID) values (@id,@ClienteId,@fechaInicio,@fechafinal,@tecnicoID)
GO

--UPDATE
ALTER PROCEDURE [dbo].[spUpdateContrato] @contratoID numeric, @clienteID numeric=NULL, @tecnicoID numeric=NULL, @fechaFinalizacion date=NULL,  @fechaContrato date=NULL
AS
	BEGIN
		SELECT @fechaContrato=cast( GETDATE() AS DATE)
		--Fecha de hoy
		 BEGIN TRY
            BEGIN TRANSACTION
				IF @clienteID IS NOT NULL
					UPDATE CONTRATOS SET clienteID=@clienteID WHERE id=@contratoID
				IF @tecnicoID IS NOT NULL 
					UPDATE CONTRATOS SET tecnicoID=@tecnicoID WHERE id=@contratoID
				IF @fechaContrato IS NOT NULL
					UPDATE CONTRATOS SET fechaContrato=@fechaContrato WHERE id=@contratoID
				IF @fechaFinalizacion IS NOT NULL
					UPDATE CONTRATOS SET fechaFinalizacion=@fechaFinalizacion WHERE id=@contratoID
				
				
				IF @@TRANCOUNT > 0
                COMMIT
		END TRY
	BEGIN CATCH
            IF @@TRANCOUNT > 0
			 ROLLBACK;
            SELECT ERROR_NUMBER() AS ErrorNumber;
            SELECT ERROR_MESSAGE() AS ErrorMessage;
        END CATCH;
    END
--DELETE

CREATE PROCEDURE spDeleteContrato @id numeric
AS
DELETE FROM CONTRATOS WHERE id= @id