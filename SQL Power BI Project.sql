-- Projeto de Integra��o SQL e Power BI

-- KPIs do Projeto

-- ABA GERAL

-- Receita Total
-- Qtde Vendida
-- Total de Categorias de Produtos
-- Qtde de Clientes
-- Receita Total e Lucro Total por M�s
-- Margem de Lucro
-- Qtde Vendida por M�s
-- Lucro por Pa�s

-- ABA CLIENTES

-- Vendas por Pa�s
-- Clientes por Pa�s
-- Vendas por G�nero
-- Vendas por Categoria


-- TABELAS NECESS�RIAS:

SELECT * FROM FactInternetSales
SELECT * FROM DimProductCategory
SELECT * FROM DimCustomer
SELECT * FROM DimGeography

-- COLUNAS NECESS�RIAS:

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
	fis.SalesOrderNumber AS 'N� PEDIDO',
	fis.OrderDate AS 'DATA DO PEDIDO',
	dpc.EnglishProductCategoryName AS 'CATEGORIA PRODUTO',
	dc.CustomerKey AS 'ID CLIENTE',
	dc.FirstName + ' ' + LastName AS 'NOME DO CLIENTE',
	REPLACE(REPLACE(dc.Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'GENERO',
	dg.EnglishCountryRegionName AS 'PA�S',
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
