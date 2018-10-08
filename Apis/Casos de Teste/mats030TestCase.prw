#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATS030TestCase

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
@see        FWDefaultTestSuit , FWDefaultTestCase
/*/
//-------------------------------------------------------------------

CLASS MATS030TestCase from FWDefaultTestCase
	
	DATA oHelper
	
	METHOD SetUpClass()
	METHOD MATS030TestCase() CONSTRUCTOR
	METHOD MAT030_001()     //Get Lista Todos os Clientes
    METHOD MAT030_002()     //Get com cParam correto 
	METHOD MAT030_003()     //Get com cParam incorreto
    METHOD MAT030_004()     //Get com filtro Page
    METHOD MAT030_005()     //Get com filtro PageSize
    METHOD MAT030_006()     //Get com filtro Fields
    METHOD MAT030_007()     //Get com um Cliente incorreto
    METHOD MAT030_008()     //Get com um Cliente com a chave menor que 8 Caracteres
    METHOD MAT030_009()     //Get com filtro Order
    METHOD MAT030_010()     //Get com um Cliente específico
    METHOD MAT030_011()     //Post Json Inválido
    METHOD MAT030_012()     //Post de Cliente Pessoa Fisica com Json Válido - GTSER-T30019
    METHOD MAT030_013()     //Post de Cliente Pessoa Juridica com Json Válido com Fields - GTSER-T30019
    METHOD MAT030_014()     //Put Cliente Inválido
    METHOD MAT030_015()     //Put Cliente com Chave Menor que 8 caracteres
    METHOD MAT030_016()     //Put Json Inválido
    METHOD MAT030_017()     //Put Json Válido
    METHOD MAT030_018()     //Put Json Válido com Fields
    METHOD MAT030_019()     //Delete com Cliente invalido
    METHOD MAT030_020()     //Delete Cliente com Chave Menor que 8 caracteres
    METHOD MAT030_021()     //Delete com Json válido
    METHOD MAT030_022()     //Post de Cliente sem informar Codigo e Loja
    METHOD MAT030_023()     //Post de Cliente sem informar Codigo
    METHOD MAT030_024()     //Post de Cliente sem informar Loja
    METHOD MAT030_025()     //Put Json com Code e StoredId Válido
    METHOD MAT030_026()     //Put Json com Code Válido
    METHOD MAT030_027()     //Put Json com StoredID Válido
    METHOD MAT030_028()     //Put Json InVálido
    METHOD MAT030_029()     //Put Json type 3
    METHOD MAT030_030()     //Put Json type invalido
    METHOD MAT030_031()     //Get com Type e Codigo incorreto
    METHOD MAT030_032()     //Get com Type incorreto
    METHOD MAT030_033()     //Get com Codigo de Cliente e fornecedor incorreto
    METHOD MAT030_034()     //Post Json com Type 3 - GTSER-T30020
    METHOD MAT030_035()     //Post Json com Type invalido - GTSER-T30020
    METHOD MAT030_036()     //Delete com type 3 - GTSER-T30028
    METHOD MAT030_037()     //Delete com type invalido - GTSER-T30028

ENDCLASS

//-----------------------------------------------------------------
/*/{Protheus.doc} SetUpClass
Instancía os casos de teste

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0

/*/
//-----------------------------------------------------------------

METHOD SetUpClass() CLASS MATS030TestCase
	
    Local oHelper   := FWTestHelper():New()

    Static aRetAuto := {}
 
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MATS030TestCase
Instancia os casos de teste

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MATS030TestCase() CLASS MATS030TestCase

    _Super:FWDefaultTestSuite()

    ::AddTestMethod("MAT030_001",,"Get Lista Todos os Clientes - GTSER-T30014")//CT001 -> Trocar
    ::AddTestMethod("MAT030_002",,"Get com cParam correto - GTSER-T30038")
    ::AddTestMethod("MAT030_003",,"Get com cParam incorreto - GTSER-T30015")
	::AddTestMethod("MAT030_004",,"Get com filtro Page - GTSER-T30037")
    ::AddTestMethod("MAT030_005",,"Get com filtro PageSize - GTSER-T30036")
    ::AddTestMethod("MAT030_006",,"Get com filtro Fields - GTSER-T30031")
    ::AddTestMethod("MAT030_007",,"Get com um Cliente incorreto - GTSER-T30017")
    ::AddTestMethod("MAT030_008",,"Get com um Cliente com a chave menor que 8 Caracteres - GTSER-T30016")
    ::AddTestMethod("MAT030_009",,"Get com filtro Order - GTSER-T30047")
    ::AddTestMethod("MAT030_010",,"Get com um Cliente específico - GTSER-T30016")
    ::AddTestMethod("MAT030_011",,"Get com filtro Order - GTSER-T30047")
    ::AddTestMethod("MAT030_012",,"Post de Cliente Pessoa Fisica com Json Válido - GTSER-T30019")
    ::AddTestMethod("MAT030_013",,"Post de Cliente Pessoa Juridica com Json Válido com Fields - GTSER-T30019")    
    ::AddTestMethod("MAT030_014",,"Put Cliente Inválido - GTSER-T30024")
    ::AddTestMethod("MAT030_015",,"Put Cliente com Chave Menor que 8 caracteres - GTSER-T30024")
    ::AddTestMethod("MAT030_016",,"Put Json Inválido - GTSER-T30022")
    ::AddTestMethod("MAT030_017",,"Put Json Válido - GTSER-T30021")
    ::AddTestMethod("MAT030_018",,"Put Json Válido com Fields - GTSER-T30035")
    ::AddTestMethod("MAT030_019",,"Delete com Cliente invalido - GTSER-T30028")
    ::AddTestMethod("MAT030_020",,"Delete Cliente com Chave Menor que 8 caracteres - GTSER-T30028")
    ::AddTestMethod("MAT030_021",,"Delete com Json válido - GTSER-T30025")
    ::AddTestMethod("MAT030_022",,"Post de Cliente sem informar Codigo e Loja - GTSER-T30019")    
    ::AddTestMethod("MAT030_023",,"Post de Cliente sem informar Codigo - GTSER-T30019")
    ::AddTestMethod("MAT030_024",,"Post de Cliente sem informar Loja - GTSER-T30019")
    ::AddTestMethod("MAT030_025",,"Put Json com Code e StoredId Válido - GTSER-T30021")
    ::AddTestMethod("MAT030_026",,"Put Json com Code Válido - GTSER-T30021")
    ::AddTestMethod("MAT030_027",,"Put Json com StoredID Válido - GTSER-T30021")
    ::AddTestMethod("MAT030_026",,"Put Json InVálido - GTSER-T30021")
    ::AddTestMethod("MAT030_028",,"Put Json type 3 - GTSER-T30021")
    ::AddTestMethod("MAT030_030",,"Put Json type invalido - GTSER-T30021")
    ::AddTestMethod("MAT030_031",,"Get com Type e codigo incorreto - GTSER-T30015")
    ::AddTestMethod("MAT030_032",,"Get com Type incorreto - GTSER-T30015")
    ::AddTestMethod("MAT030_033",,"Get com Codigo de Cliente e fornecedor incorreto - GTSER-T30015")
    ::AddTestMethod("MAT030_034",,"Post Json com Type 3 - GTSER-T30020")
    ::AddTestMethod("MAT030_035",,"Post Json com Type invalido - GTSER-T30020")
    ::AddTestMethod("MAT030_036",,"Delete com type 3 - GTSER-T30028")
    ::AddTestMethod("MAT030_037",,"Delete com type invalido - GTSER-T30028")

Return

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_001
Get Lista Todos os Cliente - GTSER-T30014

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_001() CLASS MATS030TestCase
	
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/1"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.
            Else  
                oHelper:lOk := oBody['errorCode'] == Nil               
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )
	
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_002
Get com cParam correto - GTSER-T30038

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_002() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/1/?code=000001"
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
                oHelper:lOk := .F.
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
/*/{Protheus.doc} MAT030_003
Get com cParam incorreto - GTSER-T30015

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_003() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/1?code=XW1001"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1?code=XW1001')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.
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
/*/{Protheus.doc} MAT030_004
Get com filtro Page - GTSER-T30037

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_004() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/1?Page=3"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1?Page=3')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.
            Else
                If oBody['items'] <> Nil        
                    oHelper:lOk := oBody['items'][1]['code'] == '012FIN'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_005
Get com filtro PageSize - GTSER-T30036

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_005() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/1?PageSize=2"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1?PageSize=2')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.
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
/*/{Protheus.doc} MAT030_006
Get com filtro Fields - GTSER-T30031

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_006() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/1?fields=shortName"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1?fields=shortName')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.
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
/*/{Protheus.doc} MAT030_007
Get com um Cliente incorreto - GTSER-T30017

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_007() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/1/XW100101"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/XW100101')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> NIl
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.
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
/*/{Protheus.doc} MAT030_008
Get com um Cliente com a chave menor que 8 Caracteres - GTSER-T30016

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_008() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/1/000001"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/000001')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar Objeto Body')
                oHelper:lOk := .F.
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
/*/{Protheus.doc} MAT030_009
Get com filtro Order - GTSER-T30047

@author     Squad CRM Faturamento
@since     04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_009() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cNome         := ""
    Local cQuery        := ""
    Local cTemp     	:= GetNextAlias()
    Local cURL          := "/customerVendor/customerVendor/1?Order=name"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    cQuery := " SELECT TOP 1 A1_NOME FROM " + RetSqlName("SA1") + " WHERE A1_FILIAL = '" + xFilial("SA1") + "' AND D_E_L_E_T_ = ' ' Order By A1_NOME "    
	cQuery := ChangeQuery(cQuery)
	MPSysOpenQuery( cQuery, cTemp )

    cNome   := (cTemp)->A1_NOME

    (cTemp)->(DbCloseArea())

    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1?Order=name')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar Objeto Body')
                oHelper:lOk := .F.
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
/*/{Protheus.doc} MAT030_010
Get com um Cliente específico - GTSER-T30016

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_010() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/1/00000101"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/00000101')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar Objeto Body')
                oHelper:lOk := .F.
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
/*/{Protheus.doc} MAT030_011
Post Json Inválido - GTSER-T30020

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_011() CLASS MATS030TestCase

    Local aHeader   := {}
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
        cBody := '{"code": "","shortName": "","name": "","branchID": ""'
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar Objeto Body')
            oHelper:lOk := .F.
        Else
            If oRet['errorCode'] <> Nil
                oHelper:lOk := oRet['errorCode'] == 400
            EndIf
        EndIf
    EndIf

    oHelper:AssertFalse(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_012
Post de Cliente Pessoa Fisica com Json Válido - GTSER-T30019

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_012() CLASS MATS030TestCase 

    Local aHeader       := {}
    Local cBody     := ""
    Local cRet      := ""
    Local cURL      := "/customerVendor/customerVendor"
    Local oHelper	:= FWTestHelper():New()
    Local oRet      := Nil
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor')
    Else
        cBody := '{"branchId": "D MG","code":"CRM003","storeId": "01","companyInternalId": "T1D MG    CRM00301",'
        cBody += '"type":1,"name": "CLIENTE POST PF","shortName":"POST PF","strategicCustomerType":"F","entityType": "F",'
        cBody += '"registerSituation": "2","paymentConditionCode":"CP5","priceListHeaderItemCode": "003","carrierCode": "FAT001",'
	    cBody += '"marketsegment":{"marketSegmentCode": "000001"},"address":{"address": "RUA DO TESTE, 000","district": "TESTER",'
		cBody += '"zipCode": "00000000","country":{"countryCode": "105"},"state":{"stateId": "SP"},"city": {"cityCode": "50308",'
        cBody += '"cityDescription": "SAO PAULO"}},"GovernmentalInformation":[{"id": "34350350721","name": "CPF/CNPJ"},{"id": "126965936",'
        cBody += '"name": "RG"},{"id": "253244863","name": "PASSAPORTE"}],"shippingAddress":{"shippingAddress": true,"address": "AV DO TESTE, 999",'
		cBody += '"district": "TESTER","zipCode": "00000000","country":{"countryCode": "105"},"state": {"stateId": "SP"},"city": {"cityCode": "50308",'
        cBody += '"cityDescription": "SAO PAULO"}},"listOfContacts":[{"ContactInformationName": "TESTEDOR","ContactInformationAddress": {'
        cBody += '"state": {},"city": {},"country": {}}}],"creditInformation":{"creditLimit": 100000000,"additionalCreditLimit": 250000,'
		cBody += '"creditLimitCurrency": 2,"creditLimitDate": "2018-12-31T00:00:00"},"billingInformation":{"address": {"billingAddress": true,'
		cBody += '"address": "RUA DO TESTE, 000","district": "TESTER","zipCode": "00000000","country": {"countryCode": "105"},"state":{'
		cBody += '"stateId": "SP"},"city": {"cityCode": "50308","cityDescription": "SAO PAULO"}}}}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                oHelper:lOk := oRet['code'] == 'CRM003' .And. oRet['storeId'] == '01'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_013
Post de Cliente Pessoa Juridica com Json Válido com Fields - GTSER-T30019

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_013() CLASS MATS030TestCase 

    Local aHeader       := {}
    Local cBody     := ""
    Local cRet      := ""
    Local cURL      := "/customerVendor/customerVendor?fields=code"    
    Local oHelper	:= FWTestHelper():New()
    Local oRet      := Nil
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor?fields=code')
    Else
        cBody := '{"branchId": "D MG","code":"CRM004","storeId": "01","companyInternalId": "T1D MG    CRM00401",'
        cBody += '"type":1,"name": "CLIENTE POST PJ","shortName":"POST PJ","strategicCustomerType":"F","entityType": "J",'
        cBody += '"registerSituation": "2","paymentConditionCode":"CP5","priceListHeaderItemCode": "003","carrierCode": "FAT001",'
	    cBody += '"marketsegment":{"marketSegmentCode": "000001"},"address":{"address": "RUA DO TESTE, 000","district": "TESTER",'
		cBody += '"zipCode": "00000000","country":{"countryCode": "105"},"state":{"stateId": "SP"},"city": {"cityCode": "50308",'
        cBody += '"cityDescription": "SAO PAULO"}},"GovernmentalInformation":[{"id": "20742165000146","name": "CPF|CNPJ"},{"id": "531088084836",'
        cBody += '"name": "INSCRICAO ESTADUAL"},{"id": "144863","name": "INSCRICAO MUNICIPAL"},{"id": "12548","name": "SUFRAMA"}],'
        cBody += '"shippingAddress":{"shippingAddress": true,"address": "AV DO TESTE, 999",'
		cBody += '"district": "TESTER","zipCode": "00000000","country":{"countryCode": "105"},"state": {"stateId": "SP"},"city": {"cityCode": "50308",'
        cBody += '"cityDescription": "SAO PAULO"}},"listOfContacts":[{"ContactInformationName": "TESTEDOR","ContactInformationAddress": {'
        cBody += '"state": {},"city": {},"country": {}}}],"creditInformation":{"creditLimit": 100000000,"additionalCreditLimit": 250000,'
		cBody += '"creditLimitCurrency": 2,"creditLimitDate": "2018-12-31T00:00:00"},"billingInformation":{"address": {"billingAddress": true,'
		cBody += '"address": "RUA DO TESTE, 000","district": "TESTER","zipCode": "00000000","country": {"countryCode": "105"},"state":{'
		cBody += '"stateId": "SP"},"city": {"cityCode": "50308","cityDescription": "SAO PAULO"}}}}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil                
                oHelper:lOk := oRet['code'] == 'CRM004' .And. oRet['shortName'] == Nil
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_014
Put Cliente Inválido - GTSER-T30024

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_014() CLASS MATS030TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/ABCDEF01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/ABCDEF01')
    Else
        cBody := '{"shortName": "ALTERADO"},"type":1' 
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
/*/{Protheus.doc} MAT030_015
Put Cliente com Chave Menor que 8 caracteres - GTSER-T30024

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_015() CLASS MATS030TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/ABCDEF"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/ABCDEF')
    Else
        cBody := '{"shortName": "ALTERADO"},"type":1' 
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
/*/{Protheus.doc} MAT030_016
Put Json Inválido - GTSER-T30022

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_016() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/CRM00301"    
    Local oHelper	:= FWTestHelper():New()
    Local oRet      := Nil
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint customerVendor/customerVendor/1/CRM00301')
    Else
        cBody := '{"code": "","shortName": "","name": "","branchID": "","type":1}'
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
/*/{Protheus.doc} MAT030_017
Put Json Válido - GTSER-T30021

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_017() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/CRM00301"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/CRM00301')
    Else
        cBody := '{"shortName": "Alterado"},"type":1'
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
/*/{Protheus.doc} MAT030_018
Put Json Válido com Fields    - GTSER-T30035

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_018() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/CRM00401?fields=code"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/CRM00401?fields=code')
    Else
        cBody := '{"shortName": "Alterado"}'
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil                
                oHelper:lOk := oRet['code'] == 'CRM004' .And. oRet['shortName'] == Nil
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_019
Delete com cliente invalido - GTSER-T30028

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_019() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/ABCDEF01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/ABCDEF01')
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
/*/{Protheus.doc} MAT030_020
Delete Cliente com Chave Menor que 8 caracteres - GTSER-T30028

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_020() CLASS MATS030TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/ABCDEF"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/ABCDEF')
    Else
        cBody := '{"branchId": "D MG","code": "ABCDEF","storeId": "01","companyInternalId": "T1D MG    ABCDEF01"}'
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
/*/{Protheus.doc} MAT030_021
Delete com Json válido - GTSER-T30025

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_021() CLASS MATS030TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/CRM00301"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/CRM00301')
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
/*/{Protheus.doc} MAT030_022
Post de Cliente sem informar Codigo e Loja - GTSER-T30019

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_022() CLASS MATS030TestCase 

    Local aHeader   := {}
    Local cBody     := ""
    Local cCliente  := ""
    Local cLoja     := ""
    Local cQuery    := ""
    Local cRet      := ""
    Local cTable    := ""
    Local cURL      := "/customerVendor/customerVendor"    
    Local oHelper	:= FWTestHelper():New()
    Local oRet      := Nil
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor')
    Else
        cBody := '{"branchId": "D MG","registerSituation": "2",'
        cBody += '"type":1,"name": "CLIENTE POST PJ","shortName":"POST PJ","strategicCustomerType":"F","entityType": "J",'
	    cBody += '"marketsegment":{"marketSegmentCode": "000001"},"address":{"address": "RUA DO TESTE, 000","district": "TESTER",'
		cBody += '"zipCode": "00000000","country":{"countryCode": "105"},"state":{"stateId": "SP"},"city": {"cityCode": "50308",'
        cBody += '"cityDescription": "SAO PAULO"}},"GovernmentalInformation":[{"id": "40288485000185","name": "CPF|CNPJ"}],'        
        cBody += '"listOfContacts":[{"ContactInformationName": "TESTER","ContactInformationAddress": {'
        cBody += '"state": {},"city": {},"country": {}}}],"billingInformation":{"address": {"billingAddress": true,'
		cBody += '"address": "RUA DO TESTE, 000","district": "TESTER","zipCode": "00000000","country": {"countryCode": "105"},"state":{'
		cBody += '"stateId": "SP"},"city": {"cityCode": "50308","cityDescription": "SAO PAULO"}}}}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                cCliente := oRet['code']
                cLoja    := oRet['storeId']
                
                cTable  := "SA1"
                cQuery  := "A1_FILIAL = 'D MG    ' AND A1_COD = '" + cCliente + "' AND A1_LOJA = '" + cLoja + "' "
	
	            oHelper:UTQueryDB( cTable, "A1_COD"     ,cQuery, cCliente   )
                oHelper:UTQueryDB( cTable, "A1_LOJA"    ,cQuery, cLoja      )
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_023
Post de Cliente sem informar Codigo - GTSER-T30019

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_023() CLASS MATS030TestCase 

    Local aHeader   := {}
    Local cBody     := ""
    Local cCliente  := ""
    Local cQuery    := ""
    Local cRet      := ""
    Local cTable    := ""
    Local cURL      := "/customerVendor/customerVendor"    
    Local oHelper	:= FWTestHelper():New()
    Local oRet      := Nil
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor')
    Else
        cBody := '{"branchId": "D MG","registerSituation": "2","storeId": "01",'
        cBody += '"type":1,"name": "CLIENTE POST PJ","shortName":"POST PJ","strategicCustomerType":"F","entityType": "J",'
	    cBody += '"marketsegment":{"marketSegmentCode": "000001"},"address":{"address": "RUA DO TESTE, 000","district": "TESTER",'
		cBody += '"zipCode": "00000000","country":{"countryCode": "105"},"state":{"stateId": "SP"},"city": {"cityCode": "50308",'
        cBody += '"cityDescription": "SAO PAULO"}},"GovernmentalInformation":[{"id": "40288485000185","name": "CPF|CNPJ"}],'        
        cBody += '"listOfContacts":[{"ContactInformationName": "TESTER","ContactInformationAddress": {'
        cBody += '"state": {},"city": {},"country": {}}}],"billingInformation":{"address": {"billingAddress": true,'
		cBody += '"address": "RUA DO TESTE, 000","district": "TESTER","zipCode": "00000000","country": {"countryCode": "105"},"state":{'
		cBody += '"stateId": "SP"},"city": {"cityCode": "50308","cityDescription": "SAO PAULO"}}}}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                cCliente := oRet['code']                
                
                cTable  := "SA1"
                cQuery  := "A1_FILIAL = 'D MG    ' AND A1_COD = '" + cCliente + "' AND A1_LOJA = '01' "
	
	            oHelper:UTQueryDB( cTable, "A1_COD"     ,cQuery, cCliente   )
                oHelper:UTQueryDB( cTable, "A1_LOJA"    ,cQuery, '01'       )
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_024
Post de Cliente sem informar Loja - GTSER-T30019

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_024() CLASS MATS030TestCase 

    Local aHeader   := {}
    Local cBody     := ""
    Local cQuery    := ""
    Local cRet      := ""
    Local cTable    := ""
    Local cURL      := "/customerVendor/customerVendor"    
    Local oHelper	:= FWTestHelper():New()
    Local oRet      := Nil
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor')
    Else
        cBody := '{"branchId": "D MG","registerSituation": "2","code": "CRM005",'
        cBody += '"type":1,"name": "CLIENTE POST PJ","shortName":"POST PJ","strategicCustomerType":"F","entityType": "J",'
	    cBody += '"marketsegment":{"marketSegmentCode": "000001"},"address":{"address": "RUA DO TESTE, 000","district": "TESTER",'
		cBody += '"zipCode": "00000000","country":{"countryCode": "105"},"state":{"stateId": "SP"},"city": {"cityCode": "50308",'
        cBody += '"cityDescription": "SAO PAULO"}},"GovernmentalInformation":[{"id": "40288485000185","name": "CPF|CNPJ"}],'        
        cBody += '"listOfContacts":[{"ContactInformationName": "TESTER","ContactInformationAddress": {'
        cBody += '"state": {},"city": {},"country": {}}}],"billingInformation":{"address": {"billingAddress": true,'
		cBody += '"address": "RUA DO TESTE, 000","district": "TESTER","zipCode": "00000000","country": {"countryCode": "105"},"state":{'
		cBody += '"stateId": "SP"},"city": {"cityCode": "50308","cityDescription": "SAO PAULO"}}}}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil          
                
                cTable  := "SA1"
                cQuery  := "A1_FILIAL = 'D MG    ' AND A1_COD = 'CRM005' AND A1_LOJA = '01' "
	
	            oHelper:UTQueryDB( cTable, "A1_COD"     ,cQuery, "CRM005")                
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_025
Put Json com Code e StoredId Válido - GTSER-T30021

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_025() CLASS MATS030TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/CRM00501"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/CRM00501')
    Else
        cBody   := '{"code": "CRM005", "StoreId": "01","shortName": "Alterado","type":1}'
        cRet    := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet    := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['shortName'] <> Nil
                oHelper:lOk := AllTrim(oRet['shortName']) == 'Alterado'
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
    
Return oHelper


//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_026
Put Json com Code Válido - GTSER-T30021

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_026() CLASS MATS030TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/CRM00501"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/CRM00501')
    Else
        cBody   := '{"code": "CRM005", "shortName": "Alterado sem loja","type":1}'
        cRet    := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet    := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['shortName'] <> Nil
                oHelper:lOk := AllTrim(oRet['shortName']) == 'Alterado sem loja'
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
    
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_027
Put Json com StoredID Válido - GTSER-T30021

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_027() CLASS MATS030TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/CRM00501"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/CRM00501')
    Else
        cBody   := '{"StoreId": "01", "shortName": "Alterado sem Codigo","type":1}'
        cRet    := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet    := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['shortName'] <> Nil
                oHelper:lOk := AllTrim(oRet['shortName']) == 'Alterado sem Codigo'
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
    
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_028
Put Json Inválido - GTSER-T30021

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_028() CLASS MATS030TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/1/CRM00501"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/1/CRM00501')
    Else
        cBody   := '{"StoreId": "01", "shortName": "Alterado sem Codigo","type":1'
        cRet    := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet    := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['errorCode'] <> Nil
                oHelper:lOk := oRet['errorCode'] == 400
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
    
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_029
Put Json type 3 - GTSER-T30021

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_029() CLASS MATS030TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/3/CRM00501"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/3/CRM00501')
    Else
        cBody   := '{"StoreId": "01", "shortName": "Alterado sem Codigo","type":3}'
        cRet    := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet    := JsonObject():new()

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
/*/{Protheus.doc} MAT030_030
Put Json type invalido - GTSER-T30021

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_030() CLASS MATS030TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/5/CRM00501"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/5/CRM00501')
    Else
        cBody   := '{"StoreId": "01", "shortName": "Alterado sem Codigo","type":5}'
        cRet    := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet    := JsonObject():new()

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
/*/{Protheus.doc} MAT030_031
Get com Type e Codigo incorreto - GTSER-T30015

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_031() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/5/XW100101"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/5/XW100101')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.
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
/*/{Protheus.doc} MAT030_032
Get com Type e Codigo incorreto - GTSER-T30015

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_032() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/5"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/5')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.
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
/*/{Protheus.doc} MAT030_033
Get com Codigo de Cliente e fornecedor incorreto - GTSER-T30015

@author     Squad CRM Faturamento
@since      06/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_033() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/customerVendor/customerVendor/?code=999999"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/?code=999999')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                ConOut('Erro ao carregar objeto Body')
                oHelper:lOk := .F.
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
/*/{Protheus.doc} MAT030_034
Post Json com Type 3 - GTSER-T30020

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_034() CLASS MATS030TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/3"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor')
    Else
        cBody := '{"code": "","shortName": "","name": "","branchID": "","type":3}'
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar Objeto Body')
            oHelper:lOk := .F.
        Else
            If oRet['errorCode'] <> Nil
                oHelper:lOk := oRet['errorCode'] == 400
            EndIf
        EndIf
    EndIf

    oHelper:AssertFalse(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_035
Post Json com Type invalido - GTSER-T30020

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_035() CLASS MATS030TestCase

    Local aHeader   := {}
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
        cBody := '{"code": "","shortName": "","name": "","branchID": "","type":5}'
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar Objeto Body')
            oHelper:lOk := .F.
        Else
            If oRet['errorCode'] <> Nil
                oHelper:lOk := oRet['errorCode'] == 400
            EndIf
        EndIf
    EndIf

    oHelper:AssertFalse(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT030_036
Delete com type 3 - GTSER-T30028

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_036() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/3/ABCDEF01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/3/ABCDEF01')
    Else
        cBody := '{"branchId": "D MG","code": "ABCDEF","storeId": "01","companyInternalId": "T1D MG    ABCDEF01"}'
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
/*/{Protheus.doc} MAT030_037
Delete com type invalido - GTSER-T30028

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT030_037() CLASS MATS030TestCase

    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/customerVendor/customerVendor/5/ABCDEF01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /customerVendor/customerVendor/5/ABCDEF01')
    Else
        cBody := '{"branchId": "D MG","code": "ABCDEF","storeId": "01","companyInternalId": "T1D MG    ABCDEF01"}'
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