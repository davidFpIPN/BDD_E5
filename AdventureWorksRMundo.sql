create database RMundo
use RMundo;
drop database RMundo
create table SalesTerritory(
	TerritoryID			int not null,
	Name				varchar(50) not null,
	CountryRegionCode	varchar(3) not null,
	Groupe				varchar(50) not null,
	SalesYTD			decimal not null,
	SalesLastYear		decimal not null,
	CostYTD				decimal not null,
	CostLastYear		decimal not null,
	rowguid				varchar(50) not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY	(TerritoryID)
);

create table SalesPerson(
	BusinessEntityID	int not null,
	TerritoryID			int,
	SalesQuota			decimal,
	Bonus				decimal not null,
	CommissionPct		decimal not null,
	SalesYTD			decimal not null,
	SalesLastYear		decimal not null,
	rowguid				varchar(50) not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (BusinessEntityID),
	CONSTRAINT FK_TerritoryID FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
);

create table Store(
	BusinessEntityID	int not null,
	Name				varchar(50) not null,
	SalesPersonID		int,
	rowguid				varchar(50) not null,
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
	rowguid				varchar(50) not null,
	ModifiedDate		datetime not null,
	PRIMARY KEY (CustomerID),
	CONSTRAINT FK_StoreID FOREIGN KEY (StoreID) REFERENCES Store(BusinessEntityID),
	CONSTRAINT FK_TerritoryIDCustomer FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
);