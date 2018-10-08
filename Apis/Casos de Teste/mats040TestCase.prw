#INCLUDE "PROTHEUS.CH"

Class MATS040TestCase FROM FWDefaultTestCase
    DATA oHelper
    
    METHOD  SetUpClass()
    METHOD  MATS040TestCase() Constructor
    
    METHOD  MAT040_001()
    METHOD  MAT040_002()
    METHOD  MAT040_003()
    METHOD  MAT040_004()
    METHOD  MAT040_005()
    METHOD  MAT040_006()
    METHOD  MAT040_007()
    METHOD  MAT040_008()
    METHOD  MAT040_009()
    METHOD  MAT040_010()
    METHOD  MAT040_011()
    METHOD  MAT040_012()
    METHOD  MAT040_013()
    METHOD  MAT040_014()
    METHOD  MAT040_015()
    METHOD  MAT040_016()
    METHOD  MAT040_017()
    METHOD  MAT040_018()

 
EndClass

METHOD MATS040TestCase() Class MATS040TestCase
    _Super:FWDefaultTestSuite()

    Self:AddTestMethod("MAT040_001",,"Get Lista Todos os Vendedores - GTSER-T30014")
    Self:AddTestMethod("MAT040_002",,"Get com cParam correto        - GTSER-T30038")
    Self:AddTestMethod("MAT040_003",,"Get com cParam incorreto      - GTSER-T30015")
    Self:AddTestMethod("MAT040_004",,"Get com filtro Page           - GTSER-T30037")
    Self:AddTestMethod("MAT040_005",,"Get com filtro PageSize       - GTSER-T30036")
    Self:AddTestMethod("MAT040_006",,"Get com filtro Fields         - GTSER-T30031")
    Self:AddTestMethod("MAT040_007",,"Get com um vendedor incorreto - GTSER-T30017")
    Self:AddTestMethod("MAT040_008",,"Get com um vendedor específico- GTSER-T30016")
    Self:AddTestMethod("MAT040_009",,"Get com filtro Order          - GTSER-T30047")

    Self:AddTestMethod("MAT040_010",,"Post Json Inválido            - GTSER-T30020")
    Self:AddTestMethod("MAT040_011",,"Post Json Válido              - GTSER-T30019")
    Self:AddTestMethod("MAT040_018",,"Delete com Json válido        - GTSER-T30025")
    Self:AddTestMethod("MAT040_012",,"Post Json Válido com Fields   - GTSER-T30034")
 
    Self:AddTestMethod("MAT040_013",,"Put Vendedor Inválido         - GTSER-T30024")
    Self:AddTestMethod("MAT040_014",,"Put Json Inválido             - GTSER-T30022")
    Self:AddTestMethod("MAT040_015",,"Put Json Válido               - GTSER-T30021")
    Self:AddTestMethod("MAT040_016",,"Put Json Válido com Fields    - GTSER-T30035")

    Self:AddTestMethod("MAT040_017",,"Delete com vendedor inválido  - GTSER-T30028")
    Self:AddTestMethod("MAT040_018",,"Delete com Json válido        - GTSER-T30025")    
   
Return 

METHOD SetUpClass() CLASS MATS040TestCase
    Local oHelper		:= FWTestHelper():New()
    Static aRetAuto := {}

Return oHelper

//Get Lista Todos os Vendedores - GTSER-T30014
METHOD MAT040_001() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Seller/Sellers"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers')
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.
            Else  
                oHelper:lOk := oBody['errorCode'] == Nil  
               
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com cParam correto - GTSER-T30038
METHOD MAT040_002() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Seller/Sellers?code=000001"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers?code=000001')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.                
            Else
                If oBody['Seller'] <> Nil
                    oHelper:lOk := oBody['Seller'][1]['code'] == '000001'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com cParam incorreto - GTSER-T30015
METHOD MAT040_003() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Seller/Sellers?code=12121X"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers?code=12121X')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
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

//Get com filtro Page - GTSER-T30037
METHOD MAT040_004() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Seller/Sellers?Page=3"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers?Page=3')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.                
            Else
                If oBody['Seller'] <> Nil        
                    oHelper:lOk := oBody['Seller'][1]['code'] == 'FIN021'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com filtro PageSize - GTSER-T30036
METHOD MAT040_005() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Seller/Sellers?PageSize=2"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers?PageSize=2')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.                
            Else
                If oBody['Seller'] <> Nil        
                    oHelper:lOk := Len(oBody['Seller']) <= 2
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com filtro Fields - GTSER-T30031
METHOD MAT040_006() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Seller/Sellers?fields=shortName"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers?fields=shortName')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.                
            Else
                If oBody['Seller'] <> Nil        
                    oHelper:lOk := oBody['Seller'][1]['code'] == Nil .And. oBody['Seller'][1]['shortName'] != Nil
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com um vendedor incorreto - GTSER-T30017
METHOD MAT040_007() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Seller/Sellers/ABCDEZ"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers/ABCDEZ')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
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

//Get com um vendedor específico - GTSER-T30016
METHOD MAT040_008() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Seller/Sellers/000001"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers/000001')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.                
            Else
                If oBody['Seller'] <> Nil
                    oHelper:lOk := oBody['code'] == '000001'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com filtro Order          - GTSER-T30047
METHOD MAT040_009() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cNome         := ""
    Local cQuery        := ""
    Local cTemp     	:= GetNextAlias()
    Local cURL          := "/Seller/Sellers?Order=name"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    cQuery := "SELECT TOP 1 A3_NOME FROM " + RetSqlName("SA3") + " WHERE A3_FILIAL = '" + xFilial("SA3") + "' AND D_E_L_E_T_ = ' ' Order By A3_NOME"
	cQuery := ChangeQuery(cQuery)
	MPSysOpenQuery( cQuery, cTemp )

    cNome   := (cTemp)->A3_NOME

    (cTemp)->(DbCloseArea())

    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers?Order=name')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar oBjeto Body')
                oHelper:lOk := .F.                
            Else
                If oBody['Seller'] <> Nil
                    oHelper:lOk := oBody['name'] == cNome
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Post Json Inválido - GTSER-T30020
METHOD MAT040_010() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Seller/Sellers"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers')
    Else
        cBody := '{"code": "","shortName": "","name": "","sellerEmail": "","sellerPassWord": "","branchID": ""}'
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                oHelper:lOk := .T.
        Else
            oHelper:lOk := .F.
        EndIf
    EndIf 

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Post Json Válido- GTSER-T30019
METHOD MAT040_011() CLASS MATS040TestCase 
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Seller/Sellers"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers')
    Else
        cBody := '{"code": "MATS02","shortName": "Vendedor MATS02",'
        cBody += '"name": "MATS02","sellerEmail": "teste@teste","sellerPassWord": "1234@","branchID": ""}' 
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                oHelper:lOk := .F.
        Else
            If oRet['code'] == "MATS02"
                oHelper:lOk := .T.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Post Json Válido com Fields - GTSER-T30034
METHOD MAT040_012() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Seller/Sellers?fields=code"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers?fields=code')
    Else
        cBody := '{"code": "MATS02","shortName": "Vendedor MATS02",'
        cBody += '"name": "MATS02","sellerEmail": "teste@teste","sellerPassWord": "1234@","branchID": ""}' 
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            oHelper:lOk := oRet['code'] != Nil .And. oRet['shortName'] == Nil
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Put Vendedor Inválido         - GTSER-T30024
METHOD MAT040_013() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Seller/Sellers/ABCDEF"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers/ABCDEF')
    Else
        cBody := '{"code": "MATS02","shortName": "Vendedor MATS02",'
        cBody += '"name": "MATS02","sellerEmail": "teste@teste","sellerPassWord": "1234@","branchID": ""}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
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

//Put Json Inválido             - GTSER-T30022
METHOD MAT040_014() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Seller/Sellers/000001"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers/000001')
    Else
        cBody := '{"code": "","shortName": "","name": "","sellerEmail": "","sellerPassWord": "","branchID": ""}'
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                oHelper:lOk := .T.
                //ConOut('Erro ao carregar objeto oRet')
        Else
            If oRet['errorCode'] <> Nil        
                oHelper:lOk := oRet['errorCode'] == 400
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper



//Put Json Válido               - GTSER-T30021
METHOD MAT040_015() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Seller/Sellers/MATS02"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers/MATS02')
    Else
        cBody := '{"code": "MATS02","shortName": "Alterado","name": "MATS02","sellerEmail": "teste@teste","sellerPassWord": "1234@","branchID": ""}'
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            oHelper:lOk := AllTrim(oRet['shortName']) == 'Alterado'
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Put Json Válido com Fields    - GTSER-T30035
METHOD MAT040_016() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Seller/Sellers/MATS02?fields=code"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers/MATS02?fields=code"')
    Else
        cBody := '{"code": "MATS02","shortName": "Alterado","name": "MATS02","sellerEmail": "teste@teste","sellerPassWord": "1234@","branchID": ""}'
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            oHelper:lOk := oRet['code'] != Nil .And. oRet['shortName'] == Nil
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Delete com vendedor inválido  - GTSER-T30028
METHOD MAT040_017() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Seller/Sellers/ABCDEF"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers/ABCDEF')
    Else
        cBody := '{"code": "ABCDEF","shortName": "Vendedor MATS02",'
        cBody += '"name": "MATS02","sellerEmail": "teste@teste","sellerPassWord": "1234@","branchID": ""}' 
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
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

//Delete com Json válido        - GTSER-T30025
METHOD MAT040_018() CLASS MATS040TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Seller/Sellers/MATS02"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers/MATS02')
    Else
        cBody := '{"code": "MATS02"}'
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
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