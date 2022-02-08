# SQL-Serve
[![author](https://img.shields.io/badge/author-patrick-red.svg)](https://www.linkedin.com/in/patrick-cavalcante-moraes-a95635179/) 
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/PatrickCavalcant)

Cláusulas desenvolvidas para utilização como exemplos no dia a dia.

Funções APSDU
---
Pack = exclui fisicamente os registros marcados como deletado;</br>
zap = exclui fisicamente todos os registros da tabela, indiferente de estarem ou não marcados como deletados;</br>
recall = "reativa" os registros marcados como deletados;</br>
replace = substitui o conteudo atual de um campo , por um novo conteudo informado;</br>
set deleted = ativa/desativa a visulização dos registros marcados como deletados;</br>
set softseek = ativa/desativa a pesquisa relativa em um banco de dados indexado; </br>
Contar = conta quantos registros tem na tabela.</br>

sp_helpindex 'VO6010'  

Permissões dos privilégios de usuário - Configurador
```
SELECT * FROM SYS_RULES_FEATURES WHERE RL__ID = 000012 AND   RL__DESMDEF = 'Alterar'


UPDATE SYS_RULES_FEATURES 
SET RL__ACESSO = '1' WHERE RL__ID = 0000013 AND RL__ROTINA IN('VEIXA004','VEIXA005','VEIXA006','VEIXA007','VEIXA008','VEIXA012','VEIXA013','VEIXA014','VEIXA015','VEIXA016','VEIXA017','VEIXA030','VEIXA040') AND RL__DESMDEF IN('Incluir','Alterar')

RL__ACESSO = '1' - PERMITIDO
RL__ACESSO = '3' - NÃO PERMITIDO
```
Retirar os caracteres (.) e (-) do cadastros da SA1010 e SA2010
```
UPDATE SA1010   
SET A1_TEL = REPLACE(A1_TEL, '-','')  WHERE (A1_TEL LIKE '%-%') AND D_E_L_E_T_ = ''
```
Retirar expressões da tabela de cliente e fornecedor
```
UPDATE SA1010   
SET A1_TEL = REPLACE(A1_TEL, '.','')  WHERE (A1_TEL LIKE '%.%') AND D_E_L_E_T_ = ''
```
Tabelas de Usuários
```
Usuários  SYS_USR 
Filiais Usuários  SYS_USR_FILIAL
Acessos Usuários  SYS_USR_ACCESS
Grupos dos Usuários  SYS_USR_GROUPS 
Menu dos Usuários  SYS_USR_MODULE
Grupos  SYS_GRP_GROUP
Privilégios  SYS_RULES
Active Directory  SYS_USR_SSIGNON
```
Campo da atualização da lista de preço
```
SELECT B1_DTREFP1, * FROM SB1010
```
Tabelas Protheus
```
VS1010 - Orçamentos
VO1010 - O.S
VO2010 - O.S Requisição Cabeçalho
VO3010 - O.S  Requisição Peça
VO4010 - O.S Requisição Serviço
SA1010 - Clientes
SA2010 - Fornecedores
SB1010 - Produtos
SB2010 - Saldo atual
SB9010 - Saldo Inicial
SBZ010 - Indicadores de Produtos
SE1010 - Contas a receber
SE2010 - Contas a Pagar
VV1010 - Chassis
SLF010 - Usuário Caixa
VOE010 - Escala Automática Produtivos
XXE010 -  Tabela de Log, importaçao de registros
SX5010 - Tabela genérica
	Tabela 1 -  Controle de numeração da nota fiscal
SD9010 - Controle de numeração da nota fiscal
SF2010 - Cabeçalho das NF de Saída - https://terminaldeinformacao.com/wp-content/tabelas/sf2.php
SD2010 - Campo da NF de Saída
SF1010 - Nota de Entrada/Devolução
CTH010 - Classes de Valores
SX7010 -  Parâmetros
CT1010 - Plano de Contas
SX3010 - Campo 
VMB010 - Garantia JD Cabeçalho
VMC010 - Garantia JD Itens
SED010 - Naturezas Financeira
SF4010 - TES
VE9010 - Lista de Substituição
SX3010 - Campos das tabelas
VOO010 - Relacionamento de OS/NF
SYS_COMPANY_CFG e SYS_COMPANY - Tabela de Filiais
```
Descriptografar Usuário
```
--data de alteração do usuário
SELECT TOP 10
CONVERT(VARCHAR,
DATEADD(DAY,
((ASCII(SUBSTRING(CTT_USERGI,12,1)) - 50) * 100 + (ASCII(SUBSTRING(CTT_USERGI,16,1)) - 50)),
'19960101'),
112)
FROM CTT010
ORDER BY R_E_C_N_O_ DESC
```

```
--identificação do usuário
SELECT TOP 10
SUBSTRING(CTT_USERGI, 3, 1)+SUBSTRING(CTT_USERGI, 7, 1)+
SUBSTRING(CTT_USERGI, 11,1)+SUBSTRING(CTT_USERGI, 15,1)+
SUBSTRING(CTT_USERGI, 2, 1)+SUBSTRING(CTT_USERGI, 6, 1)+
SUBSTRING(CTT_USERGI, 10,1)+SUBSTRING(CTT_USERGI, 14,1)+
SUBSTRING(CTT_USERGI, 1, 1)+SUBSTRING(CTT_USERGI, 5, 1)+
SUBSTRING(CTT_USERGI, 9, 1)+SUBSTRING(CTT_USERGI, 13,1)+
SUBSTRING(CTT_USERGI, 17,1)+SUBSTRING(CTT_USERGI, 4, 1)+
SUBSTRING(CTT_USERGI, 8, 1) Usuario_CRIAÇÃO
FROM CTT010
ORDER BY R_E_C_N_O_ DESC
```
Log de importação de registros
```
-- LOG Contas a Receber
SELECT * FROM XXE010 WHERE XXE_ADAPT = 'FINA040' AND XXE_DATE = '20210408' AND XXE_ID >= 0000068947 AND XXE_ID <= 0000069341

-- LOG Contas a Receber
SELECT * FROM XXE010 WHERE XXE_ADAPT = 'FINA050' AND XXE_DATE = '20210412'

SELECT * FROM XXE010 WHERE XXE_ADAPT = 'MATA020' AND XXE_DATE = '20210412'
```
Copiar tabelas entre Databases diferentes:
```
--copiar tabelas entre Databases diferentes:
INSERT INTO TMPRD.dbo.CVN010 SELECT * FROM TMHML.dbo.CVN010
```
Fazer backup das tabelas
```
select * into VQ3_BACKUP from VQ3010 
select * into SBZ_BACKUP from SBZ010
```
Ver a quantidade de registros do PMM
```
select count(*) from MIL_DPM_CACHE_INVENTARIO where FLAGP = ' '

select count(*), FLAGP from MIL_DPM_CACHE_INVENTARIO where FLAGP = ' ' 
Group By FLAGP
```
Like - Localizar expressão
```
SELECT * FROM SX5010 WHERE X5_DESCRI LIKE '%PECAS%'
```
Update - Deletar registro
```
UPDATE VV1010 SET R_E_C_D_E_L_ = R_E_C_N_O_, D_E_L_E_T_ = '*'
```
INSERT
```
INSERT INTO VOA010 (VOA_FILIAL, VOA_GRUFER, VOA_DESGRU, R_E_C_N_O_) 
VALUES ('010117','B4|4', 'B4|4', 59)
```
Títulos em abertos com o vencimento menor que a data atual, ordenado pelo vencimento 
```
SELECT E1_STATUS,* FROM SE1010 WHERE E1_STATUS = 'A' AND E1_VENCREA < CONVERT (DATE, SYSDATETIME())   
ORDER BY E1_VENCREA;
```
Liberar Orçamento
```
VS1_LIB = ''
VS1_STATUS = 'F'
```
Condição BETWEEN
```
WHERE D2_EMISSAO BETWEEN '' AND 'zzz'
```
Devolução de notas fiscais
```
SELECT FT_OBSERV, FT_FILIAL, FT_NFISCAL FROM SFT010 WHERE FT_OBSERV LIKE '%DEVOLUCAO%' AND FT_NFISCAL IN ('000021778','000021778','030204683','000099721','000001623','000059639','000059671','000098533','000098536','000098537','000038587','000038675','000038677','000038678','000038680','000037293','000070208','000070204','000098833','000070278','000070281','000070282','000021783','000019092','000038826','000036345','000036344','000099725','000070294','018578341','000021834','000021835','000021835','000021836','000021837','000019143','000037441','000037441','000036372','000000626','000021870','000000001','000000003','000000003','000000004','000000005','000037477','000037478','000037473','000037473','000098610','000098616','000098617','000098618','000098619','000000006','000038955','000038959','000038956','000036429','000099718','000020560','000020559')
```
Substring -  Trazer somente 20 caracteres no campo A1_NOME
```
SELECT A1_NREDUZ, SUBSTRING(A1_NOME, 1, 20) AS A1_NOME FROM SA1010 
WHERE R_E_C_N_O_ = 20




UPDATE SA1010
SET A1_NREDUZ = SUBSTRING(A1_NOME, 1, 20) 
WHERE R_E_C_N_O_ = 20
```
Campo MEMO
```
SELECT
ISNULL(CAST(CAST(VOO_OBSENS AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS OBS, 
VOO_NUMNFI,
* FROM VOO010 WHERE VOO_OBSENS <> 'NULL'
AND VOO_FILIAL = '010113'
```
Select entre duas tabela
```
BEGIN TRAN

UPDATE SD2
SET D2_LOJA = F2_LOJA
--SELECT DISTINCT F2_DOC, F2_CLIENTE, F2_LOJA, D2_DOC, D2_CLIENTE, D2_LOJA, F2_EMISSAO
FROM SF2010 AS SF2 
INNER JOIN SD2010 AS SD2 ON F2_DOC = D2_DOC AND F2_CLIENT = D2_CLIENTE AND F2_FILIAL = D2_FILIAL
WHERE F2_LOJA <> D2_LOJA AND SD2.D_E_L_E_T_ = '' AND SF2.D_E_L_E_T_ = ''
--ORDER BY F2_DOC

COMMIT
```

Subselect
```
SELECT DISTINCT 
(SELECT SUM(C7_TOTAL) FROM SC7010 AS SC7  
INNER JOIN SCR010 AS SCR ON C7_NUM = CR_NUM AND C7_FILIAL = CR_FILIAL  
WHERE SC7.C7_NUM = '001869'  AND SCR.D_E_L_E_T_ <> '*' AND SC7.D_E_L_E_T_ <> '*' AND SCR.CR_STATUS = '02') AS VTOTALPEDIDO, 
CONCAT(CR_FILIAL,' - ',M0_FILIAL) AS FILIAL, 
CR_NUM AS PEDIDO,  
CR_TIPO AS TIPO,  
C7_PRODUTO AS PRODUTO,  
C7_DESCRI AS DESCRICAO, 
C7_FORNECE AS FORNECEDOR, 
C7_LOJA AS LOJA,  
A2_NOME AS NOMEFORNEC, 
C7_FILENT AS ENTREGA,  
C7_QUANT AS QUANTIDADE,  
C7_PRECO AS PRECO, 
C7_TOTAL AS TOTAL,  
C7_CC AS CCCOD, 
CTT_DESC01 AS CCDESC 
FROM SCR010 AS SCR  
INNER JOIN SC7010 AS SC7 ON C7_NUM = CR_NUM AND C7_FILIAL = CR_FILIAL  
INNER JOIN CTT010 AS CTT ON CTT_CUSTO = C7_CC  
INNER JOIN SA2010 AS SA2 ON C7_FORNECE = A2_COD AND C7_LOJA = A2_LOJA  
INNER JOIN SYS_COMPANY AS FIL ON CR_FILIAL = M0_CODFIL 
WHERE SCR.D_E_L_E_T_ <> '*' AND SC7.D_E_L_E_T_ <> '*' AND SCR.CR_STATUS = '02' AND FIL.D_E_L_E_T_ <> '*' AND CR_NUM = '001869' ORDER BY CR_NUM --'"+pedido+"'
```

Concatenar colunas no tamanho igual a 2
```
SELECT CONCAT(CAST(XX8_EMPR AS VARCHAR(2)),CAST(XX8_UNID AS VARCHAR(2)),CAST (XX8_CODIGO AS VARCHAR(2))) AS FILIAL   
FROM SYS_COMPANY_CFG AS FIL 
WHERE D_E_L_E_T_ <> '*' AND XX8_EMPR = '01' AND XX8_UNID = '01'
```

