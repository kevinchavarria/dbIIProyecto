Create procedure spAddTecnicos @nombre varchar(50), @telefono varchar(10), @area varchar(15)
as

DECLARE @id NUMERIC
SELECT @id=isnull(MAX(id),0)+1 FROM TECNICOS

insert into TECNICOS values (@id,@nombre,@telefono,@area)

go

EXEC spAddTecnico 'Santiago Pérez', '9203-9302', 'Validadoras'

Create procedure spUpdateTecnico @id numeric,@nombre varchar(50) = null, @telefono varchar(10)=null, @area varchar(15)=null
as 

Update TECNICOS
SET

nombre = ISNULL(@nombre,nombre),
telefono= ISNULL(@telefono,telefono),
area= ISNULL(@area,area)
where id = @id
go
SELECT * FROM TECNICOS
EXEC spUpdateTecnico 3, @telefono='9000-0990'

Create procedure spDeleteTecnico @id numeric
as
Delete TECNICOS where id = @id

go
