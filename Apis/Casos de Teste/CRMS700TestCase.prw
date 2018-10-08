#INCLUDE "PROTHEUS.CH"

Class CRMS700TestCase FROM FWDefaultTestCase
    DATA oHelper
    
    METHOD  SetUpClass()
    METHOD  CRMS700TestCase() Constructor
    
    METHOD  CRM700_001()
    METHOD  CRM700_002()
    METHOD  CRM700_003()
    METHOD  CRM700_004()
    METHOD  CRM700_005()
    METHOD  CRM700_006()
    METHOD  CRM700_007()
    METHOD  CRM700_008()
    METHOD  CRM700_009()
    METHOD  CRM700_010()
    METHOD  CRM700_011()
    METHOD  CRM700_012()
    METHOD  CRM700_013()
    METHOD  CRM700_014()
    METHOD  CRM700_015()
    METHOD  CRM700_016()
    METHOD  CRM700_017()

 
EndClass

METHOD CRMS700TestCase() Class CRMS700TestCase
    _Super:FWDefaultTestSuite()

    Self:AddTestMethod("CRM700_001",,"Get Lista Todos os Prospects - Montar Kanoah")
    Self:AddTestMethod("CRM700_002",,"Get com cParam correto        - Montar Kanoah")
    Self:AddTestMethod("CRM700_003",,"Get com cParam incorreto      - Montar Kanoah")
    Self:AddTestMethod("CRM700_004",,"Get com filtro Page           - Montar Kanoah")
    Self:AddTestMethod("CRM700_005",,"Get com filtro PageSize       - Montar Kanoah")
    Self:AddTestMethod("CRM700_006",,"Get com filtro Fields         - Montar Kanoah")
    Self:AddTestMethod("CRM700_007",,"Get com um Prospect incorreto - Montar Kanoah")
    Self:AddTestMethod("CRM700_008",,"Get com um Prospect específico- Montar Kanoah")

    Self:AddTestMethod("CRM700_009",,"Post Json Inválido            - Montar Kanoah")
    Self:AddTestMethod("CRM700_010",,"Post Json Válido              - Montar Kanoah")
    Self:AddTestMethod("CRM700_017",,"Delete com Json válido        - Montar Kanoah")
    Self:AddTestMethod("CRM700_011",,"Post Json Válido com Fields   - Montar Kanoah")
 
    Self:AddTestMethod("CRM700_012",,"Put Prospect Inválido         - Montar Kanoah")
    Self:AddTestMethod("CRM700_013",,"Put Json Inválido             - Montar Kanoah")
    Self:AddTestMethod("CRM700_014",,"Put Json Válido               - Montar Kanoah")
    Self:AddTestMethod("CRM700_015",,"Put Json Válido com Fields    - Montar Kanoah")

    Self:AddTestMethod("CRM700_016",,"Delete com Prospect inválido  - Montar Kanoah")
    Self:AddTestMethod("CRM700_017",,"Delete com Json válido        - Montar Kanoah")    
   
Return 

METHOD SetUpClass() CLASS CRMS700TestCase
    Local oHelper		:= FWTestHelper():New()
    Static aRetAuto := {}

Return oHelper

//Get Lista Todos os Prospects - Montar Kanoah
METHOD CRM700_001() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Prospects/crm/Prospects"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects')
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
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com cParam correto - Montar Kanoah
METHOD CRM700_002() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Prospects/crm/Prospects?Code=00000101"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects?code=00000101')
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
                If oBody['items'] <> Nil
                    oHelper:lOk := oBody['items'][1]['Code'] == '000001'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com cParam incorreto - Montar Kanoah
METHOD CRM700_003() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Prospects/crm/Prospects?Code=12121X"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects?Code=12121X')
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

//Get com filtro Page - Montar Kanoah
METHOD CRM700_004() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Prospects/crm/Prospects?Page=3"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects?Page=3')
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
                If oBody['items'] <> Nil        
                    oHelper:lOk := oBody['items'][1]['Code'] == '000001'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com filtro PageSize - Montar Kanoah
METHOD CRM700_005() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Prospects/crm/Prospects?PageSize=2"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects?PageSize=2')
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
                If oBody['items'] <> Nil        
                    oHelper:lOk := Len(oBody['items']) <= 2
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com filtro Fields - Montar Kanoah
METHOD CRM700_006() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Prospects/crm/Prospects?fields=ShortName"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects?fields=ShortName')
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
                If oBody['items'] <> Nil        
                    oHelper:lOk := oBody['items'][1]['code'] == Nil .And. oBody['items'][1]['ShortName'] != Nil
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com um Prospect incorreto - Montar Kanoah
METHOD CRM700_007() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Prospects/crm/Prospects/ABCDEZ"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects/ABCDEZ')
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
                    oHelper:lOk := oBody['errorCode'] == 400
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com um Prospect específico - Montar Kanoah
METHOD CRM700_008() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Prospects/crm/Prospects/00000101"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects/00000101')
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
                If oBody['Code'] <> Nil
                    oHelper:lOk := oBody['Code'] == '000001'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Post Json Inválido - Montar Kanoah
METHOD CRM700_009() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Prospects/crm/Prospects"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects')
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

//Post Json Válido- Montar Kanoah
METHOD CRM700_010() CLASS CRMS700TestCase 
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Prospects/crm/Prospects"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects')
    Else
        cBody := '{"CompanyInfo":{"CreditLimit":100,"Annualbilling":10,"CreditLimitCurrency":1,"Employees":"2","CreditLimitDate":"20180810","CNAE":"         "   },"code":"CRM99Z","Name":"TESTE bbb","StrategicType":"2","GovernmentalInformation":['
        cBody += '{"scope":null,"id":"686954262342","expireOn":null,"name":"INSCRICAO ESTADUAL","issueOn":null},{"scope":null,"id":"53048363000163","expireOn":null,"name":"CPF/CNPJ","issueOn":null},{"scope":null,"id":null,"expireOn":null,'
        cBody += '"name":"SUFRAMA","issueOn":null}],"StoreId":"01","ProspectSituation":"1","InternalInformation":{"VendorTypeCode":"000001","LastVisit":""},"marketsegment":{"marketSegmentCode":null,"marketSegmentDescription":null,"marketSegmentInternalId":null'
        cBody += '},"CompanyId":"99","CompanyInternalId":"99  CRM99Z01","address":{"district":"                                        ","poBox":null,"state":{"stateInternalId":"SP","stateDescription":null,"stateId":"SP"},"billingAddress":false,'
        cBody += '"zipCode":"13211100","mainAddress":true,"complement":"Teste","region":null,"shippingAddress":false,"address":"teste ","country":{  "countryInternalId":"105","countryDescription":"105","countryCode":"   "  },'
        cBody += '"number":null,"city":{  "cityCode":null,"cityDescription":"TESTE","cityInternalId":null}},"RegisterSituation":"2", "Origin": "11"}'        

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                oHelper:lOk := .F.
        Else
            If oRet['Code'] == "CRM99Z"
                oHelper:lOk := .T.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Post Json Válido com Fields - Montar Kanoah
METHOD CRM700_011() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Prospects/crm/Prospects?fields=Code"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects?fields=Code')
    Else
        cBody := '{"CompanyInfo":{"CreditLimit":100,"Annualbilling":10,"CreditLimitCurrency":1,"Employees":"2","CreditLimitDate":"20180810","CNAE":"         "   },"code":"CRM99Z","Name":"TESTE bbb","StrategicType":"2","GovernmentalInformation":['
        cBody += '{"scope":null,"id":"686954262342","expireOn":null,"name":"INSCRICAO ESTADUAL","issueOn":null},{"scope":null,"id":"53048363000163","expireOn":null,"name":"CPF/CNPJ","issueOn":null},{"scope":null,"id":null,"expireOn":null,'
        cBody += '"name":"SUFRAMA","issueOn":null}],"StoreId":"01","ProspectSituation":"1","InternalInformation":{"VendorTypeCode":"000001","LastVisit":""},"marketsegment":{"marketSegmentCode":null,"marketSegmentDescription":null,"marketSegmentInternalId":null'
        cBody += '},"CompanyId":"99","CompanyInternalId":"99  CRM99Z01","address":{"district":"                                        ","poBox":null,"state":{"stateInternalId":"SP","stateDescription":null,"stateId":"SP"},"billingAddress":false,'
        cBody += '"zipCode":"13211100","mainAddress":true,"complement":"Teste","region":null,"shippingAddress":false,"address":"teste ","country":{  "countryInternalId":"105","countryDescription":"105","countryCode":"   "  },'
        cBody += '"number":null,"city":{  "cityCode":null,"cityDescription":"TESTE","cityInternalId":null}},"RegisterSituation":"2"}'        
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            oHelper:lOk := oRet['Code'] != Nil .And. oRet['ShortName'] == Nil
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Put Prospect Inválido         - Montar Kanoah
METHOD CRM700_012() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Prospects/crm/Prospects/ABCDEFZZ"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects/ABCDEF')
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

//Put Json Inválido             - Montar Kanoah
METHOD CRM700_013() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Prospects/crm/Prospects/CRM99Z01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects/CRM99Z01')
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

//Put Json Válido               - Montar Kanoah
METHOD CRM700_014() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Prospects/crm/Prospects/CRM99Z01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects/MATS02')
    Else
        cBody := '{"CompanyInfo":{"CreditLimit":100,"Annualbilling":10,"CreditLimitCurrency":1,"Employees":"2","CreditLimitDate":"20180810","CNAE":"         "   },"code":"CRM99Z","Name":"TESTE AAA","ShortName": "Alterado","StrategicType":"2","GovernmentalInformation":['
        cBody += '{"scope":null,"id":"686954262342","expireOn":null,"name":"INSCRICAO ESTADUAL","issueOn":null},{"scope":null,"id":"53048363000163","expireOn":null,"name":"CPF/CNPJ","issueOn":null},{"scope":null,"id":null,"expireOn":null,'
        cBody += '"name":"SUFRAMA","issueOn":null}],"StoreId":"01","ProspectSituation":"1","InternalInformation":{"VendorTypeCode":"000001","LastVisit":""},"marketsegment":{"marketSegmentCode":null,"marketSegmentDescription":null,"marketSegmentInternalId":null'
        cBody += '},"CompanyId":"99","CompanyInternalId":"99  CRM99Z01","address":{"district":"                                        ","poBox":null,"state":{"stateInternalId":"SP","stateDescription":null,"stateId":"SP"},"billingAddress":false,'
        cBody += '"zipCode":"13211100","mainAddress":true,"complement":"Teste","region":null,"shippingAddress":false,"address":"teste ","country":{  "countryInternalId":"105","countryDescription":"105","countryCode":"   "  },'
        cBody += '"number":null,"city":{  "cityCode":null,"cityDescription":"TESTE","cityInternalId":null}},"RegisterSituation":"2"}'        

        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            oHelper:lOk := AllTrim(oRet['ShortName']) == 'Alterado'
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Put Json Válido com Fields    - Montar Kanoah
METHOD CRM700_015() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Prospects/crm/Prospects/CRM99Z01?fields=Code"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects/MATS02?fields=code"')
    Else
        cBody := '{"CompanyInfo":{"CreditLimit":100,"Annualbilling":10,"CreditLimitCurrency":1,"Employees":"2","CreditLimitDate":"20180810","CNAE":"         "   },"code":"CRM99Z","Name":"TESTE AAA","ShortName": "Alterado","StrategicType":"2","GovernmentalInformation":['
        cBody += '{"scope":null,"id":"686954262342","expireOn":null,"name":"INSCRICAO ESTADUAL","issueOn":null},{"scope":null,"id":"53048363000163","expireOn":null,"name":"CPF/CNPJ","issueOn":null},{"scope":null,"id":null,"expireOn":null,'
        cBody += '"name":"SUFRAMA","issueOn":null}],"StoreId":"01","ProspectSituation":"1","InternalInformation":{"VendorTypeCode":"000001","LastVisit":""},"marketsegment":{"marketSegmentCode":null,"marketSegmentDescription":null,"marketSegmentInternalId":null'
        cBody += '},"CompanyId":"99","CompanyInternalId":"99  CRM99Z01","address":{"district":"                                        ","poBox":null,"state":{"stateInternalId":"SP","stateDescription":null,"stateId":"SP"},"billingAddress":false,'
        cBody += '"zipCode":"13211100","mainAddress":true,"complement":"Teste","region":null,"shippingAddress":false,"address":"teste ","country":{  "countryInternalId":"105","countryDescription":"105","countryCode":"   "  },'
        cBody += '"number":null,"city":{  "cityCode":null,"cityDescription":"TESTE","cityInternalId":null}},"RegisterSituation":"2"}'        

        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            oHelper:lOk := oRet['Code'] != Nil .And. oRet['ShortName'] == Nil
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Delete com Prospect inválido  - Montar Kanoah
METHOD CRM700_016() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Prospects/crm/Prospects/ABCDEFZZ"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects/ABCDEF')
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

//Delete com Json válido        - Montar Kanoah
METHOD CRM700_017() CLASS CRMS700TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Prospects/crm/Prospects/CRM99Z01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Prospects/crm/Prospects/MATS02')
    Else
        cBody := '{"Code": "CRM99Z"}'
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