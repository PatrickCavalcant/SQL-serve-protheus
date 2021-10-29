/*
##RESUMO DE DADOS###
    FORNECEDOR - CONVJD01
 O Total de registros lidos foram       :       29570                                                         
 O Total de registros selecionados foram:       14133                                                         
 O Total de registros desprezados foram :       15437
*/


SELECT * FROM SA2010

--1. APAGAR OS REGISTROS INVALIDOS(CPF/CNPJ INVALIDOS E TIPO = E)

--2. ALTERAR OS CARACTERES (-) E (.) DO CAMPO TELEFONE
UPDATE SA2010 SET A2_TEL = REPLACE(A2_TEL, '-','')  WHERE (A2_TEL LIKE '%-%') AND D_E_L_E_T_ = ''        
UPDATE SA2010 SET A2_TEL = REPLACE(A2_TEL, '.','')  WHERE (A2_TEL LIKE '%.%') AND D_E_L_E_T_ = ''    

--3. ALTERAR OS CARACTERES (.) E (-) DO CAMPO FAX                             
UPDATE SA2010 SET A2_FAX = REPLACE(A2_FAX, '-','')  WHERE (A2_FAX LIKE '%-%') AND D_E_L_E_T_ = ''    
UPDATE SA2010 SET A2_FAX = REPLACE(A2_FAX, '.','')  WHERE (A2_FAX LIKE '%.%') AND D_E_L_E_T_ = ''   

--3. ALTERAR OS CARACTERES (.) E (-) DO CAMPO INSCRIÇÃO ESTADUAL                        
UPDATE SA2010 SET A2_INSCR = REPLACE(A2_INSCR, '-','')  WHERE (A2_INSCR LIKE '%-%') AND D_E_L_E_T_ = '';                            
UPDATE SA2010 SET A2_INSCR = REPLACE(A2_INSCR, '.','')  WHERE (A2_INSCR LIKE '%.%') AND D_E_L_E_T_ = '';

--4. GRUPO TRIBUTÁRIO CLIENTE / FORNECEDOR 
UPDATE SA2010 SET A2_GRPTRIB = 'F01' WHERE A2_NOME LIKE '%JOHN DEERE%'    
UPDATE SA2010 SET A2_GRPTRIB = 'F02' WHERE A2_NOME NOT LIKE '%JOHN DEERE%'    

--5.
UPDATE SA2010 SET A2_MSBLQL = 1   

