create database RMundo
use RMundo;

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

use rmundo
select * from salesterritory
select * from salesperson
select * from store
select * from customer


