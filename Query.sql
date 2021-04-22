USE gr691_msi
GO

--1-�� ������

IF EXISTS (SELECT * FROM Provider
WHERE Provider.Name = '�����')
	SELECT DISTINCT Product.Name AS '�����' FROM Product
	JOIN Provider ON Provider.ID = Product.ProviderID
	WHERE Product.Price BETWEEN '850' AND '5000' AND Provider.Name = '�����'
ELSE
	PRINT N'������� ������ ���.'

--2-�� ������

IF EXISTS (SELECT * FROM Product
WHERE DATEDIFF(month, Product.Delivery_Date, SYSDATETIME()) >= 6)
	SELECT DISTINCT Product.Name AS '�����' FROM Product
	WHERE DATEDIFF(month, Product.Delivery_Date, SYSDATETIME()) >= 6
ELSE
	PRINT N'������� ������ ���.'

--3-�� ������

SELECT DISTINCT Type.Name AS '���', SUM(Product.Amount) AS '����������' FROM Type
JOIN Product ON Product.TypeID = Type.ID
GROUP BY Type.Name

--4-�� ������

SELECT DISTINCT Product.Name AS '��������', Provider.Name AS '���������', Product.Price AS '���������' FROM Product
JOIN Provider ON Provider.ID = Product.ProviderID
WHERE DATEDIFF(day, Product.Expiration_Date, SYSDATETIME()) >= 1

--5-�� ������

IF EXISTS (SELECT * FROM Product
JOIN Provider ON Provider.ID = Product.ProviderID
WHERE Product.Production_Date > '2018-07-10' AND Provider.Juridical_Address LIKE '%�����������%')
	SELECT Product.Name AS '�����' FROM Product
	JOIN Provider ON Provider.ID = Product.ProviderID
	WHERE Product.Production_Date > '2018-07-10' AND Provider.Juridical_Address LIKE '%�����������%'
ELSE
	PRINT N'������� ������ ���.'

--6-�� ������

SELECT DISTINCT Type.Name AS '��� ������', MAX(Product.Price) AS '������������ ���������' FROM Type
JOIN Product ON Product.TypeID = Type.ID
WHERE Product.TypeID = '9'
GROUP BY Type.Name

--7-�� ������

IF EXISTS (SELECT * FROM Product
JOIN Type ON Type.ID = Product.TypeID
WHERE Type.Name LIKE '%����������%'
AND Product.Price < (SELECT AVG(Product.Price) FROM Product))
	SELECT Product.Name AS '�����' FROM Product
	JOIN Type ON Type.ID = Product.TypeID
	WHERE Type.Name LIKE '%����������%'
	AND Product.Price < (SELECT AVG(Product.Price) FROM Product)
ELSE
	PRINT N'������� ������ ���.'

--8-�� ������

IF EXISTS (SELECT * FROM Product
JOIN Type ON Type.ID = Product.TypeID
WHERE DATEDIFF(DAY, Product.Production_Date, Product.Delivery_Date) >= 10)
	SELECT Product.Name AS '�����', Type.Name AS '��� ������' FROM Product
	JOIN Type ON Type.ID = Product.TypeID
	WHERE DATEDIFF(DAY, Product.Production_Date, Product.Delivery_Date) >= 10
ELSE
	PRINT N'������� ������ ���.'

--9-�� ������

IF EXISTS (SELECT * FROM Product
WHERE Product.Delivery_Date > '2018-09-01' AND Product.Name LIKE '_____')
	SELECT Product.Name AS '�����' FROM Product
	WHERE Product.Delivery_Date > '2018-09-01' AND Product.Name LIKE '_____'
ELSE
	PRINT N'������� ������ ���.'

--10-�� ������

SELECT DISTINCT SUBSTRING(Product.Name, 1, 3) AS '�������� ������', Product.Price AS '���������', 
DATENAME(WEEKDAY, Product.Delivery_Date) AS '���� ������ �������� ������' FROM Product