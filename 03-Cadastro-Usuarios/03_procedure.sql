USE CadastroUsuariosDB;
GO

CREATE PROCEDURE stpCadastrarUsuario
	@JsonData NVARCHAR(MAX)
AS 
BEGIN
	SET NOCOUNT ON;

    DECLARE @Nome NVARCHAR(100);
    DECLARE @Email NVARCHAR(100);
    DECLARE @CPF VARCHAR(11);
    DECLARE @Senha NVARCHAR(100);
    DECLARE @SenhaCriptografada CHAR(32);

    BEGIN TRY
        BEGIN TRANSACTION;

        SELECT
           @Nome = JSON_VALUE(@JsonData, '$.Nome'),
           @Email = JSON_VALUE(@JsonData, '$.Email'),
           @CPF = JSON_VALUE(@JsonData, '$.CPF'),
           @Senha = JSON_VALUE(@JsonData, '$.Senha');

        IF EXISTS (SELECT 1 FROM USUARIOS WHERE CPF = @CPF)
        BEGIN
            RAISERROR('Usuário já cadastrado no sistema', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SET @SenhaCriptografada = CONVERT(CHAR(32), HASHBYTES('MD5', @Senha), 2);

        INSERT INTO USUARIOS (Nome, Email, CPF, Senha, Ativo)
        VALUES (@Nome, @Email, @CPF, @SenhaCriptografada, 'S');

        COMMIT TRANSACTION;

        PRINT 'Usuário cadastrado com sucesso!';

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

            DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
            RAISERROR('Erro ao cadastrar usuário: %s', 16, 1, @ErrorMessage);
        END CATCH
    END