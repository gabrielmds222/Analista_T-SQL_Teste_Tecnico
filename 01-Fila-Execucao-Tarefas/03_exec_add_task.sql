USE FilaTarefasDB;
GO

EXEC AdicionarTarefa @NomeTarefa = 'Gerar relat�rio de vendas';
EXEC AdicionarTarefa @NomeTarefa = 'Atualizar estoque';
EXEC AdicionarTarefa @NomeTarefa = 'Enviar notifica��o de cobran�a';
EXEC AdicionarTarefa @NomeTarefa = 'Realizar backup di�rio';
EXEC AdicionarTarefa @NomeTarefa = 'Sincronizar dados com API externa';
GO

SELECT * FROM dbo.FilaExecucao;
GO
