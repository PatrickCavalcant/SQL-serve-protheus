# SQL-Serve
Cláusulas desenvolvidas para utilização como exemplos no dia a dia.
Funções APSDU
---
Pack = exclui fisicamente os registros marcados como deletado;
zap = exclui fisicamente todos os registros da tabela, indiferente de estarem ou não marcados como deletados;
recall = "reativa" os registros marcados como deletados;
replace = substitui o conteudo atual de um campo , por um novo conteudo informado;
set deleted = ativa/desativa a visulização dos registros marcados como deletados;
set softseek = ativa/desativa a pesquisa relativa em um banco de dados indexado. 
Contar = conta quantos registros tem na tabela

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
VS1, Orçamentos
VO1, O.S
VO2 , O.S Requisição Cabeçalho
VO3, O.S  Requisição Peça
VO4, O.S Requisição Serviço
SA1, Clientes
SA2, Fornecedores
SB1, Produtos
SB2, Saldo atual
SB9, Saldo Inicial
SBZ, Indicadores de Produtos
SE1, Contas a receber
SE2, Contas a Pagar
VV1, Chassis
SLF, Usuário Caixa
VOE, Escala Automática Produtivos
XXE010 -  Tabela de Log, importaçao de registros
SX5, Tabela genérica
	Tabela 1 -  Controle de numeração da nota fiscal
SD9 , Controle de numeração da nota fiscal
SF2, Cabeçalho das NF de Saída - https://terminaldeinformacao.com/wp-content/tabelas/sf2.php
SD2, Campo da NF de Saída
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
