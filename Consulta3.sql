-- Consulta3
	---Saber que encargado por fragmento cuenta con mas bonos
	-- select BusinessEntityID from SalesPerson where Bonus= (select max(Bonus) from SalesPerson);

GO
ALTER procedure regional_bonos as
begin
	
	DECLARE @sql nvarchar (500);


	DECLARE @servidor varchar (100);
	DECLARE @nom_bd varchar (100);
	DECLARE @nom_tabla varchar (100);
	DECLARE @columnas varchar (500); 

	DECLARE @condicion varchar (100); 
	DECLARE @i int = 0; 
	DECLARE @tabla1 varchar (100);
	DECLARE @tabla2 varchar (100);
	SET @tabla1 = 'SalesPerson';
	SET @tabla2 = 'LSERVER2.PersonInfo.dbo.Person'

	--select Sales.SalesPerson.BusinessEntityID, Person.Person.FirstName, Person.Person.LastName
	--from Sales.SalesPerson join Person.Person
	--on Sales.SalesPerson.BusinessEntityID = Person.Person.BusinessEntityID
	--where Bonus= (select max(Bonus) from Sales.SalesPerson);

	SET @columnas = ' SalesPerson.BusinessEntityID, Person.FirstName, Person.LastName ';
	
	while @i<2
	begin
		set @i = @i+1; 
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where  id_fragmento= @i; 


		set @sql = 'select ' + @columnas + ' from ' 
		+ '[' + @servidor +']'+'.'+ @nom_bd + '.dbo.' + @tabla1 +' join '
		+ @tabla2
		+ ' on ' +@tabla1+'.BusinessEntityID = Person.BusinessEntityID '
		+ 'where Bonus = (select max(Bonus) from ' + '[' + @servidor +']'+'.'+ @nom_bd + '.dbo.' + @tabla1 +')'; 
		
		
		exec sp_executesql @sql
		print @sql;

	end

end

exec regional_bonos;