USE FilaTarefasDB;
GO

EXEC AdicionarTarefa @NomeTarefa = 'Gerar relatório de vendas';
EXEC AdicionarTarefa @NomeTarefa = 'Atualizar estoque';
EXEC AdicionarTarefa @NomeTarefa = 'Enviar notificação de cobrança';
EXEC AdicionarTarefa @NomeTarefa = 'Realizar backup diário';
EXEC AdicionarTarefa @NomeTarefa = 'Sincronizar dados com API externa';
GO

SELECT * FROM dbo.FilaExecucao;
GO
