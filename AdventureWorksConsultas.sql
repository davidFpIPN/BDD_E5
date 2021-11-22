---Tiendas que han vendido mas este año
select distinct top 70 ST.Name as 'Tienda', SP.SalesYTD as 'Ventas' from AdventureWorks2019.Sales.SalesPerson SP
join AdventureWorks2019.Sales.Store ST
on ST.SalesPersonID = SP.BusinessEntityID
order by SP.SalesYTD Desc

---Tiendas que han vendido menos este año
select distinct ST.Name as 'Tienda', SP.SalesYTD as 'Ventas' from AdventureWorks2019.Sales.SalesPerson SP
join AdventureWorks2019.Sales.Store ST
on ST.SalesPersonID = SP.BusinessEntityID
where ST.BusinessEntityID >= 1977 --Ultimos 10 
order by SP.SalesYTD Desc

---Ventas por territorio a la fecha
select T.Name, T.SalesYTD from AdventureWorks2019.Sales.SalesTerritory T 
order by T.SalesYTD desc

---Desempeño del las ventas de un encargado regional con respecto al año anterior
select S.BusinessEntityID, (S.SalesYTD - S.SalesLastYear) as 'Crecimineto en ventas' from AdventureWorks2019.Sales.SalesPerson S
order by 2 desc

---Tiendas con mejor desempeño con respecto al año pasado
select distinct ST.Name as 'Tienda', (SP.SalesYTD - SP.SalesLastYear) as 'Crecimiento en Ventas' from AdventureWorks2019.Sales.SalesPerson SP
join AdventureWorks2019.Sales.Store ST
on ST.SalesPersonID = SP.BusinessEntityID
order by 2 desc



select * from AdventureWorks2019.Sales.SalesTerritory

select * from AdventureWorks2019.Sales.SalesPersonQuotaHistory

select * from AdventureWorks2019.Sales.SalesTerritoryHistory

select * from AdventureWorks2019.Sales.SalesPerson

select * from AdventureWorks2019.Sales.Customer


---Encargados que han administrado un territorio en el pasado hasta ahora
select H.BusinessEntityID as 'Encargado ID', H.TerritoryID, StartDate, EndDate from AdventureWorks2019.Sales.SalesTerritoryHistory H
where H.BusinessEntityID = 275

---Cantidad de consumidores por territorio
select distinct TerritoryID, count(*) as 'Consumidores' from AdventureWorks2019.Sales.Customer
group by TerritoryID



