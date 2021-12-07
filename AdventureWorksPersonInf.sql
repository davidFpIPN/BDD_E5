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

