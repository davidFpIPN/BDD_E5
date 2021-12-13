-- Consulta 1 
	-- -Saber/Listar qu� territorios generan m�s de 6 millones de d�lares durante este a�o -> select * from Sales.SalesTerritory where SalesYTD >= 6000000; 


alter procedure territorio_mayormoney as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @sql nvarchar(1000);
	declare @condicion varchar(200);
	declare @i int = 0;
	set @condicion ='SalesYTD >= 6000000'
	set  @nom_tabla='SalesTerritory';
	
	CREATE TABLE #VentasTemp (Territorio  varchar(25), Ventas MONEY, Pais varchar(25));
	
	while @i<2
	begin
		set @i = @i+1;
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where id_fragmento = @i;
		set @sql = N'insert into #VentasTemp(Territorio, Ventas, Pais) (select '''+@nom_bd+''', SalesYTD, Name from ' + @servidor + '.' + @nom_bd + '.dbo.'+ @nom_tabla + ' where ' + @condicion +')';
		exec sp_executesql @sql		
	end 
	select * from #VentasTemp;
end


exec territorio_mayormoney;

/*select * from openquery(SQLMYSQL, 'SELECT * FROM RMundo.SalesTerritory where SalesYTD >= 6000000');
select * from SSQLSERVER11.US.Sales.SalesTerritory where SalesYTD >= 6000000
*/
