-- Consulta 9
	-- Modificar/Actualizar el bono de un encargado regional que no haya vendido nada el año pasado.

go
alter procedure Bonos_MenosVentas as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @sql nvarchar(1000);
	declare @sql1 nvarchar(1000);
	declare @sqlt nvarchar(1000);
	declare @condicion varchar(200);
	declare @i int = 0;
	set @condicion ='SalesYTD =(select min(SalesYTD) MayorVentas from '
	set  @nom_tabla='SalesPerson';

	while @i<2
	begin
		set @i = @i+1;
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where id_fragmento = @i;
		

			set @sql = 'Update '+ @nom_tabla + ' set Bonus = 1000.00 from ' + @servidor + '.' + @nom_bd + '.dbo.'+ @nom_tabla + ' '+  'where ' + @condicion + @servidor + '.' + @nom_bd + '.dbo.'+ @nom_tabla +')';
		select @sql;
		exec sp_executesql @sql
		end 
end