-- Consulta3
	---Saber que encargado regional cuenta con mas bonos
	-- select BusinessEntityID from SalesPerson where Bonus= (select max(Bonus) from SalesPerson);

alter procedure regional_bonos as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @sql nvarchar(1000);
	declare @sql1 nvarchar(1000);
	declare @sqlt nvarchar(1000);
	declare @condicion varchar(200);
	declare @i int = 0;
	set @condicion ='Bonus = (select max(Bonus) from '
	set  @nom_tabla='SalesPerson';

	while @i<2
	begin
		set @i = @i+1;
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where id_fragmento = @i;
		
			set @sql = 'select BusinessEntityID as "Encargado Regional" , TerritoryID as Territorio, Bonus as Bonos from ' + @servidor + '.' + @nom_bd + '.dbo.'+ @nom_tabla + ' '+  'where ' + @condicion + @servidor + '.' + @nom_bd + '.dbo.'+ @nom_tabla + ')';


		
		exec sp_executesql @sql
		end 
end

exec regional_bonos;
