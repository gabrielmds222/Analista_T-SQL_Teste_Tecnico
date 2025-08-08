USE IndicesDB;
GO

CREATE NONCLUSTERED INDEX idx_Lancamentos_CPF ON Lancamentos (CPF);

CREATE NONCLUSTERED INDEX idx_Lancamentos_CPF_Data ON Lancamentos (CPF, Data);

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT C.CPF, C.Nome, C.Telefone, L.Valor, L.Tipo, L.Data
FROM Clientes C
INNER JOIN Lancamentos L ON C.CPF = L.CPF
WHERE 
    C.CPF = '70015423121'
    AND L.Data >= '2007-01-01'
    AND L.Data < '2008-01-01';
