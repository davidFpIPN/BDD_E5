use AdventureWorks2019; 

-- Consulta 1 
	-- -Saber/Listar qué territorios generan más de 6 millones de dólares durante este año 
	select * from Sales.SalesTerritory; 

	select * from Sales.SalesTerritory where SalesYTD >= 6000000; 



-- Consulta 2
	-- Saber/Listar en qué territorios se vendió más de 3 millones el año pasado
	select * from Sales.SalesTerritory where SalesLastYear > 3000000; 


-- Consulta 3
	-- -Saber qué encargado regional cuenta con más bonos
	select BusinessEntityID from Sales.SalesPerson where Bonus= (select max(Bonus) from Sales.SalesPerson);


-- Consulta 4
-- Listar el numero total de personas que manejan cada tarjeta

		select count(*) as TotalXTarjeta, Sales.CreditCard.CardType
		from Sales.CreditCard join Sales.PersonCreditCard
		on Sales.PersonCreditCard.CreditCardID = Sales.CreditCard.CreditCardID
		group by CardType;

	
	
-- Consulta 5
	-- Saber/listar la cantidad de consumidores por territorio
	select distinct TerritoryID, count(*) as 'Cantidad de clientes' from AdventureWorks2019.Sales.Customer 
	group by TerritoryID


-- Consulta 6
	-- Modificar/Actualizar el nombre de la tienda “Tire Company” por “Wire Company”
	Update AdventureWorks2019.Sales.Store
	set Name = 'Tired Company' from AdventureWorks2019.Sales.Store
	where Name = 'Tire Company'



-- Consulta 7
	-- 7. Listar los usuarios que reciben promoción por email (“EmailPromotion” de la tabla Person.Person) 
	-- que tengan tarjeta de crédito “ColonialVoice” (Incolucra tabla Sales.CreditCard y Sales.PersonCreditCard)


	select * from Person.Person; 
	select CardType from Sales.CreditCard group by CardType; 
	select * from Sales.CreditCard;
	select * from Sales.PersonCreditCard; 

	select count(*) from Sales.PersonCreditCard; 

	select Person.Person.FirstName, Person.Person.LastName, Person.Person.EmailPromotion, Person.Person.BusinessEntityID, 
		Sales.CreditCard.CardType 
		from Person.Person join Sales.PersonCreditCard
		on Person.Person.BusinessEntityID = Sales.PersonCreditCard.BusinessEntityID
		join Sales.CreditCard on Sales.PersonCreditCard.CreditCardID = Sales.CreditCard.CreditCardID 
		where Sales.CreditCard.CardType = 'ColonialVoice' and Person.Person.EmailPromotion = 1;




-- Consulta 8
	--8.-Modificar el bono del encargado regional que tenga el mayor número de ventas de este año.
		update Sales.SalesPerson 
		set Bonus = 8000.00 
		where SalesYTD =(select max(SalesYTD) MayorVentas from Sales.SalesPerson);

		select * from Sales.SalesPerson where SalesYTD =(select max(SalesYTD) MayorVentas from Sales.SalesPerson); 

-- Consulta 9
	-- Modificar/Actualizar el bono de un encargado regional que no haya vendido nada el año pasado.
		update Sales.SalesPerson 
		set Bonus = 1000.00
		where SalesYTD =(select min(SalesYTD) MayorVentas from Sales.SalesPerson); 

		select * from Sales.SalesPerson where SalesYTD =(select min(SalesYTD) MayorVentas from Sales.SalesPerson); 

	

-- Consulta 10
	-- Listar las tiendas al cargo del encargado regional (SalesPerson) con ID 275
	select * from Sales.SalesTerritory; 
	select * from Sales.Store; -- las tiendas que tiene un dueño 
	select * from Sales.SalesPerson; -- dueño regionales 


	select Sales.Store.BusinessEntityID, Sales.Store.Name, Sales.SalesPerson.BusinessEntityID
	from Sales.Store join Sales.SalesPerson 
	on Sales.SalesPerson.BusinessEntityID = Sales.Store.SalesPersonID 
	where Sales.SalesPerson.BusinessEntityID = 275; 

-- Consulta 11
	-- Listar el nombre de los encargados regionales (usando la tabla Sales.Person)

-- Consulte 12
	-- .Eliminar cliente con número de cuenta AW00000001
	delete from Sales.Customer where AccountNumber='AW00000001'



