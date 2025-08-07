USE FilaTarefasDB;
GO

DROP PROCEDURE IF EXISTS dbo.AdicionarTarefa;
GO

CREATE PROCEDURE dbo.AdicionarTarefa
    @NomeTarefa VARCHAR(100)
AS
BEGIN
    INSERT INTO dbo.FilaExecucao (NomeTarefa)
    VALUES (@NomeTarefa);
END;
GO
