CREATE PROCEDURE ExecutarTarefas
    @Quantidade INT = 5
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TaskID INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @Tarefas TABLE (ID INT);

        INSERT INTO @Tarefas (ID)
        SELECT TOP(@Quantidade) ID
        FROM FilaExecucao WITH (ROWLOCK, READPAST, UPDLOCK)
        WHERE Status = 'Pendente'
        ORDER BY ID;

        UPDATE FilaExecucao
        SET Status = 'Em andamento', UltimaAtualizacao = GETDATE()
        WHERE ID IN (SELECT ID FROM @Tarefas);

        COMMIT TRANSACTION;

        DECLARE cursorTarefas CURSOR FOR SELECT ID FROM @Tarefas;
        OPEN cursorTarefas;

        FETCH NEXT FROM cursorTarefas INTO @TaskID;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
 
                PRINT CONCAT('Executando tarefa ', @TaskID);
                WAITFOR DELAY '00:00:02'; 

                UPDATE FilaExecucao
                SET Status = 'Concluída', UltimaAtualizacao = GETDATE()
                WHERE ID = @TaskID;
            END TRY
            BEGIN CATCH
                UPDATE FilaExecucao
                SET Status = 'Erro',
                    Tentativas = Tentativas + 1,
                    MensagemErro = ERROR_MESSAGE(),
                    UltimaAtualizacao = GETDATE()
                WHERE ID = @TaskID;
            END CATCH;

            FETCH NEXT FROM cursorTarefas INTO @TaskID;
        END

        CLOSE cursorTarefas;
        DEALLOCATE cursorTarefas;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;