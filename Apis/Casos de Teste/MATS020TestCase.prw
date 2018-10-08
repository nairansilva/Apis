#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATS020TestCase

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
@see        FWDefaultTestSuit , FWDefaultTestCase
/*/
//-------------------------------------------------------------------
CLASS MATS020TestCase from FWDefaultTestCase
	
	DATA oHelper
	
	METHOD SetUpClass()
	METHOD MATS020TestCase() CONSTRUCTOR
	METHOD MAT020_001()     //Get Lista Todos os Fornecedores
    METHOD MAT020_002()     //Get com cParam correto 
	METHOD MAT020_003()     //Get com cParam incorreto
    METHOD MAT020_004()     //Get com filtro Page
    METHOD MAT020_005()     //Get com filtro PageSize
    METHOD MAT020_006()     //Get com filtro Fields
    METHOD MAT020_007()     //Get com um fornecedor incorreto
    METHOD MAT020_008()     //Get com um fornecedor com a chave menor que 8 Caracteres
    METHOD MAT020_009()     //Get com filtro Order
    METHOD MAT020_010()     //Get com um Fornecedor específico
    METHOD MAT020_011()     //Post Json Inválido
    METHOD MAT020_012()     //Post Json Válido
    METHOD MAT020_013()     //Post Json Válido com Fields
    METHOD MAT020_014()     //Put Fornecedor Inválido
    METHOD MAT020_015()     //Put Fornecedor com Chave Menor que 8 caracteres
    METHOD MAT020_016()     //Put Json Inválido
    METHOD MAT020_017()     //Put Json Válido
    METHOD MAT020_018()     //Put Json Válido com Fields
    METHOD MAT020_019()     //Delete com fornecedor invalido
    METHOD MAT020_020()     //Delete Fornecedor com Chave Menor que 8 caracteres
    METHOD MAT020_021()     //Delete com Json válido
    METHOD MAT020_022()     //Put Json Válido com Dados Bancarios
    METHOD MAT020_023()     //Delete de Fornecedo com Dados Bancarios (FIL)
    METHOD MAT020_024()     //Post de Fornecedor Sem Passar code e storeId
    METHOD MAT020_025()     //Post de Fornecedor Sem Passar code
    METHOD MAT020_026()     //Post de Fornecedor Sem Passar StoredId
    METHOD MAT020_027()     //Put Json com Code e StoredId Válido

ENDCLASS

//-----------------------------------------------------------------
/*/{Protheus.doc} SetUpClass
Instancía os casos de teste

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0

/*/
//-----------------------------------------------------------------
METHOD SetUpClass() CLASS MATS020TestCase
	
    Local oHelper		:= FWTestHelper():New()

    Static aRetAuto := {}
 
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MATS020TestCase
Instancia os casos de teste

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MATS020TestCase() CLASS MATS020TestCase

    _Super:FWDefaultTestSuite()

    ::AddTestMethod("MAT020_001",,"Get Lista Todos os Fornecedores - GTSER-T30014")//CT001 -> Trocar
    ::AddTestMethod("MAT020_002",,"Get com cParam correto - GTSER-T30038")
    ::AddTestMethod("MAT020_003",,"Get com cParam incorreto - GTSER-T30015")
	::AddTestMethod("MAT020_004",,"Get com filtro Page - GTSER-T30037")
    ::AddTestMethod("MAT020_005",,"Get com filtro PageSize - GTSER-T30036")
    ::AddTestMethod("MAT020_006",,"Get com filtro Fields - GTSER-T30031")
    ::AddTestMethod("MAT020_007",,"Get com um fornecedor incorreto - GTSER-T30017")
    ::AddTestMethod("MAT020_008",,"Get com um fornecedor com a chave menor que 8 Caracteres - GTSER-T30016")
    ::AddTestMethod("MAT020_009",,"Get com filtro Order - GTSER-T30047")
    ::AddTestMethod("MAT020_010",,"Get com um Fornecedor específico - GTSER-T30016")
    ::AddTestMethod("MAT020_011",,"Post Json Inválido - GTSER-T30047")
    ::AddTestMethod("MAT020_012",,"Post Json Válido- GTSER-T30019")
    ::AddTestMethod("MAT020_013",,"Post Json Válido com Fields - GTSER-T30019")    
    ::AddTestMethod("MAT020_014",,"Put Fornecedor Inválido - GTSER-T30024")
    ::AddTestMethod("MAT020_015",,"Put Fornecedor com Chave Menor que 8 caracteres - GTSER-T30024")
    ::AddTestMethod("MAT020_016",,"Put Json Inválido - GTSER-T30022")
    ::AddTestMethod("MAT020_017",,"Put Json Válido - GTSER-T30021")
    ::AddTestMethod("MAT020_018",,"Put Json Válido com Fields - GTSER-T30035")
    ::AddTestMethod("MAT020_019",,"Delete com fornecedor invalido - GTSER-T30028")
    ::AddTestMethod("MAT020_020",,"Delete Fornecedor com Chave Menor que 8 caracteres - GTSER-T30028")
    ::AddTestMethod("MAT020_021",,"Delete com Json válido - GTSER-T30025")
    ::AddTestMethod("MAT020_022",,"Put Json com Code e StoredId Válido")
    ::AddTestMethod("MAT020_023",,"Delete de Fornecedo com Dados Bancarios (FIL) - GTSER-T30025")
    ::AddTestMethod("MAT020_024",,"Post de Fornecedor Sem Passar code e storeId - GTSER-T30019")
    ::AddTestMethod("MAT020_025",,"Post de Fornecedor Sem Passar code - GTSER-T30019")
    ::AddTestMethod("MAT020_026",,"Post de Fornecedor Sem Passar StoredId - GTSER-T30019")
    ::AddTestMethod("MAT020_027",,"Put Json com Code e StoredId Válido - GTSER-T30021")

Return 

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_001
Get Lista Todos os Fornecedores - GTSER-T30014

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_001() CLASS MATS020TestCase
	
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/2"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
            Else  
                oHelper:lOk := oBody['errorCode'] == Nil               
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )
	
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_002
Get com cParam correto - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_002() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor?code=000001"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint customerVendor/customerVendor?code=000001')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar Objeto Body')
            Else
                If oBody['items'] <> Nil
                    oHelper:lOk := oBody['items'][1]['code'] == '000001'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_003
Get com cParam incorreto - GTSER-T30015

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_003() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/2?code=XW1001"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2?code=XW1001')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
            Else
                If oBody['errorCode'] <> Nil        
                    oHelper:lOk := oBody['errorCode'] == 404
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_004
Get com filtro Page - GTSER-T30037

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_004() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/2?Page=3"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2?Page=3')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
            Else
                If oBody['items'] <> Nil        
                    oHelper:lOk := oBody['items'][1]['code'] == '007FIN'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_005
Get com filtro PageSize - GTSER-T30036

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_005() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/2?PageSize=2"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint customerVendor/customerVendor/2?PageSize=2')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
            Else
                If oBody['items'] <> Nil        
                    oHelper:lOk := Len(oBody['items']) <= 2
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_006
Get com filtro Fields - GTSER-T30031

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_006() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/2?fields=shortName"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2?fields=shortName')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
            Else
                If oBody['items'] <> Nil
                    oHelper:lOk := oBody['items'][1]['code'] == Nil .And. oBody['items'][1]['shortName'] != Nil
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_007
Get com um fornecedor incorreto - GTSER-T30017

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_007() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/2/XW100101"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/XW100101')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> NIl
                ConOut('Erro ao carregar oBjeto Body')
            Else
                If oBody['errorCode'] <> Nil
                    oHelper:lOk := oBody['errorCode'] == 404
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_008
Get com um fornecedor com a chave menor que 8 Caracteres - GTSER-T30016

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_008() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/2/000001"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/000001')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar Objeto Body')
            Else
                If oBody['errorCode'] <> Nil
                    oHelper:lOk := oBody['errorCode'] == 400
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_009
Get com filtro Order - GTSER-T30047

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_009() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cNome         := ""
    Local cQuery        := ""
    Local cTemp     	:= GetNextAlias()
    Local cURL          := "/customerVendor/customerVendor/2?Order=name"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    cQuery := " SELECT TOP 1 A2_NOME FROM " + RetSqlName("SA2") + " WHERE A2_FILIAL = '" + xFilial("SA2") + "' AND D_E_L_E_T_ = ' ' Order By A2_NOME "    
	cQuery := ChangeQuery(cQuery)
	MPSysOpenQuery( cQuery, cTemp )

    cNome   := (cTemp)->A2_NOME

    (cTemp)->(DbCloseArea())

    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2?Order=name')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar Objeto Body')
            Else
                If oBody['items'] <> Nil
                    oHelper:lOk := oBody['items'][1]['name']  == cNome
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_010
Get com um Fornecedor específico - GTSER-T30016

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_010() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/2/00000101"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/00000101')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> NIL
                ConOut('Erro ao carregar Objeto Body')
            Else
                If oBody['code'] <> Nil
                    oHelper:lOk := oBody['code'] == '000001' .And. oBody['storeId'] == '01'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_011
Post Json Inválido - GTSER-T30020

@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_011() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor')
    Else
        cBody := '{"code": "","shortName": "","name": "","branchID": ""}'
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar Objeto Body')          
        Else
            If oRet['errorCode'] <> Nil        
                oHelper:lOk := oRet['errorCode'] == 400
            EndIf
        EndIf
    EndIf 

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_012
Post Json Válido - GTSER-T30019

@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_012() CLASS MATS020TestCase 

    Local aHeader       := {}
    Local cBody     := ""
    Local cRet      := ""
    Local cURL      := "/customerVendor/customerVendor"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor')
    Else
        cBody := '{"branchId": "D MG","code": "CRM001","storeId": "01","name": "TESTE PFISICA E PIS",'
        cBody += '"shortName": "TESTE PF","strategicCustomerType": "F","registerSituation": "2","type": 2,"GovernmentalInformation":[{"id": "54214755065",'
        cBody += '"name": "CPF|CNPJ"},{"id": "81774322523","name": "INSCRICAO PIS"},{"id": "122060076","name": "RG"}],"listOfBankingInformation": ['
        cBody += '{"checkingAccountNumber": "00000","currencyAccount": 1,"bankCode": "000","branchCode": "0000 ","checkingAccountType":"0","branchKey": "0",'
        cBody += '"bankInternalId": null,"bankName": null,"mainAccount": "1","checkingAccountNumberKey":"0"}],"listOfCommunicationInformation": ['
        cBody += '{"phoneNumber": "99999999","diallingCode": "11"}],"address":{"number": null,"address": "RUA DO TESTE, 000","mainAddress": true,'
        cBody += '"zipCode": "00000000","shippingAddress": false,"billingAddress": false,"state": {"stateId": "SP"},"complement": "TESTE COMPLEMENTO",'
        cBody += '"district": "TESTE","city":{"cityCode": "50308","cityDescription": "SAO PAULO"},"country":{"countryInternalId": "105"}}}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                oHelper:lOk := oRet['code'] == 'CRM001' .And. oRet['storeId'] == '01'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_013
Post Json Válido com Fields - GTSER-T30019

@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_013() CLASS MATS020TestCase 

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor?fields=code"
    Local oHelper	:= FWTestHelper():New()
    Local oRet      := Nil    
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor?fields=code')
    Else
        cBody := '{"branchId": "D MG","code": "CRM004","storeId": "01",'
	    cBody += '"name": "POST FIELD LTDA","shortName": "TESTE POST","strategicCustomerType": "J",'
        cBody += '"GovernmentalInformation":[{"id": "16758707000100","name": "CPF|CNPJ"}],'
        cBody += '"listOfBankingInformation":[{"checkingAccountNumber": "0000000000","currencyAccount": 1,'
        cBody += '"bankCode": "000","branchCode":"00000", "checkingAccountType": "0","branchKey": "0",'
        cBody += '"bankInternalId": null,"bankName": null,"mainAccount": "1","checkingAccountNumberKey": "00"}],'
        cBody += '"address": {"number": null,"address": "AV. TESTE, 0000","mainAddress": true,"zipCode": "00000000",'
        cBody += '"shippingAddress": false,"billingAddress": false,"state": {"stateId": "SP"}, "complement": "TESTE",'
        cBody += '"district": "TESTE","city":{"cityCode":"50308","cityDescription":"SAO PAULO"},'
        cBody += '"country":{"countryCode":"105"}},"registerSituation":"2","type": 2}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                oHelper:lOk := oRet['code'] != Nil .And. oRet['shortName'] == Nil
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_014
Put Fornecedor Inválido - GTSER-T30024
@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_014() CLASS MATS020TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/2/ABCDEF01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/ABCDEF01')
    Else
        cBody := '{"shortName": "ALTERADO"}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['errorCode'] <> Nil        
                oHelper:lOk := oRet['errorCode'] == 404
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_015
Put Fornecedor com Chave Menor que 8 caracteres - GTSER-T30024
@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_015() CLASS MATS020TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/2/ABCDEF"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/ABCDEF')
    Else
        cBody := '{"shortName": "ALTERADO"}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['errorCode'] <> Nil        
                oHelper:lOk := oRet['errorCode'] == 400
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_016
Put Json Inválido - GTSER-T30022

@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_016() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/2/CRM00101"    
    Local oHelper	:= FWTestHelper():New()
    Local oRet      := Nil
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint customerVendor/customerVendor/2/CRM00101')
    Else
        cBody := '{"code": "","shortName": "","name": "","branchID": ""}'
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                oHelper:lOk := .T.
        Else
            If oRet['errorCode'] <> Nil
                oHelper:lOk := oRet['errorCode'] == 400
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_017
Put Json Válido - GTSER-T30021

@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_017() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/2/CRM00101"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/CRM00101')
    Else
        cBody := '{"shortName": "Alterado"}'
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['shortName'] <> Nil
                oHelper:lOk := AllTrim(oRet['shortName']) == 'Alterado'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
    
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_018
Put Json Válido com Fields    - GTSER-T30035
@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_018() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/2/CRM00101?fields=code"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/CRM00101?fields=code')
    Else
        cBody := '{"shortName": "Alterado"}'
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                oHelper:lOk := oRet['code'] != Nil .And. oRet['shortName'] == Nil
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_019
Delete com fornecedor invalido - GTSER-T30028
@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_019() CLASS MATS020TestCase

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/2/ABCDEF01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/ABCDEF01')
    Else
        cBody := '{"branchId": "D MG","code": "ABCDEF","storeId": "01","companyInternalId": "T1D MG    ABCDEF01"}'
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['errorCode'] <> Nil        
                oHelper:lOk := oRet['errorCode'] == 404
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_020
Delete Fornecedor com Chave Menor que 8 caracteres - GTSER-T30028
@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_020() CLASS MATS020TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/2/CRM001"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/ABCDEF')
    Else
        cBody := '{"branchId": "D MG","code": "CRM001","storeId": "01","companyInternalId": "T1D MG    CRM00101"}'
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['errorCode'] <> Nil        
                oHelper:lOk := oRet['errorCode'] == 400
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
    
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_021
Delete com Json válido - GTSER-T30025
@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_021() CLASS MATS020TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/2/CRM00101"    
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/CRM00101')
    Else
        cBody := '{"branchId": "D MG","code": "CRM001","storeId": "01","companyInternalId": "T1D MG    CRM00101"}'        
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['response'] <> Nil        
                oHelper:lOk := "Sucesso" $ oRet['response'] 
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
    
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_022
Put Json Válido com Dados Bancarios

@author     Squad CRM Faturamento
@since      05/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_022() CLASS MATS020TestCase 

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/2/CRM00401"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/CRM00401')
    Else
        cBody := '{"branchId": "D MG","code": "CRM004","storeId": "01",'
	    cBody += '"name": "Alterado","shortName": "Alterado","strategicCustomerType": "J",'
        cBody += '"GovernmentalInformation":[{"id": "16758707000100","name": "CPF|CNPJ"}],'
        cBody += '"listOfBankingInformation":[{"checkingAccountNumber": "0000000000","currencyAccount": 1,'
        cBody += '"bankCode": "000","branchCode":"00000", "checkingAccountType": "0","branchKey": "0",'
        cBody += '"bankInternalId": null,"bankName": null,"mainAccount": "1","checkingAccountNumberKey": "00"}]}'        

        cRet    := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet    := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['shortName'] <> Nil
                oHelper:lOk := AllTrim(oRet['shortName']) == 'Alterado'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper


//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_023
Delete de Fornecedo com Dados Bancarios (FIL) - GTSER-T30025

@author     Squad CRM Faturamento
@since      05/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_023() CLASS MATS020TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/2/CRM00401"    
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/CRM00401')
    Else
        cBody := '{"branchId": "D MG","code": "CRM001","storeId": "01","companyInternalId": "T1D MG    CRM00401"}'        
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['response'] <> Nil        
                oHelper:lOk := "Sucesso" $ oRet['response']
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
    
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_024
Post de Fornecedor Sem Passar code e storeId - GTSER-T30019

@author     Squad CRM Faturamento
@since      05/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_024() CLASS MATS020TestCase 

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cCodFor   := ''
    Local cLoja     := ''
    Local cURL      := "/customerVendor/customerVendor"
    Local oHelper	:= FWTestHelper():New()
    Local oRet      := Nil    
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor')
    Else
        cBody := '{"branchId": "D MG","name": "POST FIELD LTDA","shortName": "TESTE POST","strategicCustomerType": "J",'
        cBody += '"GovernmentalInformation":[{"id": "98160591000169","name": "CPF|CNPJ"}],'
        cBody += '"address": {"number": null,"address": "AV. TESTE, 0000","mainAddress": true,"zipCode": "00000000",'
        cBody += '"shippingAddress": false,"billingAddress": false,"state": {"stateId": "SP"}, "complement": "TESTE",'
        cBody += '"district": "TESTE","city":{"cityCode":"50308","cityDescription":"SAO PAULO"},'
        cBody += '"country":{"countryCode":"105"}},"registerSituation":"2","type": 2}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                cCodFor := oRet['code']
                cLoja   := oRet['storeId']
                
                cTable  := "SA2"
                cQuery  := "A2_FILIAL = 'D MG    ' AND A2_COD = '" + cCodFor + "' AND A2_LOJA = '" + cLoja + "'"
	
	            oHelper:UTQueryDB( cTable, "A2_COD"     ,cQuery, cCodFor )
                oHelper:UTQueryDB( cTable, "A2_LOJA"    ,cQuery, cLoja )
            Else
                oHelper:lOk := .F.                
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_025
Post de Fornecedor Sem Passar code - GTSER-T30019

@author     Squad CRM Faturamento
@since      05/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_025() CLASS MATS020TestCase 

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cCodFor   := ''
    Local cURL      := "/customerVendor/customerVendor"
    Local oHelper	:= FWTestHelper():New()
    Local oRet      := Nil    
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor')
    Else
        cBody := '{"branchId": "D MG","name": "POST FIELD LTDA","shortName": "TESTE POST","strategicCustomerType": "J",'
        cBody += '"storeId": "01","GovernmentalInformation":[{"id": "98160591000169","name": "CPF|CNPJ"}],'
        cBody += '"address": {"number": null,"address": "AV. TESTE, 0000","mainAddress": true,"zipCode": "00000000",'
        cBody += '"shippingAddress": false,"billingAddress": false,"state": {"stateId": "SP"}, "complement": "TESTE",'
        cBody += '"district": "TESTE","city":{"cityCode":"50308","cityDescription":"SAO PAULO"},'
        cBody += '"country":{"countryCode":"105"}},"registerSituation":"2","type": 2}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                cCodFor := oRet['code']                
                
                cTable  := "SA2"
                cQuery  := "A2_FILIAL = 'D MG    ' AND A2_COD = '" + cCodFor + "' AND A2_LOJA = '01' "
	
	            oHelper:UTQueryDB( cTable, "A2_COD"     ,cQuery, cCodFor )
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_026
Post de Fornecedor Sem Passar StoredId - GTSER-T30019

@author     Squad CRM Faturamento
@since      05/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_026() CLASS MATS020TestCase 

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cCodFor   := ''
    Local cURL      := "/customerVendor/customerVendor"
    Local oHelper	:= FWTestHelper():New()
    Local oRet      := Nil    
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor')
    Else
        cBody := '{"branchId": "D MG","name": "POST FIELD LTDA","shortName": "TESTE POST","strategicCustomerType": "J",'
        cBody += '"code": "CRM005","GovernmentalInformation":[{"id": "98160591000169","name": "CPF|CNPJ"}, 
        cBody += '{"id:":"642324714946", "name": "INSCRICAO ESTADUAL"},{"id": "123456","name": "INSCRICAO MUNICIPAL"}],'
        cBody += '"address": {"number": null,"address": "AV. TESTE, 0000","mainAddress": true,"zipCode": "00000000",'
        cBody += '"shippingAddress": false,"billingAddress": false,"state": {"stateId": "SP"}, "complement": "TESTE",'
        cBody += '"district": "TESTE","city":{"cityCode":"50308","cityDescription":"SAO PAULO"},'
        cBody += '"country":{"countryCode":"105"}},"registerSituation":"2","type": 2}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                cCodFor := oRet['code']
                
                cTable  := "SA2"
                cQuery  := "A2_FILIAL = 'D MG    ' AND A2_COD = 'CRM005' AND A2_LOJA = '01' "
	
	            oHelper:UTQueryDB( cTable, "A2_COD"     ,cQuery, cCodFor )
                oHelper:UTQueryDB( cTable, "A2_LOJA"    ,cQuery, "01"    )
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT020_027
Put Json com Code e StoredId Válido - GTSER-T30021

@author     Squad CRM Faturamento
@since      03/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT020_027() CLASS MATS020TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/2/CRM00501"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/2/CRM00501')
    Else
        cBody   := '{"code": "CRM005", "StoreId": "01","shortName": "Alterado"}'
        cRet    := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet    := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['shortName'] <> Nil
                oHelper:lOk := AllTrim(oRet['shortName']) == 'Alterado'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
    
Return oHelper

