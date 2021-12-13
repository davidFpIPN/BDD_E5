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

	DECLARE @IDENTIF int;
	
	DECLARE @condicion varchar (100); 
	DECLARE @i int = 0; 
	DECLARE @tabla1 varchar (100);
	DECLARE @tabla2 varchar (100);
	SET @tabla1 = 'SalesPerson';
	SET @tabla2 = 'LSERVER1.PersonInfo.dbo.Person'

	CREATE TABLE #BonosPReg(Territorio  varchar(25), ID int, FirstName varchar(25), LastName varchar(25));

	SET @columnas = ' SalesPerson.BusinessEntityID, Person.FirstName, Person.LastName ';
	
	while @i<2
	begin
		set @i = @i+1; 
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where  id_fragmento= @i; 


		set @sql = N'insert into #BonosPReg(ID , FirstName, LastName)'+
		'( select ' + @columnas + ' from ' 
		+ '[' + @servidor +']'+'.'+ @nom_bd + '.dbo.' + @tabla1 +' join '
		+ @tabla2
		+ ' on ' +@tabla1+'.BusinessEntityID = Person.BusinessEntityID '
		+ 'where Bonus = (select max(Bonus) from ' + '[' + @servidor +']'+'.'+ @nom_bd + '.dbo.' + @tabla1 +'))'; 
				
		exec sp_executesql @sql
		SELECT @IDENTIF = ID FROM #BonosPReg
		--SELECT @sql;
		update #BonosPReg set Territorio = @nom_bd where ID = @IDENTIF;

	end
	select * from #BonosPReg
end
exec regional_bonos;