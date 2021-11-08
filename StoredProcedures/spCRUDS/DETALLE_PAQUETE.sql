--:
SELECT * FROM DETALLE_PAQUETE
--:
--ADD

ALTER PROCEDURE spAddDetallePaquete
@ServicioId int, @PaqueteId int
AS
	BEGIN TRY
		DECLARE @id numeric
		DECLARE @tipo varchar
		SELECT @id=ISNULL(MAX(id),0)+1 FROM DETALLE_PAQUETE
		SELECT @tipo=tipo FROM SERVICIOS WHERE id=@ServicioId
		IF @tipo='I'
			INSERT INTO DETALLE_PAQUETE(id,paqueteID, servicioID) VALUES
			(@id,@paqueteID, @servicioID)
		ELSE
			THROW 51000, 'El servicio no es individual', 1
	END TRY
	BEGIN CATCH
		THROW
	END CATCH;
GO
--:
EXEC spAddDetallePaquete 7,7
SELECT * FROM DETALLE_PAQUETE
--:

--UPDATE
ALTER PROCEDURE spUpdateDetallePaquete
@id numeric, @ServicioID numeric=NULL, @PaqueteID numeric= NULL, @sc numeric =NULL, @pc numeric= NULL
AS
	BEGIN TRY
		BEGIN TRANSACTION
			IF @PaqueteID IS NOT NULL
				BEGIN
					DECLARE @isPaquete VARCHAR
					SELECT @isPaquete=(tipo) FROM SERVICIOS WHERE id=@PaqueteID
					IF @isPaquete='P'
						UPDATE DETALLE_PAQUETE SET paqueteID=@PaqueteID WHERE id=@id
					ELSE
						THROW 52000, 'paqueteID no corresponde a un servicio tipo paquete(P)', 1
				END
			IF @ServicioID IS NOT NULL
				BEGIN
					DECLARE @isServicio VARCHAR
					SELECT @isServicio=tipo FROM SERVICIOS WHERE id=@ServicioId
					IF @isServicio='I'
						UPDATE DETALLE_PAQUETE SET servicioID=@ServicioID WHERE id=@id
					ELSE
						THROW 51000, 'El servicio no es individual', 1
				END
			IF @@TRANCOUNT > 0
				COMMIT
		END TRY
		BEGIN CATCH
            IF @@TRANCOUNT > 0
			 ROLLBACK;
            SELECT ERROR_NUMBER() AS ErrorNumber;
            SELECT ERROR_MESSAGE() AS ErrorMessage;
			THROW
        END CATCH
GO


--DELETE
CREATE PROCEDURE spDeleteDetallePaquete @id numeric
AS
	DELETE FROM DETALLE_PAQUETE WHERE id=@id


EXEC spUpdateDetallePaquete 6, @servicioId=8, @paqueteID=1
SELECT * FROM DETALLE_PAQUETE
SELECT * FROM SERVICIOS