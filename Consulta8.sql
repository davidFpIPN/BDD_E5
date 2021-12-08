-- Consulta 8
	--8.-Modificar el bono del encargado regional que tenga el mayor número de ventas de este año.

go
create procedure Bonos_MasVentas as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @sql nvarchar(1000);
	declare @sql1 nvarchar(1000);
	declare @sqlt nvarchar(1000);
	declare @condicion varchar(200);
	declare @i int = 0;
	set @condicion ='SalesYTD =(select max(SalesYTD) MayorVentas from '
	set  @nom_tabla='SalesPerson';

	while @i<2
	begin
		set @i = @i+1;
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where id_fragmento = @i;
		

			set @sql = 'Update '+ @nom_tabla + ' set Bonus = 8000.00 from ' + @servidor + '.' + @nom_bd + '.dbo.'+ @nom_tabla + ' '+  'where ' + @condicion + @servidor + '.' + @nom_bd + '.dbo.'+ @nom_tabla +')';
		select @sql;
		exec sp_executesql @sql
		end 
end