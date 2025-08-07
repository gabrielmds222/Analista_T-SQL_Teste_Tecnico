DECLARE @Json NVARCHAR(MAX) = '
{
  "Nome": "Maria dos Anjos",
  "Email": "maria@email.com",
  "CPF": "12345678900",
  "Senha": "mariaSenhaSegura"
}';

EXEC stpCadastrarUsuario @Json;
