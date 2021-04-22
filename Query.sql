USE gr691_msi
GO

--1-ый запрос

IF EXISTS (SELECT * FROM Provider
WHERE Provider.Name = 'Алиса')
	SELECT DISTINCT Product.Name AS 'Товар' FROM Product
	JOIN Provider ON Provider.ID = Product.ProviderID
	WHERE Product.Price BETWEEN '850' AND '5000' AND Provider.Name = 'Алиса'
ELSE
	PRINT N'Искомых данных нет.'

--2-ой запрос

IF EXISTS (SELECT * FROM Product
WHERE DATEDIFF(month, Product.Delivery_Date, SYSDATETIME()) >= 6)
	SELECT DISTINCT Product.Name AS 'Товар' FROM Product
	WHERE DATEDIFF(month, Product.Delivery_Date, SYSDATETIME()) >= 6
ELSE
	PRINT N'Искомых данных нет.'

--3-ий запрос

SELECT DISTINCT Type.Name AS 'Тип', SUM(Product.Amount) AS 'Количество' FROM Type
JOIN Product ON Product.TypeID = Type.ID
GROUP BY Type.Name

--4-ый запрос

SELECT DISTINCT Product.Name AS 'Название', Provider.Name AS 'Поставщик', Product.Price AS 'Стоимость' FROM Product
JOIN Provider ON Provider.ID = Product.ProviderID
WHERE DATEDIFF(day, Product.Expiration_Date, SYSDATETIME()) >= 1

--5-ый запрос

IF EXISTS (SELECT * FROM Product
JOIN Provider ON Provider.ID = Product.ProviderID
WHERE Product.Production_Date > '2018-07-10' AND Provider.Juridical_Address LIKE '%Новосибирск%')
	SELECT Product.Name AS 'Товар' FROM Product
	JOIN Provider ON Provider.ID = Product.ProviderID
	WHERE Product.Production_Date > '2018-07-10' AND Provider.Juridical_Address LIKE '%Новосибирск%'
ELSE
	PRINT N'Искомых данных нет.'

--6-ой запрос

SELECT DISTINCT Type.Name AS 'Тип товара', MAX(Product.Price) AS 'Максимальная стоимость' FROM Type
JOIN Product ON Product.TypeID = Type.ID
WHERE Product.TypeID = '9'
GROUP BY Type.Name

--7-ой запрос

IF EXISTS (SELECT * FROM Product
JOIN Type ON Type.ID = Product.TypeID
WHERE Type.Name LIKE '%видеокарта%'
AND Product.Price < (SELECT AVG(Product.Price) FROM Product))
	SELECT Product.Name AS 'Товар' FROM Product
	JOIN Type ON Type.ID = Product.TypeID
	WHERE Type.Name LIKE '%видеокарта%'
	AND Product.Price < (SELECT AVG(Product.Price) FROM Product)
ELSE
	PRINT N'Искомых данных нет.'

--8-ой запрос

IF EXISTS (SELECT * FROM Product
JOIN Type ON Type.ID = Product.TypeID
WHERE DATEDIFF(DAY, Product.Production_Date, Product.Delivery_Date) >= 10)
	SELECT Product.Name AS 'Товар', Type.Name AS 'Тип товара' FROM Product
	JOIN Type ON Type.ID = Product.TypeID
	WHERE DATEDIFF(DAY, Product.Production_Date, Product.Delivery_Date) >= 10
ELSE
	PRINT N'Искомых данных нет.'

--9-ый запрос

IF EXISTS (SELECT * FROM Product
WHERE Product.Delivery_Date > '2018-09-01' AND Product.Name LIKE '_____')
	SELECT Product.Name AS 'Товар' FROM Product
	WHERE Product.Delivery_Date > '2018-09-01' AND Product.Name LIKE '_____'
ELSE
	PRINT N'Искомых данных нет.'

--10-ый запрос

SELECT DISTINCT SUBSTRING(Product.Name, 1, 3) AS 'Название товара', Product.Price AS 'Стоимость', 
DATENAME(WEEKDAY, Product.Delivery_Date) AS 'День недели поставки товара' FROM Product