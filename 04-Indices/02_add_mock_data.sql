USE IndicesDB;
GO

INSERT INTO Clientes (CPF, Nome, Telefone)
VALUES ('70015423121', 'Cliente Teste', '11999999999');

DECLARE @i INT = 0;
WHILE @i < 10000
BEGIN
    INSERT INTO Clientes (CPF, Nome, Telefone)
    VALUES (RIGHT('00000000000' + CAST(@i AS VARCHAR), 11), CONCAT('Cliente_', @i), '00000000000');
    SET @i += 1;
END

INSERT INTO Lancamentos (CPF, Valor, Tipo, Data)
VALUES 
('70015423121', 150.00, 'Cr�dito', '2007-07-05'),
('70015423121', 75.00, 'D�bito', '2007-07-15');

SET @i = 0;
WHILE @i < 50000
BEGIN
    INSERT INTO Lancamentos (CPF, Valor, Tipo, Data)
    VALUES (
        RIGHT('00000000000' + CAST(@i % 10000 AS VARCHAR), 11),
        RAND() * 1000,
        CASE WHEN @i % 2 = 0 THEN 'Cr�dito' ELSE 'D�bito' END,
        DATEADD(DAY, -@i, GETDATE())
    );
    SET @i += 1;
END
