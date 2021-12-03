use AdventureWorks2019; 

-- Consulta 1 
	-- -Saber/Listar qu� territorios generan m�s de 6 millones de d�lares durante este a�o 
	select * from Sales.SalesTerritory where SalesYTD >= 6000000; 



-- Consulta 2
	-- Saber/Listar en qu� territorios se vendi� m�s de 3 millones el a�o pasado
	select * from Sales.SalesTerritory where SalesLastYear > 3000000; 


-- Consulta 4
	-- -Saber qu� encargado regional cuenta con m�s bonos
	select BusinessEntityID from Sales.SalesPerson where Bonus= (select max(Bonus) from Sales.SalesPerson);

-- Consulta 5
	--  Actualizar en la tabla Sales.SalesTerritory el valor de groy = �North America� por �America�	
	select * from Sales.SalesTerritory; 
	select COUNT(*) as total_America from Sales.SalesTerritory where "Group"= 'America';
	update Sales.SalesTerritory
	set "Group" = 'America'
	where "Group" = 'North America'; 
	
	select * from Person.Person;
-- Consulta 6
	-- Saber/listar la cantidad de consumidores por territorio
	select distinct TerritoryID, count(*) as 'Cantidad de clientes' from AdventureWorks2019.Sales.Customer 
	group by TerritoryID


-- Consulta 7
	-- Modificar/Actualizar el nombre de la tienda �Tire Company� por �Wire Company�
	Update AdventureWorks2019.Sales.Store
	set Name = 'Tired Company' from AdventureWorks2019.Sales.Store
	where Name = 'Tire Company'



-- Consulta 8
	-- 8. Listar los usuarios que reciben promoci�n por email (�EmailPromotion� de la tabla Person.Person) 
	-- que tengan tarjeta de cr�dito �ColonialVoice� (Incolucra tabla Sales.CreditCard y Sales.PersonCreditCard)


	select * from Person.Person; 
	select * from Sales.CreditCard; 
	select * from Sales.PersonCreditCard; 

	select Person.Person.FirstName, Person.Person.LastName, Person.Person.EmailPromotion, Person.Person.BusinessEntityID, 
		Sales.CreditCard.CardType 
		from Person.Person join Sales.PersonCreditCard
		on Person.Person.BusinessEntityID = Sales.PersonCreditCard.BusinessEntityID
		join Sales.CreditCard on Sales.PersonCreditCard.CreditCardID = Sales.CreditCard.CreditCardID 
		where Sales.CreditCard.CardType = 'ColonialVoice' and Person.Person.EmailPromotion = 1;

-- Consulta 9
	--9.-Modificar el bono del encargado regional que tenga el mayor n�mero de ventas de este a�o.
		update Sales.SalesPerson 
		set Bonus = 8000.00 
		where SalesYTD =(select max(SalesYTD) MayorVentas from Sales.SalesPerson);

		select * from Sales.SalesPerson where SalesYTD =(select max(SalesYTD) MayorVentas from Sales.SalesPerson); 

-- Consulta 10
	-- Modificar/Actualizar el bono de un encargado regional que no haya vendido nada el a�o pasado.
		update Sales.SalesPerson 
		set Bonus = 1000.00
		where SalesYTD =(select min(SalesYTD) MayorVentas from Sales.SalesPerson); 

		select * from Sales.SalesPerson where SalesYTD =(select min(SalesYTD) MayorVentas from Sales.SalesPerson); 


-- Consulta 11
	-- 11.-Saber el nombre completo de los encargados regionales 
	select Person.Person.FirstName, Person.Person.MiddleName, Person.Person.LastName 
	from Person.Person
	where BusinessEntityID between 274 and 290;
-- Consulta 12
	-- Listar las tiendas al cargo del encargado regional (SalesPerson) con ID 275
	select * from Sales.SalesTerritory; 
	select * from Sales.Store; -- las tiendas que tiene un due�o 
	select * from Sales.SalesPerson; -- due�o regionales 


	select Sales.Store.BusinessEntityID, Sales.Store.Name, Sales.SalesPerson.BusinessEntityID
	from Sales.Store join Sales.SalesPerson 
	on Sales.SalesPerson.BusinessEntityID = Sales.Store.SalesPersonID 
	where Sales.SalesPerson.BusinessEntityID = 275; 

-- Consulta 13 
	-- . Eliminar productos dentro de un pedido 
	DELETE FROM Sales.SalesOrderDetail WHERE ProductID Between 740 and 750;

-- Consulte 14 
	-- .Eliminar cliente con n�mero de cuenta AW00000001
	delete from Sales.Customer where AccountNumber='AW00000001'



