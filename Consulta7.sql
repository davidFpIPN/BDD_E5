-- Consulta 7
	-- 7. Listar los usuarios que reciben promoción por email (“EmailPromotion” de la tabla Person.Person) 
	-- que tengan tarjeta de crédito “ColonialVoice” (Incolucra tabla Sales.CreditCard y Sales.PersonCreditCard)

select P.FirstName, P.LastName, P.EmailPromotion, P.BusinessEntityID, CC.CardType 
	from AdventureWorks2019.Person.Person P
	join AdventureWorks2019.Sales.PersonCreditCard PC on P.BusinessEntityID = PC.BusinessEntityID
	join AdventureWorks2019.Sales.CreditCard CC on PC.CreditCardID = CC.CreditCardID 
	where CC.CardType = 'ColonialVoice' and P.EmailPromotion = 1;

go
alter procedure usuarios_promocion @offs nvarchar(5) = '0' as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla1 nvarchar(100);
	declare @nom_tabla2 nvarchar(100);
	declare @nom_tabla3 nvarchar(100);
	declare @sql nvarchar(1000);
	declare @sql1 nvarchar(1000);
	declare @sqlt nvarchar(1000);
	declare @condicion varchar(200);
	declare @i int = 0;
	set @nom_tabla1 = 'Person';
	set @nom_tabla2 = 'PersonCreditCard';
	set @nom_tabla3 = 'CreditCard';
	set @condicion = @nom_tabla3 + '.CardType = ''ColonialVoice'' and ' + @nom_tabla1 + '.EmailPromotion = 1'

	
	select @servidor = servidor, @nom_bd = bd from diccionario_dist where id_fragmento = 3;

	set @sql = 'select '+ @nom_tabla1 + '.FirstName, ' + @nom_tabla1 + '.LastName, ' + @nom_tabla1 + '.EmailPromotion, ' + @nom_tabla1 + '.BusinessEntityID, ' + @nom_tabla3 + '.CardType '
	+ ' from ' + @servidor + '.' + @nom_bd + '.dbo.' + @nom_tabla1 
	+ ' join ' + @servidor + '.' + @nom_bd + '.dbo.' + @nom_tabla2 + ' on ' + @nom_tabla1 + '.BusinessEntityID = ' + @nom_tabla2 + '.BusinessEntityID'
	+ ' join ' + @servidor + '.' + @nom_bd + '.dbo.' + @nom_tabla3 + ' on ' + @nom_tabla2 + '.CreditCardID = ' + @nom_tabla3 + '.CreditCardID '
	+ ' where ' + @condicion + ' order by CardType asc'
	+ ' OFFSET '+ @offs +' ROWS FETCH NEXT 100 ROWS ONLY'
	
	--select @sql;
	exec sp_executesql @sql	
end

exec usuarios_promocion @offs = '900'