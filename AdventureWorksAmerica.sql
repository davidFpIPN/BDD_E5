create database America
use America;

create table SalesTerritory(
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

create table SalesPerson(
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
	CONSTRAINT FK_TerritoryID FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
);

create table SalesPersonQuotaHistory(
	BusinessEntityID	int not null,
	QuotaDate			datetime not null,
	SalesQuota			money,
	rowguid				uniqueidentifier not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (BusinessEntityID,QuotaDate),
	CONSTRAINT FK_BusinessEntityID FOREIGN KEY (BusinessEntityID) REFERENCES SalesPerson(BusinessEntityID)
);

create table Store(
	BusinessEntityID	int not null,
	Name				nvarchar(50) not null,
	SalesPersonID		int,
	rowguid				uniqueidentifier not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY(BusinessEntityID),
	CONSTRAINT FK_SalesPersonID FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(BusinessEntityID)
);

create table Customer(
	CustomerID			int not null,
	PersonID			int,
	StoreID				int,
	TerritoryID			int,
	AccountNumber		varchar(10) not null,
	rowguid				uniqueidentifier not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (CustomerID),
	CONSTRAINT FK_StoreID FOREIGN KEY (StoreID) REFERENCES Store(BusinessEntityID),
	CONSTRAINT FK_TerritoryIDCustomer FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
);


drop database America
--Para America
insert into America.dbo.SalesTerritory
select * 
from AdventureWorks2019.Sales.SalesTerritory
where TerritoryID = 1 or TerritoryID = 2 or TerritoryID = 3 or TerritoryID = 4 or TerritoryID = 5 or TerritoryID = 6 


insert into America.dbo.SalesPerson
select * 
from AdventureWorks2019.Sales.SalesPerson
where TerritoryID = 1 or TerritoryID = 2 or TerritoryID = 3 or TerritoryID = 4 or TerritoryID = 5 or TerritoryID = 6 


insert into America.dbo.Store
select S.BusinessEntityID,S."Name",S.SalesPersonID,S.rowguid,S.ModifiedDate from AdventureWorks2019.Sales.Store S
join AdventureWorks2019.Sales.SalesPerson P
on S.SalesPersonID = P.BusinessEntityID
where TerritoryID = 1 or TerritoryID = 2 or TerritoryID = 3 or TerritoryID = 4 or TerritoryID = 5 or TerritoryID = 6 


insert into America.dbo.Customer
select * from AdventureWorks2019.Sales.Customer
where TerritoryID = 1 or TerritoryID = 2 or TerritoryID = 3 or TerritoryID = 4 or TerritoryID = 5 or TerritoryID = 6 



--Para el Resto del Mundo
INSERT INTO OPENQUERY (LSERVER1, 'SELECT * FROM RMundo.dbo.SalesTerritory')
select * from AdventureWorks2019.Sales.SalesTerritory
where TerritoryID = 7 or TerritoryID = 8 or TerritoryID = 9 or TerritoryID = 10

INSERT INTO OPENQUERY (LSERVER1, 'SELECT * FROM RMundo.dbo.SalesPerson')
select * from AdventureWorks2019.Sales.SalesPerson
where TerritoryID = 7 or TerritoryID = 8 or TerritoryID = 9 or TerritoryID = 10

INSERT INTO OPENQUERY (LSERVER1, 'SELECT * FROM RMundo.dbo.Store')
select S.BusinessEntityID,S."Name",S.SalesPersonID,S.rowguid,S.ModifiedDate from AdventureWorks2019.Sales.Store S
join AdventureWorks2019.Sales.SalesPerson P
on S.SalesPersonID = P.BusinessEntityID
where TerritoryID = 7 or TerritoryID = 8 or TerritoryID = 9 or TerritoryID = 10

INSERT INTO OPENQUERY (LSERVER1, 'SELECT * FROM RMundo.dbo.Customer')
select * from AdventureWorks2019.Sales.Customer
where TerritoryID = 7 or TerritoryID = 8 or TerritoryID = 9 or TerritoryID = 10


---Para PersonInfo
INSERT INTO OPENQUERY (LSERVER1, 'SELECT * FROM PersonInfo.dbo.Person')
select P.BusinessEntityID, P.PersonType, P.NameStyle, P.Title, P.FirstName, P.MiddleName, P.LastName, P.Suffix, P.EmailPromotion, P.rowguid, P.ModifiedDate
from AdventureWorks2019.Person.Person P

INSERT INTO OPENQUERY (LSERVER1, 'SELECT * FROM PersonInfo.dbo.CreditCard')
select * 
from AdventureWorks2019.Sales.CreditCard

INSERT INTO OPENQUERY (LSERVER1, 'SELECT * FROM PersonInfo.dbo.PersonCreditCard')
select * 
from AdventureWorks2019.Sales.PersonCreditCard
