CREATE TABLE LANCAMENTO_CONTABIL(
	CONTA INT,
	VALOR INT,
	DEBITO_CRED CHAR(1)
)
GO

BULK INSERT LANCAMENTO_CONTABIL
FROM 'C:\Users\danrl\Desktop\SQL Server\lancamento_contabil\CONTAS.txt'
WITH
(
	FIRSTROW = 2,
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n'
)
GO

SELECT * FROM LANCAMENTO_CONTABIL
GO

-- trazendo numero da conta e saldo (devedor e credor) --
SELECT CONTA, VALOR,
CHARINDEX('D',DEBITO_CRED) AS 'DEBITO',
CHARINDEX('C',DEBITO_CRED) AS 'CREDITO',
CHARINDEX('C',DEBITO_CRED) * 2 - 1 AS 'MULTIPLICADOR'
FROM LANCAMENTO_CONTABIL
GO

SELECT CONTA,
SUM(VALOR * (CHARINDEX('C',DEBITO_CRED) * 2 - 1)) AS 'SALDO'
FROM LANCAMENTO_CONTABIL
GROUP BY CONTA
GO
