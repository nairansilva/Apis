#INCLUDE "PROTHEUS.CH"

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRMS610TestCase
Lista de metodos do teste

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
Class CRMS610TestCase FROM FWDefaultTestCase
    DATA oHelper
    
    METHOD  SetUpClass()
    METHOD  CRMS610TestCase() Constructor
    
    METHOD  CRM610_001() //Get genérico 200
    METHOD  CRM610_002()//Get Id 200
    METHOD  CRM610_003() //Get Id 404
    METHOD  CRM610_004() //Post 200
    METHOD  CRM610_005() //Post 200
    METHOD  CRM610_006() //Put 200
    METHOD  CRM610_007()//Put 200
    METHOD  CRM610_008()//PUT 404
    METHOD  CRM610_009()//Post 400
    METHOD  CRM610_010()//Delete 200
    METHOD  CRM610_011()//Delete 400
    METHOD  CRM610_012()//Delete 404
    METHOD  CRM610_013()//Delete 200 - exclui o ultimo segmento retornado a base ao estado inicial
    METHOD  CRM610_014()//Procura um registro que não existe na base - Montar Kanoah 
    METHOD  CRM610_015()//Post Inválido - Montar Kanoah
    METHOD  CRM610_016()//Get específico inválido - Montar Kanoah
    METHOD  CRM610_017()//Get específico válido - Montar Kanoah
EndClass

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRMS610TestCase
Carrega os metodos e sua descrição

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRMS610TestCase() Class CRMS610TestCase
    _Super:FWDefaultTestSuite()
    Self:AddTestMethod("CRM610_001",,"Get 200")
    Self:AddTestMethod("CRM610_002",,"Get 200")    //Id = 000001
    Self:AddTestMethod("CRM610_003",,"Get 404")    //id = XXXXXX
    Self:AddTestMethod("CRM610_004",,"Post 200")   // CRMS01
    Self:AddTestMethod("CRM610_005",,"Post 200")   //CRMS02
    Self:AddTestMethod("CRM610_006",,"PUT 200")    //CRMS02
    Self:AddTestMethod("CRM610_007",,"PUT 200")    //CRMS01
    Self:AddTestMethod("CRM610_008",,"PUT 404")    //ID = XXXXXXX 
    Self:AddTestMethod("CRM610_009",,"Post 400")   //Body errado
    Self:AddTestMethod("CRM610_010",,"DELETE 200") //CRMS02 Deletado 
    Self:AddTestMethod("CRM610_011",,"DELETE 400") //Body Errado
    Self:AddTestMethod("CRM610_012",,"DELETE 404") //ID = XXXXXX  
    Self:AddTestMethod("CRM610_013",,"DELETE 200") //CRMS01 Deletado
    Self:AddTestMethod("CRM610_014",,"Outros") //Procura um registro que não existe na base - Montar Kanoah 
    Self:AddTestMethod("CRM610_015",,"DELETE 200") //Post Inválido - Montar Kanoah
    Self:AddTestMethod("CRM610_016",,"Get 404") //Get específico inválido - Montar Kanoah
    Self:AddTestMethod("CRM610_017",,"GET 200") //Get específico válido - Montar Kanoah
    
Return 

//------------------------------------------------------------------------------
/*/{Protheus.doc} SetUpClass
Instancia o oHelper

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD SetUpClass() CLASS CRMS610TestCase
    Local oHelper		:= FWTestHelper():New()
    Static _cPwBase64   := ''
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_001
Caso 1 - Get sem parametros, retornando a página 1

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_001() CLASS CRMS610TestCase
    Local oHelper   := FWTestHelper():New()
    Local aHeader   := { "Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cURL      := "/MarketSegments/marketSegment"
    Local oBody     := Nil
    
    oHelper:Activate()
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
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

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_002
Caso 2 - Get passando o ID '000001'

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_002() CLASS CRMS610TestCase
    Local oHelper   := FWTestHelper():New()
    Local aHeader   := { "Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cURL      := "/MarketSegments/marketSegment?marketSegmentID=000001"
    Local oBody     := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar Objeto Body')
                oHelper:lOk := .F.
            Else
                If oBody['marketSegment'] <> Nil
                    oHelper:lOk := oBody['marketSegment'][1]['marketSegmentID'] == '000001'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_003
Caso 3 - Get passando o ID 'CRMS01' que ainda não existe, gerando erro 404

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_003() CLASS CRMS610TestCase
    Local oHelper   := FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cURL      := "/MarketSegments/marketSegment?marketSegmentID=CRMS01"
    Local oBody     := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
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
                If oBody['errorCode'] <> Nil        
                    oHelper:lOk := oBody['errorCode'] == 404
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_004
Caso 4 - POST Inclui o segmento 'CRMS01'

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_004() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/MarketSegments/marketSegment"
    Local oRet      := Nil
    
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := '{"parentMarketSegment": "","marketSegmentDescription": "Segmento CRMS01",'
        cBody += '"mainMarketSegment": "1","parentMarketSegmentDescription": null,"marketSegmentID": "CRMS01","branchID": ""}' 
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F. 
        Else
            If oRet['marketSegment'] <> Nil
                oHelper:lOk := oRet['marketSegmentID'] == 'CRMS01'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_005
Caso 5 - POST Inclui o segmento 'CRMS02' como filho do segmento CRMS01

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_005() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/MarketSegments/marketSegment"
    Local oRet      := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := '{"parentMarketSegment": "CRMS01","marketSegmentDescription": "Segmento CRMS02",'
        cBody += '"mainMarketSegment": "2","parentMarketSegmentDescription": null,"marketSegmentID": "CRMS02","branchID": ""}' 
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            oHelper:lOk := oRet['marketSegmentID'] == 'CRMS02'
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_006
Caso 6 - PUT Altera a descrição do segmento 'CRMS02'

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_006() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/MarketSegments/marketSegment/CRMS02"
    Local oRet      := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := '{"parentMarketSegment": "","marketSegmentDescription": "Segmento CRMS01 Alterado",'
        cBody += '"mainMarketSegment": "1","parentMarketSegmentDescription": null,"marketSegmentID": "CRMS01","branchID": ""}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['marketSegment'] <> Nil
                oHelper:lOk := Alltrim(oRet['marketSegmentDescription']) == 'Segmento CRMS01 Alterado'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_007
Caso 7 - DELETE Exclui o segmento 'CRMS02'   

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_007() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/MarketSegments/marketSegment/CRMS02"
    Local oRet      := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := '{"parentMarketSegment": "CRMS01","marketSegmentDescription": "Segmento CRMS02 Alterado",'
        cBody += '"mainMarketSegment": "2","parentMarketSegmentDescription": null,"marketSegmentID": "CRMS02","branchID": ""}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['marketSegment'] <> Nil
                oHelper:lOk := Alltrim(oRet['marketSegment'][1]['marketSegmentDescription']) == 'Segmento CRMS02 Alterado'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_008
Caso 8 - PUT 404   

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_008() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/MarketSegments/marketSegment/XXXXXXX"
    Local oRet      := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := '{"parentMarketSegment": "","marketSegmentDescription": "Segmento CRMS01",'
        cBody += '"mainMarketSegment": "1","parentMarketSegmentDescription": null,"marketSegmentID": "CRMS01","branchID": ""}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
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

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_008
Caso 9 - Post 400

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_009() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/MarketSegments/marketSegment"
    Local oRet      := Nil
    
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := '{"parentMarketSegment": "","marketSegmentDescription": "","mainMarketSegment": "","parentMarketSegmentDescription": null,"marketSegmentID": "","branchID": ""}'
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
            oHelper:lOk := .T.
        Else
            If oRet['errorCode'] <> Nil        
                    oHelper:lOk := oRet['errorCode'] == 400
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_010
Caso 10 - DELETE Exclui o segmento 'CRMS02'   

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_010() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/MarketSegments/marketSegment/CRMS02"
    Local oRet      := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := '{"parentMarketSegment": "CRMS01","marketSegmentDescription": "Segmento CRMS02 Alterado",'
        cBody += '"mainMarketSegment": "1","parentMarketSegmentDescription": null,"marketSegmentID": "CRMS02","branchID": ""}' 
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            oHelper:lOk := oRet['errorCode'] == Nil
            
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper
//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_010
Caso 11 - DELETE 400   

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_011() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/MarketSegments/marketSegment/CRMS01"
    Local oRet      := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := '{"parentMarketSegment": "","marketSegmentDescription": "",'
        cBody += '"mainMarketSegment": "","parentMarketSegmentDescription": null,"marketSegmentID": "","branchID": ""}' 
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
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

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_012
Caso 12 - DELETE 404

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_012() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/MarketSegments/marketSegment/XXXXXXXXXX"
    Local oRet      := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := '{"parentMarketSegment": "","marketSegmentDescription": "Segmento CRMS01 Alterado",'
        cBody += '"mainMarketSegment": "1","parentMarketSegmentDescription": null,"marketSegmentID": "CRMS01","branchID": ""}' 
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

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_013
Caso 13 - DELETE 200

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_013() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/MarketSegments/marketSegment/CRMS01"
    Local oRet      := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := '{"parentMarketSegment": "","marketSegmentDescription": "Segmento CRMS01 Alterado",'
        cBody += '"mainMarketSegment": "1","parentMarketSegmentDescription": null,"marketSegmentID": "CRMS01","branchID": ""}' 
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            oHelper:lOk := oRet['errorCode'] == Nil 
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_014
Procura um registro que não existe na base - Montar Kanoah 

@author		Nairan Alves Silva
@since		05/09/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_014() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    oHelper:lOk := StaticCall(crms610, FindMyAAOV ) 

    oHelper:AssertFalse( oHelper:lOk, "" )
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_004
Caso 15 - Post Inválido

@author		Nairan Alves Silva
@since		05/09/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_015() CLASS CRMS610TestCase
    Local oHelper	:= FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/MarketSegments/marketSegment"
    Local oRet      := Nil
    
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint MarketSegments/marketSegment')
        oHelper:lOk := .F.
    Else
        cBody := '{"parentMarketSegment": "",'
        cBody += '"mainMarketSegment": "9Z9965","parentMarketSegmentDescription": null,"branchID": ""}' 
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .T.
        Else
            oHelper:lOk := .F.
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_016
Caso 3 - Get passando o ID 'CRMS01' que ainda não existe, gerando erro 404

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_016() CLASS CRMS610TestCase
    Local oHelper   := FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cURL      := "/MarketSegments/marketSegment/ZVSGRE"
    Local oBody     := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /MarketSegments/marketSegment/ZVSGRE')
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If "404" $ cBody
            oHelper:lOk := .T.
        Else
            oHelper:lOk := .F.
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRM610_016
Caso 3 - Get passando o ID 'CRMS01' que ainda não existe, gerando erro 404

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRM610_017() CLASS CRMS610TestCase
    Local oHelper   := FWTestHelper():New()
    Local aHeader   :=  {"Content-Type: application/json","Authorization: Basic " + oHelper:UtSetAuthorization('ADMIN','1') }
    Local cBody     := ''
    Local cURL      := "/MarketSegments/marketSegment/000001"
    Local oBody     := Nil
   
    oHelper:Activate()

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint /MarketSegments/marketSegment/ZVSGRE')
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                oHelper:lOk := .F.
            Else
                oHelper:lOk := oBody['marketSegmentID'] == '000001'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper