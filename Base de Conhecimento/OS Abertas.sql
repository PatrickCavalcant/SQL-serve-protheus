
SELECT DISTINCT  VO1.VO1_FILIAL , VO1.VO1_NUMOSV, VO1.VO1_TPATEN, VO1.VO1_PROVEI, VO1.VO1_LOJPRO, VO2.VO2_NOSNUM NUMREQ, VO1_STATUS,
				 VO2.VO2_DEVOLU,SUM(VO3_VALPEC) VALPEC 

	  FROM  VO1010 AS  VO1 
	  --CLIENTES
	  INNER JOIN   SA1010 AS SA1 ON SA1.A1_FILIAL  = '010110' AND SA1.A1_COD = VO1.VO1_PROVEI AND SA1.A1_LOJA = VO1.VO1_LOJPRO AND SA1.D_E_L_E_T_ = ' ' 
	  --CIDADES
	  INNER JOIN   VAM010 AS VAM ON VAM.VAM_FILIAL = '010110' AND VAM.VAM_IBGE = SA1.A1_IBGE AND VAM.D_E_L_E_T_ = ' ' 
      --VEICULOS
	  INNER JOIN   VV1010 AS VV1 ON VV1.VV1_FILIAL = '010110' AND VV1.VV1_CHAINT = VO1.VO1_CHAINT AND VO1.D_E_L_E_T_ = ' ' 
	  --MODELO DE VEICULOS
	  LEFT JOIN   VV2010 AS VV2 ON VV2.VV2_FILIAL = '010110' AND VV2.VV2_CODMAR = VV1.VV1_CODMAR AND VV2.VV2_MODVEI=VV1.VV1_MODVEI AND VV2.VV2_SEGMOD=VV1.VV1_SEGMOD AND VV2.D_E_L_E_T_=' ' 
	  --CORES DE VEICULOS
	  INNER JOIN   VVC010 AS VVC ON VVC.VVC_FILIAL = '010110' AND VVC.VVC_CODMAR = VV1.VV1_CODMAR AND VVC.VVC_CORVEI=VV1.VV1_CORVEI AND VVC.D_E_L_E_T_=' ' 
	  --REQUISI��O 
	  LEFT JOIN   VO2010 AS VO2 ON VO2_FILIAL = '010110' AND VO2_NUMOSV = VO1_NUMOSV AND VO2.D_E_L_E_T_ = ' ' 
	  --PE�AS NA OS
	  LEFT JOIN   VO3010 AS VO3 ON VO3_FILIAL = '010110'  AND VO3_NOSNUM = VO2_NOSNUM AND VO3.D_E_L_E_T_ = ' ' 
	  --SERVI�O NA OS
	  LEFT JOIN   VO4010 AS VO4 ON VO4_FILIAL = '010110'  AND VO4_NOSNUM = VO2_NOSNUM AND VO4.D_E_L_E_T_ = ' ' 
	  --INCOVENIENTES
	  --LEFT JOIN   VST010 AS VST ON VST.VST_FILIAL = '010110' AND VO1.VO1_NUMOSV = VST.VST_CODIGO AND (VO4.VO4_SEQINC = VST.VST_SEQINC OR VO3.VO3_SEQINC = VST.VST_SEQINC) AND VST.D_E_L_E_T_ = ' ' 
	
	  WHERE VO1.VO1_STATUS = 'A'
	  AND VO1.D_E_L_E_T_ = ''
	  
	  GROUP BY VO1.VO1_FILIAL , VO1.VO1_NUMOSV, VO1.VO1_TPATEN, VO1.VO1_PROVEI, VO1.VO1_LOJPRO, VO2.VO2_NOSNUM, VO1_STATUS,
				 VO2.VO2_DEVOLU,VO3_VALPEC
	 