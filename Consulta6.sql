-- Consulta 6
	-- Modificar/Actualizar el nombre de la tienda “Tire Company” por “Wire Company”


alter procedure cambiar_nombre as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @sql nvarchar(1000);
	declare @sql1 nvarchar(1000);
	declare @sqlt nvarchar(1000);
	declare @condicion varchar(200);
	declare @i int = 0;
	set @condicion ='Name = ''Wire Company'''
	set  @nom_tabla='Store';

	while @i<2
	begin
		set @i = @i+1;
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where id_fragmento = @i;

		set @sql = 'Update '+ @nom_tabla + ' set Name = ''Tired Company'' from ' + @servidor + '.' + @nom_bd + '.dbo.'+ @nom_tabla + ' '
		+  'where ' + @condicion;
		select @sql;
		--exec sp_executesql @sql
	end 
end


/*select * from openquery(SQLMYSQL, 'SELECT * FROM RMundo.SalesTerritory where SalesYTD >= 6000000');
select * from SSQLSERVER11.US.Sales.SalesTerritory where SalesYTD >= 6000000
*/