
--ORÇAMENTOS 
SELECT  
	VS1.VS1_FILIAL AS FILIAL
	,VS1.VS1_NUMORC AS ORCAMENTO
	,VS1.VS1_DESCON AS DESCONTO
	,VS1.VS1_VTOTNF AS VALORTOTAL
	,(VS1.VS1_VTOTNF - VS1.VS1_DESCON) VALORLIQ
	,CASE WHEN (VS1.VS1_STATUS = '0' AND VS1.VS1_TIPORC = '2') THEN 'Orcamento Oficina Digitado' 
		  WHEN (VS1.VS1_STATUS = '0' AND VS1.VS1_TIPORC = '1') THEN 'Orcamento Balcao Digitado'
		  WHEN (VS1.VS1_STATUS = '2' AND VS1.VS1_TIPORC = '1') THEN 'Margem Pendente'
		  WHEN VS1.VS1_STATUS = '3' THEN 'Avaliacao de Credito'
		  WHEN VS1.VS1_STATUS = '4' THEN 'Aguardando Separacao'
		  WHEN VS1.VS1_STATUS = '5' THEN 'Aguardando Lib.Diverg.'
		  WHEN VS1.VS1_STATUS LIKE '%RT%' THEN 'Aguardando Reserva'
		  WHEN (VS1.VS1_STATUS = 'F' AND VS1.VS1_TIPORC = '1') THEN 'Liberado p/ Faturamento'
		  WHEN (VS1.VS1_STATUS = 'F' AND VS1.VS1_TIPORC = '2') THEN 'Liberado p/ Oficina'
		  WHEN (VS1.VS1_STATUS = 'P' OR (VS1.VS1_STATUS = '2' AND VS1.VS1_TIPORC = '2')) THEN 'Pendente para O.S.'
		  WHEN VS1.VS1_STATUS = 'L' THEN 'Liberado para O.S.'
	 END AS STATUS_ORC 	
	 ,VS1.VS1_DATORC AS DT_ABERTURA

FROM VS1010 AS VS1
WHERE D_E_L_E_T_ = ''
AND VS1.VS1_STATUS IN ('0','2','3','4','5','R','T','RT','F','P','L')
AND VS1.VS1_TIPORC IN ('2','1')
