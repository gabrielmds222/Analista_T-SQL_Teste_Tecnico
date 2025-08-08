USE ResetSenhaDB;
GO

INSERT INTO USUARIOS (Nome, Email, CPF, Senha, Ativo)
VALUES 
('Maria Silva', 'maria@email.com', '12345678900', 'antigaSenha1', 'S'),
('Jo�o Souza', 'joao@email.com', '98765432100', 'antigaSenha2', 'N'),
('Jorge Soares', 'jorge@email.com', '19283746500', 'antigaSenha3', 'S')