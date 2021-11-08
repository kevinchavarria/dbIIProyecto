use ProyectoDBII_Last
--CREATE
Create procedure spAddOrdenTrabajo @clienteID numeric, @fechainicio datetime, @fechafinal datetime
as
DECLARE @id NUMERIC
DECLARE @tec NUMERIC

SELECT @id=isnull(MAX(id),0)+1 FROM ORDEN_TRABAJO
select @tec = tecnicoID from CONTRATOS where clienteID=@clienteID 
insert into ORDEN_TRABAJO values (@id,@clienteID,@fechainicio,@fechafinal,'A')

go

EXEC spAddOrdenTrabajo 1,'02-11-2021 08:00', '02-11-2021 12:00'

--DELETE
Create procedure spDeleteOrdenTrabajo @id numeric
as
Delete ORDEN_TRABAJO where id = @id

go
EXEC spDeleteOrdenTrabajo 2

SELECT * FROM ORDEN_TRABAJO

--UPDATE
alter procedure spUpdateOrdenTrabajo @id numeric , @clienteID numeric = null, @fechainicio datetime = null, @fechafinal datetime = null, @estado varchar = null
as 
Update ORDEN_TRABAJO
SET
clienteID = ISNULL(@clienteID,clienteID),
fechaInicio= ISNULL(@fechainicio,fechaInicio),
estado= ISNULL(@estado,estado),
fechaFinal = ISNULL(@fechafinal,fechaFinal)
where id = @id
go
EXEC spUpdateOrdenTrabajo 1, @fechafinal='01-11-2021 12:00'
SELECT * FROM ORDEN_TRABAJO