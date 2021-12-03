create database US
use US;

create table Sales.SalesTerritory(
	TerritoryID			int not null,
	Name				nvarchar(50) not null,
	CountryRegionCode	nvarchar(3) not null,
	Groupe				nvarchar(50) not null,
	SalesYTD			money not null,
	SalesLastYear		money not null,
	CostYTD				money not null,
	CostLastYear		money not null,
	rowguid				uniqueidentifier not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY	(TerritoryID)
);

create table Sales.SalesPerson(
	BusinessEntityID	int not null,
	TerritoryID			int,
	SalesQuota			money,
	Bonus				money not null,
	CommissionPct		smallmoney not null,
	SalesYTD			money not null,
	SalesLastYear		money not null,
	rowguid				uniqueidentifier not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (BusinessEntityID),
	CONSTRAINT FK_TerritoryID FOREIGN KEY (TerritoryID) REFERENCES Sales.SalesTerritory(TerritoryID)
);

create table Sales.SalesPersonQuotaHistory(
	BusinessEntityID	int not null,
	QuotaDate			datetime not null,
	SalesQuota			money,
	rowguid				uniqueidentifier not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (BusinessEntityID,QuotaDate),
	CONSTRAINT FK_BusinessEntityID FOREIGN KEY (BusinessEntityID) REFERENCES Sales.SalesPerson(BusinessEntityID)
);

create table Sales.Store(
	BusinessEntityID	int not null,
	Name				nvarchar(50) not null,
	SalesPersonID		int,
	Demographics		XML,
	rowguid				uniqueidentifier not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY(BusinessEntityID),
	CONSTRAINT FK_SalesPersonID FOREIGN KEY (SalesPersonID) REFERENCES Sales.SalesPerson(BusinessEntityID)
);

create table Sales.Customer(
	CustomerID			int not null,
	PersonID			int,
	StoreID				int,
	TerritoryID			int,
	AccountNumber		varchar(10) not null,
	rowguid				uniqueidentifier not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (CustomerID),
	CONSTRAINT FK_StoreID FOREIGN KEY (StoreID) REFERENCES Sales.Store(BusinessEntityID),
	CONSTRAINT FK_TerritoryIDCustomer FOREIGN KEY (TerritoryID) REFERENCES Sales.SalesTerritory(TerritoryID)
);

--Para America
insert into LSERVER1.America.Sales.SalesTerritory
select * 
from AdventureWorks2019.Sales.SalesTerritory
where TerritoryID = 1 or TerritoryID = 2 or TerritoryID = 3 or TerritoryID = 4 or TerritoryID = 5 or TerritoryID = 6 


insert into LSERVER1.America.Sales.SalesPerson
select * 
from AdventureWorks2019.Sales.SalesPerson
where TerritoryID = 1 or TerritoryID = 2 or TerritoryID = 3 or TerritoryID = 4 or TerritoryID = 5 or TerritoryID = 6 


insert into LSERVER1.America.Sales.Store
select S.BusinessEntityID,S."Name",S.SalesPersonID,S.rowguid,S.ModifiedDate from AdventureWorks2019.Sales.Store S
join AdventureWorks2019.Sales.SalesPerson P
on S.SalesPersonID = P.BusinessEntityID
where TerritoryID = 1 or TerritoryID = 2 or TerritoryID = 3 or TerritoryID = 4 or TerritoryID = 5 or TerritoryID = 6 


insert into LSERVER1.America.Sales.Customer
select * from AdventureWorks2019.Sales.Customer
where TerritoryID = 1 or TerritoryID = 2 or TerritoryID = 3 or TerritoryID = 4 or TerritoryID = 5 or TerritoryID = 6 



--Para el Resto del Mundo
INSERT INTO OPENQUERY (MYSQLODBC, 'SELECT * FROM RMundo.SalesTerritory')
select * from AdventureWorks2019.Sales.SalesTerritory
where TerritoryID = 7 or TerritoryID = 8 or TerritoryID = 9 or TerritoryID = 10

INSERT INTO OPENQUERY (MYSQLODBC, 'SELECT * FROM RMundo.SalesPerson')
select * from AdventureWorks2019.Sales.SalesPerson
where TerritoryID = 7 or TerritoryID = 8 or TerritoryID = 9 or TerritoryID = 10

INSERT INTO OPENQUERY (MYSQLODBC, 'SELECT * FROM RMundo.Store')
select S.BusinessEntityID,S."Name",S.SalesPersonID,S.rowguid,S.ModifiedDate from AdventureWorks2019.Sales.Store S
join AdventureWorks2019.Sales.SalesPerson P
on S.SalesPersonID = P.BusinessEntityID
where TerritoryID = 7 or TerritoryID = 8 or TerritoryID = 9 or TerritoryID = 10

INSERT INTO OPENQUERY (MYSQLODBC, 'SELECT * FROM RMundo.Customer')
select * from AdventureWorks2019.Sales.Customer
where TerritoryID = 7 or TerritoryID = 8 or TerritoryID = 9 or TerritoryID = 10


----Tercera instancia
create database PersonInfo
use PersonInfo

create table Person (
	BusinessEntityID	int not null,
	PersonType			nchar(2) not null,
	NameStyle			bit,
	Title				nvarchar(8),
	FirstName			nvarchar(50) not null,
	MiddleName			nvarchar(50),
	LastName			nvarchar(50) not null,
	Suffix				nvarchar(10),
	EmailPromotion		int not null,
	rowguid				uniqueidentifier not null,
	ModifiedDate		datetime not null
	PRIMARY KEY (BusinessEntityID)
);

create table CreditCard (
	CreditCardID		int not null,
	CardType			nvarchar(50) not null,
	CardNumber			nvarchar(25) not null,
	ExpMonth			tinyint not null,
	ExpYear				smallint not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (CreditCardID)
);

create table PersonCreditCard (
	BusinessEntityID	int not null,
	CreditCardID		int not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (BusinessEntityID,CreditCardID),
	CONSTRAINT FK_BusinessEntityID FOREIGN KEY (BusinessEntityID) REFERENCES Person(BusinessEntityID),
	CONSTRAINT FK_CreditCardID FOREIGN KEY (CreditCardID) REFERENCES CreditCard(CreditCardID)
);


insert into PersonInfo.dbo.Person 
select P.BusinessEntityID, P.PersonType, P.NameStyle, P.Title, P.FirstName, P.MiddleName, P.LastName, P.Suffix, P.EmailPromotion, P.rowguid, P.ModifiedDate
from AdventureWorks2019.Person.Person P

insert into PersonInfo.dbo.CreditCard
select * 
from AdventureWorks2019.Sales.CreditCard

insert into PersonInfo.dbo.PersonCreditCard
select * 
from AdventureWorks2019.Sales.PersonCreditCard


