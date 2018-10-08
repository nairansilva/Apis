#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATS020TestCase

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
@see        FWDefaultTestSuit , FWDefaultTestCase
/*/
//-------------------------------------------------------------------
CLASS MATS490TestCase from FWDefaultTestCase
	
DATA oHelper
METHOD SetUpClass()
METHOD MATS490TestCase() CONSTRUCTOR
METHOD MAT490_001()     //Get Lista Todos os Fornecedores
METHOD MAT490_002()     //Get com cParam correto 
METHOD MAT490_003()     //Get com cParam incorreto
METHOD MAT490_004()     //Get com filtro Page
METHOD MAT490_005()     //Get com filtro PageSize
METHOD MAT490_006()     //Get página 2
METHOD MAT490_007()     //Get com um fornecedor incorreto
METHOD MAT490_008()     //Post incorreto
METHOD MAT490_009()     //Post Ok
METHOD MAT490_010()     //Put Ok
METHOD MAT490_011()     //Post Json Inválido
METHOD MAT490_012()     //Post Json Válido
METHOD MAT490_013()     //Post Json Válido com Fields
METHOD MAT490_014()     //Put Fornecedor Inválido
METHOD MAT490_015()     //Put passando vendedor invalido
METHOD MAT490_016()     //Put passando vendedor invalido
METHOD MAT490_017()     //Post passando vendedor invalido
METHOD MAT490_018()     //Delete passando chave com mais de 1 registro
METHOD MAT490_019()     //Delete de registro inexiztente
METHOD MAT490_020()     //Delete de registro inexiztente

ENDCLASS
//-----------------------------------------------------------------
/*/{Protheus.doc} SetUpClass
Instancía os casos de teste

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0

/*/
//-----------------------------------------------------------------
METHOD SetUpClass() CLASS MATS490TestCase

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
METHOD MATS490TestCase() CLASS MATS490TestCase

_Super:FWDefaultTestSuite()

::AddTestMethod("MAT490_001",,"Get Lista Todas as comissões - GTSER-T30014")
::AddTestMethod("MAT490_002",,"Get lista comissão do vendedor 000001 - GTSER-T30038")
::AddTestMethod("MAT490_003",,"Get lista comissão do vendedor não cadastrado - GTSER-T30038")
::AddTestMethod("MAT490_004",,"Get Lista com chave inferior a quantidade de caractreres - GTSER-T30015")
::AddTestMethod("MAT490_005",,"Get Lista com chave correta de uma comissão - GTSER-T30015")//VENDEDOR/COMISSÃO
::AddTestMethod("MAT490_006",,"Get page=2 - GTSER-T30015")//Page
::AddTestMethod("MAT490_007",,"Get pageSize=2 - GTSER-T30015")//PageSize
::AddTestMethod("MAT490_008",,"Post Json Inválido - GTSER-T30047")//Post Json Inválido 
::AddTestMethod("MAT490_009",,"Post Json ok - GTSER-T30047")//Post Json OK 
::AddTestMethod("MAT490_010",,"Put Json ok - GTSER-T30047")//Post Json OK 
::AddTestMethod("MAT490_011",,"Put Json completo ok - GTSER-T30047")//Post Json completo OK 
::AddTestMethod("MAT490_012",,"Put Json error - GTSER-T30047")//Post Json error
::AddTestMethod("MAT490_013",,"Put Json error - GTSER-T30047")//Delete Json error
::AddTestMethod("MAT490_014",,"Put Json error - GTSER-T30047")//Delete Json error
::AddTestMethod("MAT490_015",,"Put Json error - GTSER-T30047")//Put vendedor invalido
::AddTestMethod("MAT490_016",,"Put Json error - GTSER-T30047")//get chave completa com mais de 1 item
::AddTestMethod("MAT490_017",,"Post Vendedor invalido- GTSER-T30047")//get chave completa com mais de 1 item
::AddTestMethod("MAT490_018",,"Delete mais de 1 registro na chave - GTSER-T30047")//Delete Json error
::AddTestMethod("MAT490_019",,"Delete registro inexistente - GTSER-T30047")//Delete Json error
::AddTestMethod("MAT490_020",,"GET  Vendedor e chave com mais de 1 registro")//Delete Json error
Return 
//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_001
Get Lista Todas as Comissões - GTSER-T30014

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_001() CLASS MATS490TestCase
	
Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()

oHelper:Activate()
aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge')
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
/*/{Protheus.doc} MAT490_002
Get comissão Vend 000001 - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_002() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/000001"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint SalesCharge/Fat/SalesCharge/000001')
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
                oHelper:lOk := oBody['items'][1]['SellerId'] == '000001'
            EndIf
        EndIf
    EndIf
EndIf

oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper
//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_003
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_003() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/WESZSD"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint SalesCharge/Fat/SalesCharge/WESZSD')
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
/*/{Protheus.doc} MAT490_004
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_004() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/000001/01"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint SalesCharge/Fat/SalesCharge/000001/01    01')
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
                oHelper:lOk := oBody['errorCode'] == 400
            EndIf
        EndIf
    EndIf
EndIf

oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper
//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_005
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_005() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/000001/FIR13301FIRFINR133"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge/000001/FIR13301FIRFINR133')
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
/*/{Protheus.doc} MAT490_005
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_006() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/?page=2"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge/?page=2')
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
/*/{Protheus.doc} MAT490_005
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_007() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/?PageSize=2"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/SalesCharge/?PageSize=2')
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
/*/{Protheus.doc} MAT490_008
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_008() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()
Local cRet          := ""

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge')
Else
    cBody := '{"code": "","shortName": "","name": "","branchID": ""}'
    cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    oBody := JsonObject():new()

    If oBody:fromJson(cRet) <> Nil
        ConOut('Erro ao carregar Objeto Body')          
    Else
        If oBody['errorCode'] <> Nil        
            oHelper:lOk := oBody['errorCode'] == 400
        EndIf
    EndIf
EndIf 

oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper
//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_009
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_009() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()
Local cRet          := ""

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge')
Else
    cBody := '{"companyId": "T1",'
    cBody +=  '"CompanyInternalId": "T1D MG 01 ",'
    cBody +=  '"branchID": "D MG 01 ",'
    cBody +=  '"SellerId": "FAT001",'
    cBody +=  '"accountReceivableDocumentNumber": "AUTOMACAO",'
    cBody +=  '"issueDate": "18/09/24",'
    cBody +=  '"accountReceivableDocumentTypeCode": "NF ",'
    cBody +=  '"customerVendorCode": "FIS001",'
    cBody +=  '"customerVendorStore": "01",'
    cBody +=  '"baseValue": 250,'
    cBody +=  '"salesChargePercentage": 10,'
    cBody +=  '"value": 25,'
    cBody +=  '"accountReceivableDocumentPrefix": "FIR",'
    cBody +=  '"internalId": "FIRFINR133   01000001",'
    cBody +=  '"sellerInternalId": "FAT001",'
    cBody +=  '	"customerVendorInternalId": "FIR13301",'
    cBody +=  '"accountReceivableDocumentParcel": "W",'
    cBody +=  '"currency": "01",'
    cBody +=  '"dueDate": "18/09/24"}'

    cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    oBody := JsonObject():new()

    If oBody:fromJson(cRet) <> Nil
        ConOut('Erro ao carregar objeto oBody')
        oHelper:lOk := .F.
    Else
        If oBody['SellerId'] <> Nil
            oHelper:lOk := oBody['SellerId'] == 'FAT001'// .And. oBody['accountReceivableDocumentNumber'] == 'AUTOMACAO'
        EndIf
    EndIf
EndIf 

oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper 
//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_009
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_010() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/FAT001/FIS00101FIRAUTOMACAOWNF"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()
Local cRet          := ""

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge/FAT001/FIS00101FIRAUTOMACAOWNF')
Else
    cBody :=  '{"salesChargePercentage": 20}'
    cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    oBody := JsonObject():new()

    If oBody:fromJson(cRet) <> Nil
        ConOut('Erro ao carregar objeto oBody')
        oHelper:lOk := .F.
    Else
        If oBody['salesChargePercentage'] <> Nil
            oHelper:lOk := oBody['salesChargePercentage'] == 20
        Else
            oHelper:lOk := .F.                
        EndIf
    EndIf
EndIf 

oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper 
//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_009
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_011() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/000001/FIR13301FIRFINR133   NF"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()
Local cRet          := ""

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge/000001/FIR13301FIRFINR133   NF')
Else
    cBody :=  '{"salesChargePercentage": 20,'
    cBody +=  '"value": 50}'
    cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    oBody := JsonObject():new()

    If oBody:fromJson(cRet) <> Nil
        ConOut('Erro ao carregar objeto oBody')
        oHelper:lOk := .F.
    Else
        If oBody['salesChargePercentage'] <> Nil
            oHelper:lOk := oBody['salesChargePercentage'] == 20
        EndIf
    EndIf
EndIf 

oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper 
//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_012
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_012() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/FAT001/FAT00101FIR"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()
Local cRet          := ""

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
     oHelper:lOk := .F.
Else
        cBody := '{"code": "","shortName": "","name": "","branchID": ""}'
    cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    oBody := JsonObject():new()

    If oBody:fromJson(cRet) <> Nil
            oHelper:lOk := .T.
    Else
        If oBody['errorCode'] <> Nil
            oHelper:lOk := oBody['errorCode'] == 400
        EndIf
    EndIf
EndIf 

oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper 
//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_012
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_013() CLASS MATS490TestCase
	
Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/FAT001/FAT00101FIR"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()
Local cRet          := ""

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/SalesCharge/FAT001/FAT00101FIR')
Else
        cBody := '{"code": "","shortName": "","name": "","branchID": ""}'
    cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    oBody := JsonObject():new()

    If oBody:fromJson(cRet) <> Nil
        oHelper:lOk := .T.
    Else
        If oBody['errorCode'] <> Nil
            oHelper:lOk := oBody['errorCode'] == 400
        EndIf
    EndIf
EndIf 

oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper 

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_012
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_014() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/FAT001/FIS00101FIRAUTOMACAOWNF"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()
Local cRet          := ""

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge/FAT001/FIS00101FIRAUTOMACAOWNF')
Else
    cBody := '{"companyId": "T1",'
    cBody +=  '"CompanyInternalId": "T1D MG 01 ",'
    cBody +=  '"branchID": "D MG 01 ",'
    cBody +=  '"SellerId": "FAT001",'
    cBody +=  '"accountReceivableDocumentNumber": "AUTOMACAO",'
    cBody +=  '"issueDate": "18/09/24",'
    cBody +=  '"accountReceivableDocumentTypeCode": "NF ",'
    cBody +=  '"customerVendorCode": "FIS001",'
    cBody +=  '"customerVendorStore": "01",'
    cBody +=  '"baseValue": 250,'
    cBody +=  '"salesChargePercentage": 10,'
    cBody +=  '"value": 25,'
    cBody +=  '"accountReceivableDocumentPrefix": "FIR",'
    cBody +=  '"internalId": "FIRFINR133   01000001",'
    cBody +=  '"sellerInternalId": "FAT001",'
    cBody +=  '	"customerVendorInternalId": "FIR13301",'
    cBody +=  '"currency": "01",'
    cBody +=  '"dueDate": "18/09/24"}'

    cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    oBody := JsonObject():new()
    
    If oBody:fromJson(cRet) <> Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
    Else
        If oBody['response'] <> Nil        
            oHelper:lOk := "Sucesso" $ oBody['response'] 
        EndIf
    EndIf
EndIf
oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper 
//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_016
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_015() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/FAT001/000001/FIR13301FIRFINR133  ANF"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()
Local cRet          := ""

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge/FAT001/000001/FIR13301FIRFINR133  ANF')
Else
    cBody :=  '{"SellerId": "rsfgfgd"}'
    cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    oBody := JsonObject():new()

    If oBody:fromJson(cRet) <> Nil
        ConOut('Erro ao carregar objeto oBody')
        oHelper:lOk := .F.
    Else
        If oBody['SellerId'] <> Nil
            oHelper:lOk := oBody['errorCode'] == 400
        EndIf
    EndIf
EndIf 

oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper 

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_004
Get comissão chave incompleta - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_016() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/000001/01"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint SalesCharge/Fat/SalesCharge/000001/01')
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
                oHelper:lOk := oBody['errorCode'] == 400
            EndIf
        EndIf
    EndIf
EndIf

oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_009
POST Vendedor invalido - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_017() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()
Local cRet          := ""

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge')
Else
    cBody := '{"companyId": "T1",'
    cBody +=  '"CompanyInternalId": "T1D MG 01 ",'
    cBody +=  '"branchID": "D MG 01 ",'
    cBody +=  '"SellerId": "XCDCXX",'
    cBody +=  '"accountReceivableDocumentNumber": "AUTOMACAO",'
    cBody +=  '"issueDate": "18/09/24",'
    cBody +=  '"accountReceivableDocumentTypeCode": "NF ",'
    cBody +=  '"customerVendorCode": "XCDCXX",'
    cBody +=  '"customerVendorStore": "01",'
    cBody +=  '"baseValue": 250,'
    cBody +=  '"salesChargePercentage": 10,'
    cBody +=  '"value": 25,'
    cBody +=  '"accountReceivableDocumentPrefix": "FIR",'
    cBody +=  '"internalId": "FIRFINR133   01000001",'
    cBody +=  '"sellerInternalId": "FAT001",'
    cBody +=  '	"customerVendorInternalId": "FIR13301",'
    cBody +=  '"accountReceivableDocumentParcel": "W",'
    cBody +=  '"currency": "01",'
    cBody +=  '"dueDate": "18/09/24"}'

    cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    oBody := JsonObject():new()

    If oBody:fromJson(cRet) <> Nil
        If Empty(cRet)
            oHelper:lOk := .T.
        Else
            ConOut('Erro ao carregar objeto oBody')
            oHelper:lOk := .F.
        EndIf    
    Else
        If oBody['errorCode'] <> Nil
            oHelper:lOk := oBody['errorCode'] == 400
        EndIf
    EndIf
EndIf 

oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper 


//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_018
Delete - Mais de 1 registro na chave passada - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_018() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/FIN006/FIN05101AURFIN070062"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()
Local cRet          := ""

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge/FIN006/FIN05101AURFIN070062')
Else
    cBody := '{"companyId": "T1",'
    cBody +=  '"CompanyInternalId": "T1D MG 01 ",'
    cBody +=  '"branchID": "D MG 01 ",'
    cBody +=  '"SellerId": "FIN006",'
    cBody +=  '"accountReceivableDocumentNumber": "FIN070062",'
    cBody +=  '"issueDate": "18/09/24",'
    cBody +=  '"customerVendorCode": "FIN051",'
    cBody +=  '"customerVendorStore": "01",'
    cBody +=  '"baseValue": 250,'
    cBody +=  '"salesChargePercentage": 10,'
    cBody +=  '"value": 25,'
    cBody +=  '"accountReceivableDocumentPrefix": "AUR",'
    cBody +=  '"internalId": "FIRFINR133   01000001",'
    cBody +=  '"sellerInternalId": "FIN006",'
    cBody +=  '	"customerVendorInternalId": "FIR13301",'
    cBody +=  '"currency": "01",'
    cBody +=  '"dueDate": "18/09/24"}'

    cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    oBody := JsonObject():new()
    
    If oBody:fromJson(cRet) <> Nil
        ConOut('Erro ao carregar objeto oBody')
        oHelper:lOk := .F.
    Else
        If oBody['errorCode'] <> Nil
            oHelper:lOk := oBody['errorCode'] == 404
        EndIf
    EndIf


EndIf
oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper 


//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_012
Get comissão Vendedor não cadastrado - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_019() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/FAT001/FIS00104AAA121212121"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()
Local cRet          := ""

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge/FAT001/FIS00104AAA121212121"')
Else
    cBody := '{"companyId": "T1",'
    cBody +=  '"CompanyInternalId": "T1D MG 01 ",'
    cBody +=  '"branchID": "D MG 01 ",'
    cBody +=  '"SellerId": "FAT001",'
    cBody +=  '"accountReceivableDocumentNumber": "121212121",'
    cBody +=  '"issueDate": "18/09/24",'
    cBody +=  '"customerVendorCode": "FIS001",'
    cBody +=  '"customerVendorStore": "04",'
    cBody +=  '"baseValue": 250,'
    cBody +=  '"salesChargePercentage": 10,'
    cBody +=  '"value": 25,'
    cBody +=  '"accountReceivableDocumentPrefix": "AAA",'
    cBody +=  '"internalId": "AAA12121212101000001",'
    cBody +=  '"sellerInternalId": "FAT001",'
    cBody +=  '	"customerVendorInternalId": "FIR13301",'
    cBody +=  '"currency": "01",'
    cBody +=  '"dueDate": "18/09/24"}'

    cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    oBody := JsonObject():new()
    
   If oBody:fromJson(cRet) <> Nil
        ConOut('Erro ao carregar objeto oBody')
        oHelper:lOk := .F.
    Else
        If oBody['errorCode'] <> Nil
            oHelper:lOk := oBody['errorCode'] == 404
        EndIf
    EndIf
EndIf
oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper 

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT490_020
Get comissão Vendedor e chave com mais de 1 registro - GTSER-T30038

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MAT490_020() CLASS MATS490TestCase

Local aHeader       := {}
Local cBody         := ''
Local cURL          := "/SalesCharge/Fat/SalesCharge/FIN001/00000101A  000010"
Local oBody         := Nil
Local oHelper	    := FWTestHelper():New()

oHelper:Activate()

aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

If !oHelper:UTSetAPI(cURL,"REST")
    ConOut( 'Erro ao Acessar o EndPoint /SalesCharge/Fat/SalesCharge/FIN001/00000101A  000010')
Else
    cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
    If Empty(cBody)
        ConOut('Get Não teve retorno')
    Else
        oBody := JsonObject():new()
        
        If oBody:fromJson(cBody) <> Nil
            ConOut('Erro ao carregar oBjeto Body')
        Else  
            oHelper:lOk := oBody['errorCode'] == 404
        EndIf    
    EndIf
EndIf

oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper
