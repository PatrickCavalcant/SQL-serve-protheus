--Query basica conferencia vendas - DPM
SELECT SUM(D2_TOTAL) 
FROM SD2010 SD2
JOIN SBM010 SBM on BM_GRUPO = D2_GRUPO AND SBM.D_E_L_E_T_ = ' '
JOIN SF4010 SF4 with(nolock) ON SF4.F4_FILIAL = '      ' AND SF4.F4_CODIGO = SD2.D2_TES AND SF4.F4_OPEMOV = '05' AND SF4.D_E_L_E_T_ = ' '
WHERE D2_EMISSAO BETWEEN '20210801' AND '20210831' 
AND D2_GRUPO IN ('JDC','AMS','JD','JDM','PCA','PCH','PCP','PFF','PPC','PPL','PPM','PPV','PTR','SEM','TURF')
--AND D2_GRUPO IN ('POM')
AND SD2.D_E_L_E_T_ = ' '
AND BM_PROORI = '1' -- 1 - ORIGINAL // 0 - OUTRAS MARCAS


--Query da rotina do DPM - Vendas
SELECT VS3_CODSIT, COALESCE(SUM(D2_CUSTO1), 0) SOMA_CUSTO, COALESCE(SUM(D2_TOTAL), 0) SOMA_TOTAL
FROM
  (
    SELECT cast(D2_CUSTO1 AS int) D2_CUSTO1, cast(D2_TOTAL AS int) D2_TOTAL, SITUACAO.VS3_CODSIT
      FROM SD2010 SD2 with(nolock)
      JOIN SF2010 SF2 with(nolock) ON SF2.F2_FILIAL = SD2.D2_FILIAL AND SF2.F2_DOC = SD2.D2_DOC AND SF2.F2_SERIE = SD2.D2_SERIE 
	   AND SF2.F2_PREFORI IN ('BAL', 'OFI') AND SF2.D_E_L_E_T_ = ' '
      JOIN SF4010 SF4 with(nolock) ON SF4.F4_FILIAL = '      ' AND SF4.F4_CODIGO = SD2.D2_TES   AND SF4.F4_OPEMOV = '05' AND SF4.D_E_L_E_T_ = ' '
      JOIN SB1010 SB1 with(nolock) ON SB1.B1_FILIAL = '0101  ' AND SD2.D2_COD = SB1.B1_COD      AND SB1.D_E_L_E_T_ = ' '
      JOIN SBM010 SBM with(nolock) ON SBM.BM_FILIAL = '0101  ' AND SBM.BM_GRUPO = SB1.B1_GRUPO  AND SBM.BM_VAIDPM = '1'  AND SBM.D_E_L_E_T_ = ' '
 LEFT JOIN
   (
     SELECT VS1_FILIAL, VS3_CODITE, VS3_GRUITE, VS3_CODSIT, VS1_NUMNFI, VS1_SERNFI
       FROM VS1010 VS1 with(nolock)
       JOIN VS3010 VS3 with(nolock) ON VS3.VS3_FILIAL = VS1_FILIAL
        AND VS3_NUMORC = VS1_NUMORC
        AND VS3.D_E_L_E_T_ = ' '
      WHERE VS1.D_E_L_E_T_ = ' ' 
   ) SITUACAO ON VS1_FILIAL = D2_FILIAL
   AND VS3_CODITE = B1_CODITE
   AND VS3_GRUITE = B1_GRUPO
   AND VS1_NUMNFI = D2_DOC
   AND VS1_SERNFI = D2_SERIE
   WHERE 1=1
     -- AND SD2.D2_FILIAL = '010104'
     AND SD2.D2_EMISSAO >= '20210801'
     AND SD2.D2_EMISSAO <= '20210831'
     AND SD2.D_E_L_E_T_ = ' '
     -- AND SB1.B1_CRICOD LIKE '00'
     AND SBM.BM_PROORI = '1' 
) TEMP_TBL
WHERE (VS3_CODSIT IS NULL OR VS3_CODSIT = ' ' OR VS3_CODSIT NOT IN ('03')) 
GROUP BY VS3_CODSIT