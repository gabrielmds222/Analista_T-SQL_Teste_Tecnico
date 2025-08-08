USE ResetSenhaDB;
GO

DECLARE @Json NVARCHAR(MAX) = 

'{
  "CPF": "98765432100",
  "NovaSenha": "novaSenha123"
}';

EXEC stpResetSenha @Json
