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

		
		--exec sp_executesql @sql
		select @sql;
		end 
END

exec EliminarCliente @NumeroCuenta ='AW00000002';

/* Para insertar los tatos de nuevo me base en la tabla original Sales.Customer de AW2019
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [CustomerID]
      ,[PersonID]
      ,[StoreID]
      ,[TerritoryID]
      ,[AccountNumber]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [America].[dbo].[Customer]

  	delete from Customer where AccountNumber='AW00000001'

	insert into Customer values (1,NULL, 934,1,'AW00000001','3F5AE95E-B87D-4AED-95B4-C3797AFCB74F','2014-09-12 11:15:07.263');
	insert into Customer values (2,NULL, 1028,1,'AW00000002','E552F657-A9AF-4A7D-A645-C429D6E02491','2014-09-12 11:15:07.263'); 
*/

