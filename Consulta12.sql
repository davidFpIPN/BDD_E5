-- Consulte 12
	-- .Eliminar cliente dependiendo su numero de cuenta
	-- ejemplo: delete from Sales.Customer where AccountNumber='AW00000001'
	-- enviamos de parametro el numero de cuenta (AccountNumer)

GO
alter PROCEDURE EliminarCliente @NumeroCuenta varchar (100) as 
BEGIN 

	DECLARE @sql nvarchar (500);


	DECLARE @servidor varchar (100);
	DECLARE @nom_bd varchar (100);
	DECLARE @nom_tabla varchar (100);
	DECLARE @columnas varchar (500); 

	DECLARE @condicion varchar (100); 
	DECLARE @i int = 0; 

	SET @nom_tabla = 'Customer'; 

	while @i<2
	begin
		set @i = @i+1;
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where id_fragmento = @i;
		

		set @sql = 'delete '+ 'from ' +  '[' + @servidor +']'+ '.' + @nom_bd + '.dbo.'+ @nom_tabla + ' '+  'where AccountNumber = '''+ @NumeroCuenta +''';' ; 

		
		exec sp_executesql @sql
		print @sql;
		end 
END

exec EliminarCliente @NumeroCuenta ='AW00000002';


