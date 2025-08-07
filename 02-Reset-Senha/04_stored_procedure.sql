CREATE PROCEDURE stpResetSenha
	@JsonData NVARCHAR(MAX)
AS
BEGIN

SET NOCOUNT ON;

	DECLARE @CPF VARCHAR(11);
	DECLARE @NovaSenha NVARCHAR(100);
	DECLARE @SenhaCriptografada VARCHAR(32);
	DECLARE @UsuarioId INT;

	BEGIN TRY
		BEGIN TRANSACTION;

		SELECT
			@CPF = JSON_VALUE(@JsonData, '$.CPF'),
			@NovaSenha = JSON_VALUE(@JsonData, '$.NovaSenha');

		SELECT @UsuarioId = usuarioId
		FROM USUARIOS
		WHERE CPF = @CPF AND Ativo = 'S';

		IF @UsuarioId IS NULL
		BEGIN 
			RAISERROR('Usuário não encontrado ou está Inativo/Bloqueado', 16, 1);
			ROLLBACK TRANSACTION;
			RETURN;
		END

		SET @SenhaCriptografada = CONVERT(VARCHAR(32), HASHBYTES('MD5', @NovaSenha), 2);

		UPDATE USUARIOS
		SET Senha = @SenhaCriptografada
		WHERE usuarioId = @UsuarioId;

		COMMIT TRANSACTION;

		SELECT @UsuarioId AS usuarioId;

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR('Erro ao resetar a senha: %s', 16, 1, @ErrorMessage);
	END CATCH
END;