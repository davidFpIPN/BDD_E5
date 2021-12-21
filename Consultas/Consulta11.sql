/*Consulta 11
- Listar el nombre de los encargados regionales (usando la tabla Sales.Person)*/
alter procedure name_encargados  as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @sql nvarchar(1000);
	declare @sql1 nvarchar(1000);
	declare @sqlt nvarchar(1000);
	declare @condicion varchar(200);

	declare @i int = 0;
	set @condicion =' where BusinessEntityID between 274 and 290';
	set  @nom_tabla='Person';

		set @i = @i+1;
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where bd='PersonInfo';
		
		set @sql = 'Select FirstName, MiddleName, LastName ' + 
			' from '+
			@servidor + '.' + 
			@nom_bd + '.dbo.'+ 
			@nom_tabla + 
			@condicion;
		
		exec sp_executesql @sql
		--select @sql
		 
end

exec name_encargados;
