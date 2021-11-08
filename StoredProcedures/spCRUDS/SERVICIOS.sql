ALTER procedure spAddServicios @nombre varchar(50), @precio float, @tipo varchar(1)
as

DECLARE @id NUMERIC
SELECT @id=isnull(MAX(id),0)+1 FROM Servicios
		IF @tipo='I'
			insert into SERVICIOS values (@id,@nombre,@precio,@tipo)
		ELSE
			THROW 51000, 'El servicio no es individual', 1


go
EXEC spAddServicios 'Actualización de software a impresora de carnet', 30000, 'P'
SELECT * FROM SERVICIOS

--UPDATE
Create procedure spUpdateServicios @id numeric,@nombre varchar(50) = null,  @precio float = null, @tipo varchar(1)=null
as 
Update SERVICIOS
SET
nombre = ISNULL(@nombre,nombre),
precio= ISNULL(@precio,precio),
tipo= ISNULL(@tipo,tipo)
where id = @id
go

EXEC spUpdateServicios 10, @precio=10000

Create procedure spDeleteServicios @id numeric
as
Delete SERVICIOS where id = @id
go

SELECT * FROM SERVICIOS
EXEC spDeleteServicios 10