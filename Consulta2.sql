-- Consulta 2
	-- Saber/Listar en qué territorios se vendió más de 3 millones el año pasado
	select * from Sales.SalesTerritory where SalesLastYear > 3000000; 

alter procedure territorio_mayor_aniopast as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @sql nvarchar(1000);
	declare @sql1 nvarchar(1000);
	declare @sqlt nvarchar(1000);
	declare @condicion varchar(200);
	declare @i int = 0;
	set @condicion ='SalesLastYear > 3000000'
	set  @nom_tabla='SalesTerritory';

	while @i<2
	begin
		set @i = @i+1;
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where id_fragmento = @i;
		
		if @servidor='SQLMYSQL'
		begin
			--print N'Aquí va la consulta para MySQL'
			set @sql1 ='select * from openquery ('+ @servidor + ',''select "'+@nom_bd+'" as "Territorio" ,SalesLastYear as "Ventas Año Pasado", Name as País from ' + @nom_bd + '.' + @nom_tabla + ''+' where ' + @condicion + ''')';

		end
		else
			set @sql = 'select '''+@nom_bd+''' as Territorio, SalesLastYear as "Ventas Año Pasado", Name as País from ' + @servidor + '.' + @nom_bd + '.Sales.'+ @nom_tabla + ' '+  'where ' + @condicion +'';
		
		set @sqlt = ''+@sql +' union '+ @sql1;
		exec sp_executesql @sqlt
		end 
end

exec territorio_mayor_aniopast;

/*
select * from openquery(SQLMYSQL, 'SELECT * FROM RMundo.SalesTerritory where SalesLastYear > 3000000');
select * from SSQLSERVER11.US.Sales.SalesTerritory where SalesLastYear > 3000000
*/