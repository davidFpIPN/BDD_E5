-- Consulta 10
	-- Listar las tiendas al cargo del encargado regional (SalesPerson) con ID 275
	
	
	--select * from Sales.SalesTerritory; 
	--select * from Sales.Store; -- las tiendas que tiene un dueño 
	--select * from Sales.SalesPerson; -- dueño regionales 


	--select Store.BusinessEntityID, Store.Name, SalesPerson.BusinessEntityID
	--from Store join SalesPerson 
	--on SalesPerson.BusinessEntityID = Store.SalesPersonID 
	--where SalesPerson.BusinessEntityID = 275; 

GO 
alter procedure TiendasXEncargado @id_tienda varchar(100) as

begin 
	DECLARE @sql nvarchar (500);


	DECLARE @servidor varchar (100);
	DECLARE @nom_bd varchar (100);
	DECLARE @nom_tabla varchar (100);
	DECLARE @columnas varchar (500); 

	DECLARE @condicion varchar (100); 
	DECLARE @i int = 0; 
	

	SET @columnas = ' Store.BusinessEntityID as SBEI, Store.Name, SalesPerson.BusinessEntityID as SPBEI';

	while @i<2
	begin
		set @i = @i+1; 
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where  id_fragmento= @i; 


		set @sql = 'select ' + @columnas + ' from ' + '[' + @servidor +']'+'.'+ @nom_bd + '.dbo.' + 
		'Store join '+ '[' + @servidor +']' +'.'+ @nom_bd + '.dbo.' + 'SalesPerson'
		+ ' on SalesPerson.BusinessEntityID = Store.SalesPersonID where SalesPerson.BusinessEntityID =' +
		@id_tienda; 
		exec sp_executesql @sql
		print @sql;

	end
	
end

exec TiendasXEncargado @id_tienda = '275';
