USE IndicesDB;
GO

DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;

-- Adicionei estatísticas de desempenho para comparação futura
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT C.CPF, C.Nome, C.Telefone, L.Valor, L.Tipo, L.Data
FROM Clientes C
INNER JOIN Lancamentos L ON C.CPF = L.CPF
WHERE
    C.CPF = '70015423121'
    AND YEAR(L.Data) = 2007
