-- Consulta 4
-- Listar el numero total de personas que manejan cada tarjeta
-- Esta referido a la instancia 2 base de datos PersonInfo

		

GO
alter procedure PersonasXTarjeta as 
begin
	DECLARE @sql nvarchar (500);

	DECLARE @servidor varchar (100);
	DECLARE @nom_bd varchar (100);
	DECLARE @nom_tabla varchar (100);
	DECLARE @columnas varchar (500); 
	
	set @columnas = 'count(*) as TotalXTarjeta, CardType'
	
	select @servidor = servidor, @nom_bd = bd from diccionario_dist where bd='PersonInfo'; 
	

	set @sql = 'select '+ @columnas + ' from ' + @servidor +'.'+ @nom_bd + '.dbo.' + 'CreditCard join '+ 
	+ @servidor +'.'+ @nom_bd + '.dbo.' + 'PersonCreditCard'+ ' on ' +
	'PersonCreditCard.CreditCardID = ' +'CreditCard.CreditCardID ' +
	'group by ' + 'CardType';

	
	exec sp_executesql @sql
	print @sql;

end 

exec PersonasXTarjeta; 