-- Consulta 6
	-- Saber/listar la cantidad de consumidores por territorio
	/*select distinct TerritoryID, count(*) as 'Cantidad de clientes' from AdventureWorks2019.Sales.Customer 
	group by TerritoryID*/

alter procedure customer_territory as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @sql nvarchar(1000);
	declare @sql1 nvarchar(1000);
	declare @sqlt nvarchar(1000);
	declare @condicion varchar(200);
	declare @i int = 0;
	set @condicion ='TerritoryID'
	set  @nom_tabla='Customer';

	while @i<2
	begin
		set @i = @i+1;
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where id_fragmento = @i;
		
		if @servidor='SQLMYSQL'
		begin
			--print N'Aquí va la consulta para MySQL'
			set @sql1 ='select * from openquery ('+ @servidor + ',''select "'+@nom_bd+'" as "Territorio" ,TerritoryID as "ID País", count(*) as "Cantidad de clientes" from ' + @nom_bd + '.' + @nom_tabla + ' '+ ' group by '+ @condicion +''')';

		end
		else
			set @sql = 'select '''+@nom_bd+''' as Territorio,TerritoryID as "ID País", count(*) as "Cantidad de clientes" from ' + @servidor + '.' + @nom_bd + '.Sales.'+ @nom_tabla + ' '+  'group by ' + @condicion +'';
		
		set @sqlt = ''+@sql +' union '+ @sql1;
		exec sp_executesql @sqlt
		end 
end

exec customer_territory;

/*
select * from openquery(SQLMYSQL, 'SELECT TerritoryID as "ID País", count(*) as "Cantidad de clientes" FROM RMundo.Customer group by TerritoryID');
select TerritoryID as ID_País ,count(*) as 'Cantidad de clientes' from SSQLSERVER11.US.Sales.Customer group by TerritoryID
select * from SSQLSERVER11.US.Sales.Customer 
*/