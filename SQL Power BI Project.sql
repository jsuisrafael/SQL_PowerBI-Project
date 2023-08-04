-- Projeto de Integração SQL e Power BI

-- KPIs do Projeto

-- ABA GERAL

-- Receita Total
-- Qtde Vendida
-- Total de Categorias de Produtos
-- Qtde de Clientes
-- Receita Total e Lucro Total por Mês
-- Margem de Lucro
-- Qtde Vendida por Mês
-- Lucro por País

-- ABA CLIENTES

-- Vendas por País
-- Clientes por País
-- Vendas por Gênero
-- Vendas por Categoria


-- TABELAS NECESSÁRIAS:

SELECT * FROM FactInternetSales
SELECT * FROM DimProductCategory
SELECT * FROM DimCustomer
SELECT * FROM DimGeography

-- COLUNAS NECESSÁRIAS:

-- SalesOrderNumber                         (FactInternetSales)
-- OrderDate								(FactInternetSales)
-- EnglishProductCategoryName				(DimProductCategory)
-- CustomerKey								(DimCustomer)
-- FirstName + ' ' + LastName				(DimCustomer)
-- Gender									(DimCustomer)
-- EnglishCountryRegionName					(DimGeography)
-- OrderQuantity							(FactInternetSales)
-- SalesAmount								(FactInternetSales)
-- TotalProductCost							(FactInternetSales)
-- SalesAmount - TotalProductCost			(FactInternetSales)

GO

CREATE OR ALTER VIEW RESULTADOS_ADW AS
SELECT
	fis.SalesOrderNumber AS 'Nº PEDIDO',
	fis.OrderDate AS 'DATA DO PEDIDO',
	dpc.EnglishProductCategoryName AS 'CATEGORIA PRODUTO',
	dc.CustomerKey AS 'ID CLIENTE',
	dc.FirstName + ' ' + LastName AS 'NOME DO CLIENTE',
	REPLACE(REPLACE(dc.Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'GENERO',
	dg.EnglishCountryRegionName AS 'PAÍS',
	fis.OrderQuantity AS 'QTD VENDIDA',
	ROUND(fis.SalesAmount, 2) AS 'RECEITA VENDA',
	ROUND(fis.TotalProductCost, 2) AS 'CUSTO VENDA',
	ROUND(fis.SalesAmount - fis.TotalProductCost, 2) AS 'LUCRO VENDA'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
	INNER JOIN DimGeography dg ON dc.GeographyKey = dg.GeographyKey

GO

SELECT * FROM RESULTADOS_ADW
