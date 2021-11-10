const rest = new (require('rest-mssql-nodejs'))({
    user: 'DavidPruebas',
    password: 'DavidPruebas',
    server: 'DESKTOP-A8FTTBG',
    database: 'AdventureWorks2019' 
});

const getMoreSold = async() =>{
    const qry = "select distinct top 70 ST.Name as 'Tienda', SP.SalesYTD as 'Ventas' from AdventureWorks2019.Sales.SalesPerson SP join AdventureWorks2019.Sales.Store ST on ST.SalesPersonID = SP.BusinessEntityID order by SP.SalesYTD Desc";
    const execQuery = await rest.executeQuery(qry);
    return execQuery.data[0];
    
}

const getFewerSold = async() => {
    const qry = "select distinct ST.Name as 'Tienda', SP.SalesYTD as 'Ventas' from AdventureWorks2019.Sales.SalesPerson SP join AdventureWorks2019.Sales.Store ST on ST.SalesPersonID = SP.BusinessEntityID where ST.BusinessEntityID >= 1977  order by SP.SalesYTD Desc"
    const execQuery = await rest.executeQuery(qry);
    return execQuery.data[0];
}

const getSalesByTerritory = async() => {
    const qry = "select T.Name, T.SalesYTD from AdventureWorks2019.Sales.SalesTerritory T order by T.SalesYTD desc"
    const execQuery = await rest.executeQuery(qry);
    return execQuery.data[0];
}

const getIncreaseSoldManager = async() => {
    const qry = "select S.BusinessEntityID, (S.SalesYTD - S.SalesLastYear) as 'Crecimiento' from AdventureWorks2019.Sales.SalesPerson S order by 2 desc"
    const execQuery = await rest.executeQuery(qry);
    return execQuery.data[0];
}

const getIncreaseSoldStore = async() => {
    const qry = "select distinct ST.Name as 'Tienda', (SP.SalesYTD - SP.SalesLastYear) as 'Crecimiento' from AdventureWorks2019.Sales.SalesPerson SP join AdventureWorks2019.Sales.Store ST on ST.SalesPersonID = SP.BusinessEntityID order by 2 desc"
    const execQuery = await rest.executeQuery(qry);
    return execQuery.data[0];
}

module.exports = {
    "getMoreSold": getMoreSold,
    "getFewerSold": getFewerSold,
    "getSalesByTerritory": getSalesByTerritory,
    "getIncreaseSoldManager": getIncreaseSoldManager,
    "getIncreaseSoldStore": getIncreaseSoldStore,
}