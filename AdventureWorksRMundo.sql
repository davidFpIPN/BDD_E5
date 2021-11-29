create database sales
use sales;

create table Sales.SalesTerritory(
	TerritoryID			int not null,
	Name				nvarchar(50) not null,
	CountryRegionCode	nvarchar(3) not null,
	Groupe				nvarchar(50) not null,
	SalesYTD			decimal not null,
	SalesLastYear		decimal not null,
	CostYTD				decimal not null,
	CostLastYear		decimal not null,
	rowguid				nvarchar(50) not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY	(TerritoryID)
);

create table Sales.SalesPerson(
	BusinessEntityID	int not null,
	TerritoryID			int,
	SalesQuota			decimal,
	Bonus				decimal not null,
	CommissionPct		decimal not null,
	SalesYTD			decimal not null,
	SalesLastYear		decimal not null,
	rowguid				nvarchar(50) not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (BusinessEntityID),
	CONSTRAINT FK_TerritoryID FOREIGN KEY (TerritoryID) REFERENCES Sales.SalesTerritory(TerritoryID)
);

create table Sales.SalesPersonQuotaHistory(
	BusinessEntityID	int not null,
	QuotaDate			datetime not null,
	SalesQuota			decimal,
	rowguid				nvarchar(50) not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (BusinessEntityID,QuotaDate),
	CONSTRAINT FK_BusinessEntityID FOREIGN KEY (BusinessEntityID) REFERENCES Sales.SalesPerson(BusinessEntityID)
);

create table Sales.Store(
	BusinessEntityID	int not null,
	Name				nvarchar(50) not null,
	SalesPersonID		int,
	Demographics		nvarchar(50),
	rowguid				nvarchar(50) not null,
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
	rowguid				nvarchar(50) not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (CustomerID),
	CONSTRAINT FK_StoreID FOREIGN KEY (StoreID) REFERENCES Sales.Store(BusinessEntityID),
	CONSTRAINT FK_TerritoryIDCustomer FOREIGN KEY (TerritoryID) REFERENCES Sales.SalesTerritory(TerritoryID)
);