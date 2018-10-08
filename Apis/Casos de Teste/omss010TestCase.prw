#INCLUDE "PROTHEUS.CH"

Class OMSS010TestCase FROM FWDefaultTestCase
    DATA oHelper
    
    METHOD  SetUpClass()
    METHOD  OMSS010TestCase() Constructor
    
    METHOD  OMS010_001()
    METHOD  OMS010_002()
    METHOD  OMS010_003()
    METHOD  OMS010_004()
    METHOD  OMS010_005()
    METHOD  OMS010_006()
    METHOD  OMS010_007()
    METHOD  OMS010_008()
    METHOD  OMS010_009()
    METHOD  OMS010_010()
    METHOD  OMS010_011()
    METHOD  OMS010_012()
    METHOD  OMS010_013()
    METHOD  OMS010_014()
    METHOD  OMS010_015()
    METHOD  OMS010_016()
    METHOD  OMS010_017()
    METHOD  OMS010_018()
    METHOD  OMS010_019()
    METHOD  OMS010_020()
    METHOD  OMS010_021()
    METHOD  OMS010_022()
    METHOD  OMS010_023()
    METHOD  OMS010_024()
    METHOD  OMS010_025()
    METHOD  OMS010_026()
EndClass

METHOD OMSS010TestCase() Class OMSS010TestCase
    _Super:FWDefaultTestSuite()

    Self:AddTestMethod("OMS010_001",,"Get Lista Todas as tabelas    - GTSER-T30148")
    Self:AddTestMethod("OMS010_002",,"Get com cParam correto        - GTSER-T30144")
    Self:AddTestMethod("OMS010_003",,"Get com cParam incorreto      - GTSER-T30150")
    Self:AddTestMethod("OMS010_004",,"Get com filtro Page           - GTSER-T30146")
    Self:AddTestMethod("OMS010_005",,"Get com filtro PageSize       - GTSER-T30142")
    Self:AddTestMethod("OMS010_006",,"Get com filtro Fields         - GTSER-T30147")
    Self:AddTestMethod("OMS010_007",,"Get com uma tabela de preço incorreto - GTSER-T30149")
    Self:AddTestMethod("OMS010_008",,"Get com uma tabela de preço específico- GTSER-T30143")
    Self:AddTestMethod("OMS010_009",,"Get com filtro Order          - GTSER-T30145")

    Self:AddTestMethod("OMS010_010",,"Post Json Inválido            - GTSER-T30151")
    Self:AddTestMethod("OMS010_011",,"Post Json Válido              - GTSER-T30152")
    Self:AddTestMethod("OMS010_018",,"Delete com Json válido        - GTSER-T30141")
    Self:AddTestMethod("OMS010_012",,"Post Json Válido com Fields   - GTSER-T30153")
 
    Self:AddTestMethod("OMS010_013",,"Put tabela de preço Inválida  - GTSER-T30154")
    Self:AddTestMethod("OMS010_014",,"Put Json Inválido             - GTSER-T30155")
    Self:AddTestMethod("OMS010_015",,"Put Json Válido               - GTSER-T30156")
    Self:AddTestMethod("OMS010_016",,"Put Json Válido com Fields    - GTSER-T30157")

    Self:AddTestMethod("OMS010_017",,"Delete com tabela de preço inválida  - GTSER-T30140")
    
    Self:AddTestMethod("OMS010_019",,"Get Itens                     - GTSER-T30174")
    Self:AddTestMethod("OMS010_020",,"Post Json Válido              - GTSER-T30189")
    Self:AddTestMethod("OMS010_021",,"Post Json inválido            - GTSER-T30190")

    Self:AddTestMethod("OMS010_022",,"Get Item                      - GTSER-T30191")
    Self:AddTestMethod("OMS010_023",,"Put Json Inválido             - GTSER-T30192")
    Self:AddTestMethod("OMS010_024",,"Put Json válido               - GTSER-T30198")
    Self:AddTestMethod("OMS010_025",,"Delete Item                   - GTSER-T30199")
    Self:AddTestMethod("OMS010_026",,"Delete de um item incorreto   - GTSER-T30205")
        
    Self:AddTestMethod("OMS010_018",,"Delete com Json válido        - GTSER-T30141")    

Return 

METHOD SetUpClass() CLASS OMSS010TestCase
    Local oHelper		:= FWTestHelper():New()
    Static aRetAuto := {}

Return oHelper

//Get Lista Todas as tabelas    - GTSER-T30148
METHOD OMS010_001() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/PriceListHeaderItems/pricelist"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar oBjeto Body')
            Else  
                oHelper:lOk := oBody['errorCode'] == Nil  
               
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com cParam correto        - GTSER-T30144
METHOD OMS010_002() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/PriceListHeaderItems/pricelist?code=001"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist?code=001')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar Objeto Body')
            Else
                If oBody['PriceListHeaderItems'] <> Nil
                    oHelper:lOk := oBody['PriceListHeaderItems'][1]['code'] == '001'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com cParam incorreto      - GTSER-T30150
METHOD OMS010_003() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/PriceListHeaderItems/pricelist?code=ZZA"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist?code=ZZA')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
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

//Get com filtro Page           - GTSER-T30146
METHOD OMS010_004() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/PriceListHeaderItems/pricelist?Page=2&PageSize=1"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist?Page=2&PageSize=1')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar oBjeto Body')
            Else
                If oBody['PriceListHeaderItems'] <> Nil        
                    oHelper:lOk := oBody['PriceListHeaderItems'][1]['code'] == '002'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com filtro PageSize - GTSER-T30142
METHOD OMS010_005() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/PriceListHeaderItems/pricelist?PageSize=1"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist?PageSize=1')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar oBjeto Body')
            Else
                If oBody['PriceListHeaderItems'] <> Nil        
                    oHelper:lOk := Len(oBody['PriceListHeaderItems']) <= 1
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com filtro Fields         - GTSER-T30147
METHOD OMS010_006() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/PriceListHeaderItems/pricelist?Fields=code"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint riceListHeaderItems/pricelist?Fields=code')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar oBjeto Body')
            Else
                If oBody['PriceListHeaderItems'] <> Nil        
                    oHelper:lOk := oBody['PriceListHeaderItems'][1]['name'] == Nil .And. oBody['PriceListHeaderItems'][1]['code'] != Nil
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com uma tabela de preço incorreto - GTSER-T30149
METHOD OMS010_007() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/PriceListHeaderItems/pricelist/ZZQ"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/ZZQ')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
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

//Get com uma tabela de preço específico- GTSER-T30143
METHOD OMS010_008() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/PriceListHeaderItems/pricelist/001"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/001')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar Objeto Body')
            Else
                If oBody['PriceListHeaderItems'] <> Nil
                    oHelper:lOk := oBody['code'] == '001'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Get com filtro Order          - GTSER-T30145
METHOD OMS010_009() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cCodigo       := ""
    Local cQuery        := ""
    Local cTemp     	:= GetNextAlias()
    Local cURL          := "/PriceListHeaderItems/pricelist/?Order=name"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    cQuery := "SELECT TOP 1 DA0_CODTAB FROM " + RetSqlName("DA0") + " WHERE DA0_FILIAL = '" + xFilial("DA0") + "' AND D_E_L_E_T_ = ' '  Order By DA0_DESCRI"
	cQuery := ChangeQuery(cQuery)
	MPSysOpenQuery( cQuery, cTemp )

    cCodigo   := (cTemp)->DA0_CODTAB

    (cTemp)->(DbCloseArea())

    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else 
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar Objeto Body')
            Else
                If oBody['PriceListHeaderItems'] <> Nil
                    oHelper:lOk := oBody['PriceListHeaderItems'][1]['code'] == cCodigo
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Post Json Inválido            - GTSER-T30151
METHOD OMS010_010() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist')
    Else
        cBody := '{"name": "","itensTablePrices": [{"typePrice": null,"itemCode": "","minimumSalesPrice": 0,"activeItemPrice": "0","itemValidity": "","itemList": ""}],"activeTablePrice": "3","code": null}'
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
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

//Post Json Válido              - GTSER-T30152
METHOD OMS010_011() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist')
    Else
        cBody := '{"name": "FATA080 TABELA DE PRECO","itensTablePrices": [{"typePrice": null,"itemCode": "FAT00000000000000000000000000D",'
        cBody += '"minimumSalesPrice": 200,"activeItemPrice": "1","itemValidity": "2018-02-21T00:00:00","itemList": "0001"}],"activeTablePrice": "1","code": "XXZ"}'
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['PriceListHeaderItems'] <> Nil
                oHelper:lOk := oRet['code'] == 'XXZ'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Post Json Válido com Fields   - GTSER-T30153
METHOD OMS010_012() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist?Fields=code"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint Seller/Sellers')
    Else
        cBody := '{"name": "FATA080 TABELA DE PRECO","itensTablePrices": [{"typePrice": null,"itemCode": "FAT00000000000000000000000000D",'
        cBody += '"minimumSalesPrice": 200,"activeItemPrice": "1","itemValidity": "2018-02-21T00:00:00","itemList": "0001"}],"activeTablePrice": "1","code": "XXZ"}'
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['PriceListHeaderItems'] <> Nil
                oHelper:lOk := oRet['code'] != Nil .And. oRet['name'] == Nil
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Put tabela de preço Inválida  - GTSER-T30154
METHOD OMS010_013() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXR"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXR')
    Else
        cBody := '{"name": "ALTERADO","itensTablePrices": [{"typePrice": null,"itemCode": "FAT00000000000000000000000000D",'
        cBody += '"minimumSalesPrice": 200,"activeItemPrice": "1","itemValidity": "2018-02-21T00:00:00","itemList": "0001"}],"activeTablePrice": "1","code": "XXR"}'
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

//Put Json Inválido             - GTSER-T30155
METHOD OMS010_014() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXZ"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ')
    Else
        cBody := '{"name": "","itensTablePrices": [{"typePrice": null,"itemCode": "","minimumSalesPrice": 0,"activeItemPrice": "0",'
        cBody += '"itemValidity": "","itemList": ""}],"activeTablePrice": "3","code": null}'
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


//Put Json Válido               - GTSER-T30156
METHOD OMS010_015() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXZ"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ')
    Else
        cBody := '{"name": "ALTERADO","itensTablePrices": [{"typePrice": null,"itemCode": "FAT00000000000000000000000000D",'
        cBody += '"minimumSalesPrice": 200,"activeItemPrice": "1","itemValidity": "2018-02-21T00:00:00","itemList": "0001"}],"activeTablePrice": "1","code": "XXZ"}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['PriceListHeaderItems'] <> Nil
                oHelper:lOk := AllTrim(oRet['name']) == 'ALTERADO'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Put Json Válido com Fields    - GTSER-T30157
METHOD OMS010_016() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXZ?FIELDS=code"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ?FIELDS=code')
    Else
        cBody := '{"name": "ALTERADO","itensTablePrices": [{"typePrice": null,"itemCode": "FAT00000000000000000000000000D",'
        cBody += '"minimumSalesPrice": 200,"activeItemPrice": "1","itemValidity": "2018-02-21T00:00:00","itemList": "0001"}],"activeTablePrice": "1","code": "XXZ"}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                ConOut('Erro ao carregar objeto oRet')
                oHelper:lOk := .F.
        Else
            If oRet['Seller'] <> Nil
                oHelper:lOk := oRet['code'] != Nil .And. oRet['name'] == Nil
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Delete com tabela de preço inválida  - GTSER-T30140
METHOD OMS010_017() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXB"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ')
    Else
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

//Delete com Json válido        - GTSER-T30141
METHOD OMS010_018() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXZ"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ')
    Else
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

//Get Itens                     - GTSER-T30174")
METHOD OMS010_019() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/PriceListHeaderItems/pricelist/XXZ/itensTablePrice"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ/itensTablePrice')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar Objeto Body')
            Else
                If oBody['itensTablePrices'] <> Nil
                    oHelper:lOk := oBody['itensTablePrices'][1]['code'] == 'XXZ'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Post Json Válido- GTSER-T30189
METHOD OMS010_020() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXZ/itensTablePrice"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ/itensTablePrice')
    Else
        cBody := '{"itemCode": "FAT00000000000000000000000000D","minimumSalesPrice": 100,"itemValidity": "2018-02-25","itemList": "0002","code": "XXZ"}'
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
            ConOut('Erro ao carregar objeto oRet')
            oHelper:lOk := .F.
        Else
            If oRet['PriceListHeaderItems'] <> Nil
                oHelper:lOk := oRet['code'] == 'XXZ'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Post Json inválido            - GTSER-T30190
METHOD OMS010_021() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXZ/itensTablePrice"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ/itensTablePrice')
    Else
        cBody := '{"itemCode": "","minimumSalesPrice": 0,"itemValidity": "","itemList": "","code": ""}'
        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
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

//Get Item                      - GTSER-T30191
METHOD OMS010_022() CLASS OMSS010TestCase
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/PriceListHeaderItems/pricelist/XXZ/itensTablePrice/0002"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ/itensTablePrice/0002')
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        If Empty(cBody)
            ConOut('Get Não teve retorno')
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) != Nil
                ConOut('Erro ao carregar Objeto Body')
            Else
                If oBody['itensTablePrices'] <> Nil
                    oHelper:lOk := oBody['itemList'] == '0002'
                EndIf
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Put Json Inválido             - GTSER-T30192
METHOD OMS010_023() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXZ/itensTablePrice/0002"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ/itensTablePrice/0002')
    Else
        cBody := '{"itemCode": "FAT00000000000000000000000000D","minimumSalesPrice": 100,'
        cBody += '"itemValidity": "2018-02-22","itemList": "0001"},{"itemCode": "FAT00000000000000000000000000D",'
        cBody += '"minimumSalesPrice": 50,"itemValidity": "2018-02-27","itemList": "0002"}	'
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

//Put Json válido             - GTSER-T30198
METHOD OMS010_024() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXZ/itensTablePrice/0002"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ/itensTablePrice/0002')
    Else
        cBody := '{"itemCode": "FAT00000000000000000000000000D","minimumSalesPrice": 100,'
        cBody += '"itemValidity": "2018-02-25","itemList": "0002","code": "XXZ"}'
        cRet := oHelper:UTPutWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                oHelper:lOk := .F.
                //ConOut('Erro ao carregar objeto oRet')
        Else
            If oRet['itensTablePrices'] <> Nil        
                oHelper:lOk := oRet['itemList'] == "0002"
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Delete Item                   - GTSER-T30199
METHOD OMS010_025() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXZ/itensTablePrice/0002"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ/itensTablePrice/0002')
    Else
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                oHelper:lOk := .T.
                //ConOut('Erro ao carregar objeto oRet')
        Else
            If oRet['response'] <> Nil        
                oHelper:lOk := "Sucesso" $ oRet['response'] 
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper

//Delete de um item incorreto GTSER-T30205
METHOD OMS010_026() CLASS OMSS010TestCase
    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/PriceListHeaderItems/pricelist/XXZ/itensTablePrice/9999"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader       := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")
        ConOut( 'Erro ao Acessar o EndPoint PriceListHeaderItems/pricelist/XXZ/itensTablePrice/0002')
    Else
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,"http://10.171.66.90:8282")
        oRet := JsonObject():new()
        If oRet:fromJson(cRet) != Nil
                oHelper:lOk := .T.
                //ConOut('Erro ao carregar objeto oRet')
        Else
            If oRet['errorCode'] <> Nil        
                oHelper:lOk := oRet['errorCode'] == 404
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
Return oHelper