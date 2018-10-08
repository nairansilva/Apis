#INCLUDE "PROTHEUS.CH"

Class CRMS320TestCase FROM FWDefaultTestCase
    DATA oHelper
    
    METHOD  SetUpClass()
    METHOD  CRMS320TestCase() Constructor
    
    METHOD  CRM320_001()
    METHOD  CRM320_002()
    METHOD  CRM320_003()
    METHOD  CRM320_004()
    METHOD  CRM320_005()
    METHOD  CRM320_006()
    METHOD  CRM320_007()
    METHOD  CRM320_008()
    METHOD  CRM320_009()
    METHOD  CRM320_010()
    METHOD  CRM320_011()
    METHOD  CRM320_012()
    METHOD  CRM320_013()
    METHOD  CRM320_014()
    METHOD  CRM320_015()
    METHOD  CRM320_016()
    METHOD  CRM320_017()

 
EndClass

METHOD CRMS320TestCase() Class CRMS320TestCase
    _Super:FWDefaultTestSuite()

    Self:AddTestMethod("CRM320_001",,"Get Lista Todos os Suspects - Montar Kanoah")
    Self:AddTestMethod("CRM320_002",,"Get com cParam correto        - Montar Kanoah")
    Self:AddTestMethod("CRM320_003",,"Get com cParam incorreto      - Montar Kanoah")
    Self:AddTestMethod("CRM320_004",,"Get com filtro Page           - Montar Kanoah")
    Self:AddTestMethod("CRM320_005",,"Get com filtro PageSize       - Montar Kanoah")
    Self:AddTestMethod("CRM320_006",,"Get com filtro Fields         - Montar Kanoah")
    Self:AddTestMethod("CRM320_007",,"Get com um Suspect incorreto - Montar Kanoah")
    Self:AddTestMethod("CRM320_008",,"Get com um Suspect específico- Montar Kanoah")

    Self:AddTestMethod("CRM320_009",,"Post Json Inválido            - Montar Kanoah")
    Self:AddTestMethod("CRM320_010",,"Post Json Válido              - Montar Kanoah")
    Self:AddTestMethod("CRM320_017",,"Delete com Json válido        - Montar Kanoah")
    Self:AddTestMethod("CRM320_011",,"Post Json Válido com Fields   - Montar Kanoah")
 
    Self:AddTestMethod("CRM320_012",,"Put Suspect Inválido         - Montar Kanoah")
    Self:AddTestMethod("CRM320_013",,"Put Json Inválido             - Montar Kanoah")
    Self:AddTestMethod("CRM320_014",,"Put Json Válido               - Montar Kanoah")
    Self:AddTestMethod("CRM320_015",,"Put Json Válido com Fields    - Montar Kanoah")

    Self:AddTestMethod("CRM320_016",,"Delete com Suspect inválido  - Montar Kanoah")
    Self:AddTestMethod("CRM320_017",,"Delete com Json válido        - Montar Kanoah")    
   
Return 

METHOD SetUpClass() CLASS CRMS320TestCase
    Local oHelper		:= FWTestHelper():New()
    Static aRetAuto := {}

Return oHelper

//Get Lista Todos os Suspects - Montar Kanoah
METHOD CRM320_001() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Suspects/crm/Suspects"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects')
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
METHOD CRM320_002() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Suspects/crm/Suspects?Code=00000101"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects?code=00000101')
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
METHOD CRM320_003() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Suspects/crm/Suspects?Code=12121X"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects?Code=12121X')
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
METHOD CRM320_004() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Suspects/crm/Suspects?Page=3"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects?Page=3')
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
METHOD CRM320_005() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Suspects/crm/Suspects?PageSize=2"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects?PageSize=2')
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
METHOD CRM320_006() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Suspects/crm/Suspects?fields=ShortName"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects?fields=ShortName')
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

//Get com um Suspect incorreto - Montar Kanoah
METHOD CRM320_007() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Suspects/crm/Suspects/ABCDEZ"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects/ABCDEZ')
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

//Get com um Suspect específico - Montar Kanoah
METHOD CRM320_008() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/Suspects/crm/Suspects/00000101"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects/00000101')
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
METHOD CRM320_009() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Suspects/crm/Suspects"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects')
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
METHOD CRM320_010() CLASS CRMS320TestCase 
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Suspects/crm/Suspects"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects')
    Else
        cBody := '{"CompanyInfo": {"Annualbilling": 0,"Employees": "1","CNAE": "         "},"Name": "654","StrategicType": "1","GovernmentalInformation": [{"scope": null,"id": "53048363000163","expireOn": null,"name": "CPF/CNPJ",'
        cBody += '"issueOn": null}],"ShortName": "0000","StoreId": "01","InternalInformation": {"VendorTypeCode": "000001","Reserv": "2"    },"marketsegment": {"marketSegmentCode": "      ","marketSegmentDescription": null,'
        cBody += '"marketSegmentInternalId": null    },"CompanyId": "99","CompanyInternalId": "99  00000101","address": {"district": "                                        ","poBox": null,"state": {"stateInternalId": "  ",'
        cBody += '"stateDescription": null,"stateId": "  "        },"billingAddress": false,"zipCode": "        ","mainAddress": true,"complement": null,"region": "      ","shippingAddress": false,"address": "",'
        cBody += '"country": {"countryInternalId": "   ","countryDescription": null,"countryCode": "   "},"number": null,"city": {"cityCode": "     ","cityDescription": "teste","cityInternalId": "     "}},'
        cBody += '"RegisterSituation": "2","SuspectSituation": "1","EntityType": "1", "Code":"CRM99Z", "Origin": "11"}'

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
METHOD CRM320_011() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Suspects/crm/Suspects?fields=Code"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects?fields=Code')
    Else
        cBody := '{"CompanyInfo": {"Annualbilling": 0,"Employees": "1","CNAE": "         "},"Name": "654","StrategicType": "1","GovernmentalInformation": [{"scope": null,"id": "53048363000163","expireOn": null,"name": "CPF/CNPJ",'
        cBody += '"issueOn": null}],"ShortName": "0000","StoreId": "01","InternalInformation": {"VendorTypeCode": "000001","Reserv": "2"    },"marketsegment": {"marketSegmentCode": "      ","marketSegmentDescription": null,'
        cBody += '"marketSegmentInternalId": null    },"CompanyId": "99","CompanyInternalId": "99  00000101","address": {"district": "                                        ","poBox": null,"state": {"stateInternalId": "  ",'
        cBody += '"stateDescription": null,"stateId": "  "        },"billingAddress": false,"zipCode": "        ","mainAddress": true,"complement": null,"region": "      ","shippingAddress": false,"address": "",'
        cBody += '"country": {"countryInternalId": "   ","countryDescription": null,"countryCode": "   "},"number": null,"city": {"cityCode": "     ","cityDescription": "teste","cityInternalId": "     "}},'
        cBody += '"RegisterSituation": "2","SuspectSituation": "1","EntityType": "1", "Code":"CRM99Z"}'
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

//Put Suspect Inválido         - Montar Kanoah
METHOD CRM320_012() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Suspects/crm/Suspects/ABCDEFZZ"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects/ABCDEF')
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
METHOD CRM320_013() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Suspects/crm/Suspects/CRM99Z01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects/CRM99Z01')
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
METHOD CRM320_014() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Suspects/crm/Suspects/CRM99Z01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects/MATS02')
    Else
        cBody := '{"CompanyInfo": {"Annualbilling": 0,"Employees": "1","CNAE": "         "},"Name": "654","StrategicType": "1","GovernmentalInformation": [{"scope": null,"id": "53048363000163","expireOn": null,"name": "CPF/CNPJ",'
        cBody += '"issueOn": null}],"ShortName": "Alterado","StoreId": "01","InternalInformation": {"VendorTypeCode": "000001","Reserv": "2"    },"marketsegment": {"marketSegmentCode": "      ","marketSegmentDescription": null,'
        cBody += '"marketSegmentInternalId": null    },"CompanyId": "99","CompanyInternalId": "99  00000101","address": {"district": "                                        ","poBox": null,"state": {"stateInternalId": "  ",'
        cBody += '"stateDescription": null,"stateId": "  "        },"billingAddress": false,"zipCode": "        ","mainAddress": true,"complement": null,"region": "      ","shippingAddress": false,"address": "",'
        cBody += '"country": {"countryInternalId": "   ","countryDescription": null,"countryCode": "   "},"number": null,"city": {"cityCode": "     ","cityDescription": "teste","cityInternalId": "     "}},'
        cBody += '"RegisterSituation": "2","SuspectSituation": "1","EntityType": "1", "Code":"CRM99Z"}'

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
METHOD CRM320_015() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Suspects/crm/Suspects/CRM99Z01?fields=Code"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects/MATS02?fields=code"')
    Else
        cBody := '{"CompanyInfo": {"Annualbilling": 0,"Employees": "1","CNAE": "         "},"Name": "654","StrategicType": "1","GovernmentalInformation": [{"scope": null,"id": "53048363000163","expireOn": null,"name": "CPF/CNPJ",'
        cBody += '"issueOn": null}],"ShortName": "Alterado","StoreId": "01","InternalInformation": {"VendorTypeCode": "000001","Reserv": "2"    },"marketsegment": {"marketSegmentCode": "      ","marketSegmentDescription": null,'
        cBody += '"marketSegmentInternalId": null    },"CompanyId": "99","CompanyInternalId": "99  00000101","address": {"district": "                                        ","poBox": null,"state": {"stateInternalId": "  ",'
        cBody += '"stateDescription": null,"stateId": "  "        },"billingAddress": false,"zipCode": "        ","mainAddress": true,"complement": null,"region": "      ","shippingAddress": false,"address": "",'
        cBody += '"country": {"countryInternalId": "   ","countryDescription": null,"countryCode": "   "},"number": null,"city": {"cityCode": "     ","cityDescription": "teste","cityInternalId": "     "}},'
        cBody += '"RegisterSituation": "2","SuspectSituation": "1","EntityType": "1", "Code":"CRM99Z"}'

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

//Delete com Suspect inválido  - Montar Kanoah
METHOD CRM320_016() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Suspects/crm/Suspects/ABCDEFZZ"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects/ABCDEF')
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
METHOD CRM320_017() CLASS CRMS320TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/Suspects/crm/Suspects/CRM99Z01"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Suspects/crm/Suspects/MATS02')
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