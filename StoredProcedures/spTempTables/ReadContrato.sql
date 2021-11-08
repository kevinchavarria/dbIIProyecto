

GO
ALTER PROCEDURE spReadContrato @contratoID numeric
AS
	--Variables
	DECLARE @tecnicoID numeric,  @clienteID numeric, @numServicios int, @isPaquete VARCHAR, @paqueteID numeric
	
	--Cantidad de servicios, si es mayor que 1 entonces hay paquete personalizado
	SELECT @numServicios=(COUNT(*)) FROM DETALLE_CONTRATO WHERE contratoID=@contratoID
	--Extracción de tablas temporales con registros necesarios
	SELECT * INTO #tContratos FROM CONTRATOS WHERE id= @contratoID
	SELECT @tecnicoID=tecnicoID FROM #tContratos								--Extracción de valor  para variable
	SELECT * INTO #tTecnicos FROM TECNICOS WHERE id=@tecnicoID
	SELECT @clienteID=clienteID FROM #tContratos
	SELECT * INTO #tClientes FROM CLIENTE WHERE id=@clienteID
	SELECT * INTO #tDetalleContratos FROM DETALLE_CONTRATO WHERE contratoID=@contratoID
	
	--Producto Cartesiano
	SELECT c.id [ID], cte.nombre [Cliente],t.nombre [Tecnico] FROM #tDetalleContratos AS dC 
	JOIN #tContratos AS c ON dC.contratoID=c.id
	JOIN #tClientes AS cte ON cte.id= c.clienteID
	JOIN #tTecnicos AS t ON t.id=c.tecnicoID
	
	SELECT s.nombre[Paquetes Contratados] FROM SERVICIOS as s
	JOIN #tDetalleContratos as dC ON  s.id=dC.servicioID 
	WHERE s.tipo='P'

	SELECT s.nombre[Servicios Extras] FROM SERVICIOS as s
	JOIN #tDetalleContratos as dC ON  s.id=dC.servicioID 
	WHERE s.tipo='I'

-------------------------------------				
SELECT * FROM CONTRATOS
EXEC spReadContrato 3
