-- Nesse arquivo irei responder por meio de consultas no banco de dados as perguntas do nosso problema de neg�cios. S�o elas:
-- * Listar todos os produtos vendidos em uma data espec�fica.
-- * Calcular o total de vendas de um cliente espec�fico.
-- * Encontrar o produto mais vendido.
-- * Listar todas as notas fiscais emitidas em um determinado per�odo.

-- Pergunta 1. Listar todos os produtos vendidos em uma data espec�fica.
SELECT
    P.PRODUTO_ID,
    P.NOME,
    P.CATEGORIA,
    DP.QUANTIDADE,
    DP.PRECO_UNITARIO,
    PED.DATA_VENDA	
FROM DETALHES_PEDIDO DP
JOIN 
	PRODUTOS P ON DP.PRODUTO_ID = P.PRODUTO_ID
JOIN 
	PEDIDOS PED ON DP.PEDIDO_ID = PED.PEDIDO_ID
WHERE 
	PED.DATA_VENDA = '2025-08-07'



-- Pergunta 2. Calcular o total de vendas de um cliente espec�fico.

SELECT
    C.CLIENTE_ID,
    C.NOME,
    SUM(NF.TOTAL) AS TOTAL_VENDAS
FROM CLIENTES C
JOIN
    PEDIDOS PED ON C.CLIENTE_ID = PED.CLIENTE_ID
JOIN NOTAS_FISCAIS NF ON PED.PEDIDO_ID = NF.PEDIDO_ID
WHERE 
    C.CLIENTE_ID = 1
GROUP BY 
    C.CLIENTE_ID, C.NOME



--Pergunta 3. Encontrar o produto mais vendido.

SELECT TOP 1
    P.PRODUTO_ID,
    P.NOME,
    SUM(DP.QUANTIDADE) AS TOTAL_VENDIDO
FROM DETALHES_PEDIDO DP
JOIN PRODUTOS P ON DP.PRODUTO_ID = P.PRODUTO_ID
GROUP BY P.PRODUTO_ID, P.NOME
ORDER BY TOTAL_VENDIDO DESC;



--Pergunta 4. Listar todas as notas fiscais emitidas em um determinado per�odo.

SELECT
    NF.NUMERO_NOTA,
    NF.DATA_EMISSAO,
    NF.TOTAL,
    PED.PEDIDO_ID,
    C.NOME AS CLIENTE
FROM NOTAS_FISCAIS NF
JOIN PEDIDOS PED ON NF.PEDIDO_ID = PED.PEDIDO_ID
JOIN CLIENTES C ON PED.CLIENTE_ID = C.CLIENTE_ID
WHERE NF.DATA_EMISSAO BETWEEN '2025-07-01' AND '2025-08-31'
ORDER BY NF.DATA_EMISSAO;