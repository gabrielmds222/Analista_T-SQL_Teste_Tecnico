CREATE DATABASE FilaTarefasDB;
GO

USE FilaTarefasDB;
GO

CREATE TABLE dbo.FilaExecucao (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NomeTarefa VARCHAR(100) NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Pendente',
    DataCriacao DATETIME DEFAULT GETDATE(),
    UltimaAtualizacao DATETIME NULL,
    Tentativas INT DEFAULT 0,
    MensagemErro NVARCHAR(4000) NULL
);
GO
