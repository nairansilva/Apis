#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATS360TestCase

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
@see        FWDefaultTestSuit , FWDefaultTestCase
/*/
//-------------------------------------------------------------------
CLASS MATS360TestCase from FWDefaultTestCase
	
	DATA oHelper
	
	METHOD SetUpClass()
	METHOD MATS360TestCase() CONSTRUCTOR
	METHOD MAT360_001()
    METHOD MAT360_002()
    METHOD MAT360_003()
    METHOD MAT360_004()
    METHOD MAT360_005()
    METHOD MAT360_006()
    METHOD MAT360_007()
    METHOD MAT360_008()
    METHOD MAT360_009()
    METHOD MAT360_010()
    METHOD MAT360_011()
    METHOD MAT360_012()
    METHOD MAT360_013()
    METHOD MAT360_014()
    METHOD MAT360_015()
    METHOD MAT360_016()
    METHOD MAT360_017()
    METHOD MAT360_018()
    METHOD MAT360_019()
    METHOD MAT360_020()
    METHOD MAT360_021()
    METHOD MAT360_022()
    METHOD MAT360_023()
    METHOD MAT360_024()
    METHOD MAT360_025()
    METHOD MAT360_026()
    METHOD MAT360_027()
    METHOD MAT360_028()
    METHOD MAT360_029()

ENDCLASS

//-----------------------------------------------------------------
/*/{Protheus.doc} SetUpClass
Instancía os casos de teste

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0

/*/
//-----------------------------------------------------------------
METHOD SetUpClass() CLASS MATS360TestCase
	
    Local oHelper		:= FWTestHelper():New()

    Static aRetAuto := {}
 
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MATS360TestCase
Instancia os casos de teste

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MATS360TestCase() CLASS MATS360TestCase

    _Super:FWDefaultTestSuite()

    ::AddTestMethod("MAT360_001",,"Post Json Inválido")
    ::AddTestMethod("MAT360_002",,"Post Json Válido - Tipo 5")
    ::AddTestMethod("MAT360_003",,"Post Json Válido - Tipo 6")
	::AddTestMethod("MAT360_004",,"Post Json Válido - Tipo 8")
    ::AddTestMethod("MAT360_005",,"Post Json Invalido - Campo invalido")
    ::AddTestMethod("MAT360_006",,"Post Json com dados invalido")
    ::AddTestMethod("MAT360_007",,"Put Inválido")
    ::AddTestMethod("MAT360_008",,"Put Valido - Tipo 5")
    ::AddTestMethod("MAT360_009",,"Put Valido - Tipo 6")
    ::AddTestMethod("MAT360_010",,"Put Valido - Tipo 8")
    ::AddTestMethod("MAT360_011",,"Put json Inválido")
    ::AddTestMethod("MAT360_012",,"Put campo Inválido")
    ::AddTestMethod("MAT360_013",,"Put Tipo Inválido")
    ::AddTestMethod("MAT360_014",,"Put dados Inválido")
    ::AddTestMethod("MAT360_015",,"Delete invalido")
    ::AddTestMethod("MAT360_016",,"Delete válido")
    ::AddTestMethod("MAT360_017",,"Get de Todas Condições de Pagamento")
    ::AddTestMethod("MAT360_018",,"Get com cParam incorreto")
    ::AddTestMethod("MAT360_019",,"Get com cParam - Codigo invalido")
    ::AddTestMethod("MAT360_020",,"Get com filtro Page")
    ::AddTestMethod("MAT360_021",,"Get com filtro PageSize")
    ::AddTestMethod("MAT360_022",,"Get com filtro Fields")
    ::AddTestMethod("MAT360_023",,"Get com filtro Order")
    ::AddTestMethod("MAT360_024",,"Get Especifico com codigo invalido")
    ::AddTestMethod("MAT360_025",,"Get Especifico com Tipo 5")
    ::AddTestMethod("MAT360_026",,"Get Especifico com Tipo 6")
    ::AddTestMethod("MAT360_027",,"Get Especifico com Tipo 8")
    ::AddTestMethod("MAT360_028",,"Get Especifico com Tipo 7")
    ::AddTestMethod("MAT360_029",,"Get Especifico com Tipo 2")

Return Nil

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_001
Post Json Inválido

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_001() CLASS MATS360TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''    
    Local cURL      := "/paymentcondition/fat/paymentcondition/"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else
        
        cBody := '{"CompanyId": "T1","BranchId": "D MG 01 ","Code":"012","CompanyInternalId": "T1D MG 01 012","InternalId": "D MG 01 012" "Description": "Teste API Tp 5"}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) == Nil
            oHelper:lOk := .F.
        Else
            oHelper:lOk := .T.            
        EndIf
    EndIf 

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_002
Post Json Válido - Tipo 5

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_002() CLASS MATS360TestCase 

    Local aHeader   := {}
    Local cBody     := ""
    Local cRet      := ""
    Local cURL      := "/paymentcondition/fat/paymentcondition"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else

        cBody := '{"CompanyId": "T1","BranchId": "D MG 01 ","Code": "AP1","CompanyInternalId": "T1D MG 01 AP1","InternalId": "D MG 01 AP1",'
        cBody += '"Description": "Teste API Tp 5","DaysCondition": 1,"QuantityPlots": 3,"DaysFirstDue": 10,"RangePlots": 30,"FinancialDiscountDays":1,'
        cBody += '"PercentageDiscountDays":1.5}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil            
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                oHelper:lOk := oRet['code'] == 'AP1'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_003
Post Json Válido - Tipo 6 com Fields

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_003() CLASS MATS360TestCase 

    Local aHeader   := {}
    Local cBody     := ""
    Local cRet      := ""
    Local cURL      := "/paymentcondition/fat/paymentcondition?fields=code"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else

        cBody := '{"CompanyId": "T1","BranchId": "D MG 01 ","Code": "AP2","CompanyInternalId": "T1D MG 01 AP2","InternalId": "D MG 01 AP2",'
        cBody += '"Description": "Teste Api Tp 6","DaysCondition": 2,"QuantityPlots": 3,"DaysFirstDue": 30,"RangePlots": 3,"WeekDayFixed": 2,'
        cBody += '"PercentageIncrease":1}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil            
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                oHelper:lOk := oRet['code'] == 'AP2' .And. oRet['Description'] == Nil
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_004
Post Json Válido - Tipo 8

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_004() CLASS MATS360TestCase 

    Local aHeader   := {}
    Local cBody     := ""
    Local cRet      := ""
    Local cURL      := "/paymentcondition/fat/paymentcondition"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else

        cBody := '{"CompanyId": "T1","BranchId": "D MG 01 ","Code": "AP3","CompanyInternalId": "T1D MG 01 AP3","InternalId": "D MG 01 AP3",'
        cBody += '"Description": "Teste Api Tp 8","DaysCondition": 3,"Plots": [{"DueDay": 30,"Percentage": 50},{"DueDay": 60,"Percentage": 30'
        cBody += '},{"DueDay": 90,"Percentage": 20}]}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil            
            oHelper:lOk := .F.
        Else
            If oRet['code'] <> Nil
                oHelper:lOk := oRet['code'] == 'AP3'
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_005
Post Json Invalido - Campo invalido

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_005() CLASS MATS360TestCase 

    Local aHeader   := {}
    Local cBody     := ""
    Local cRet      := ""
    Local cURL      := "/paymentcondition/fat/paymentcondition"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else

        cBody := '{"CompanyId": "T1","BranchId": "D MG 01 ","Code": "AP4","CompanyInternalId": "T1D MG 01 AP4","InternalId": "D MG 01 AP4",'
        cBody += '"DaysCondition": 1,"QuantityPlots": 3,"DaysFirstDue": 10,"RangePlots": 30,"FinancialDiscountDays":1,'
        cBody += '"PercentageDiscountDays":1.5},"Description": "Teste APIaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) == Nil
            oHelper:lOk := .F.
        Else
            oHelper:lOk := .T.            
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_006
Post Json com dados invalido

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_006() CLASS MATS360TestCase 

    Local aHeader   := {}
    Local cBody     := ""
    Local cRet      := ""
    Local cURL      := "/paymentcondition/fat/paymentcondition"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else

        cBody := '{"CompanyId": "T1","BranchId": "D MG 01 ","Code": "APZ","CompanyInternalId": "T1D MG 01 APZ","InternalId": "D MG 01 APZ","Description": "Teste Api Tp 8",'
        cBody += '"DaysCondition": 3,"Plots": [{"DueDay": 30,"Percentage": 50},{"DueDay": 60,"Percentage": 30},{"DueDay": 90,"Percentage": 30}]}'

        cRet := oHelper:UTPostWS(cBody,aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) == Nil
            oHelper:lOk := .F.
        Else
            oHelper:lOk := .T.            
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_007
Put Condicao Inválido
@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_007() CLASS MATS360TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/paymentcondition/fat/paymentcondition/D+MG+01+YWQ"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else
        cBody := '{"Code": "YWQ","Description": "Teste API YWQ"}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            oHelper:lOk := .F.
        Else
            If oRet['errorCode'] <> Nil        
                oHelper:lOk := oRet['errorCode'] == 404
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_008
Put Valido - Tipo 5
@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_008() CLASS MATS360TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/paymentcondition/fat/paymentcondition/D+MG+01+AP5"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else
        cBody := '{"Code": "AP5","Description": "Teste API Tp 5","DaysCondition": 4}'        
        cRet := oHelper:UTPutWS(cBody,aHeader,,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil                
            oHelper:lOk := .F.
        Else
            If oRet['Code'] <> Nil
                oHelper:lOk := oRet['Code'] == "AP5"
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_009
Put Valido - Tipo 6
@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_009() CLASS MATS360TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/paymentcondition/fat/paymentcondition/D+MG+01+AP6"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else
        cBody := '{"Code": "AP6","Description": "Teste API Tp 6","DaysCondition": 5}'
        cRet := oHelper:UTPutWS(cBody,aHeader,,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            oHelper:lOk := .F.
        Else
            If oRet['Code'] <> Nil
                oHelper:lOk := oRet['Code'] == "AP6"
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_010
Put Valido - Tipo 8
@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_010() CLASS MATS360TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/paymentcondition/fat/paymentcondition/D+MG+01+AP8"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else
        cBody := '{"Code": "AP8","Description": "Teste API Tp 8","DaysCondition": 6}'        
        cRet := oHelper:UTPutWS(cBody,aHeader,,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil                
            oHelper:lOk := .F.
        Else
            If oRet['Code'] <> Nil
                oHelper:lOk := oRet['Code'] == "AP8"
            Else
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_011
Put json Inválido
@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_011() CLASS MATS360TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/paymentcondition/fat/paymentcondition/D+MG+01+AP5"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else
        cBody := '{"Code": "AP5""Description": "Teste API"}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
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
/*/{Protheus.doc} MAT360_012
Put Campo Inválido
@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_012() CLASS MATS360TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/paymentcondition/fat/paymentcondition/D+MG+01+AP5"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else
        cBody := '{"Code": "AP5","Description": "Teste APIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
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
/*/{Protheus.doc} MAT360_013
Put Tipo Inválido
@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_013() CLASS MATS360TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/paymentcondition/fat/paymentcondition/D+MG+01+AP7"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else
        cBody := '{"Code": "AP7","Description": "Teste"}' 
        cRet := oHelper:UTPutWS(cBody,aHeader,,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
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
/*/{Protheus.doc} MAT360_014
Put dados Inválido
@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_014() CLASS MATS360TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/paymentcondition/fat/paymentcondition/D+MG+01+AP8"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

     aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else
        cBody := '{"CompanyId": "T1","BranchId": "D MG 01 ","Code": "AP8","CompanyInternalId": "T1D MG 01 AP8","InternalId": "D MG 01 AP8","Description": "Teste Api Tp 8",'
        cBody += '"DaysCondition": 3,"Plots": [{"DueDay": 30,"Percentage": 50},{"DueDay": 60,"Percentage": 30},{"DueDay": 90,"Percentage": 30}]}'
        cRet := oHelper:UTPutWS(cBody,aHeader,,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
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
/*/{Protheus.doc} MAT360_015
Delete invalido
@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_015() CLASS MATS360TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ''
    Local cURL      := "/paymentcondition/fat/paymentcondition/D+MG+01+YZD"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else
        cRet := oHelper:UTDeleteWS(cBody,aHeader,/*cFile*/,"http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil
            oHelper:lOk := .F.
        Else
            If oRet['errorCode'] <> Nil        
                oHelper:lOk := oRet['errorCode'] == 404
            Else 
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_016
Delete válido
@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_016() CLASS MATS360TestCase

    Local aHeader   := {}
    Local cBody     := ''
    Local cRet      := ""
    Local cURL      := "/paymentcondition/fat/paymentcondition/D+MG+01+AP0"
    Local oRet      := Nil
    Local oHelper	:= FWTestHelper():New()
   
    oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }
    
    If !oHelper:UTSetAPI(cURL,"REST")
        oHelper:lOk := .F.
    Else        
        cRet := oHelper:UTDeleteWS(cBody,aHeader,"","http://localhost:8082")
        oRet := JsonObject():new()

        If oRet:fromJson(cRet) <> Nil                
            oHelper:lOk := .F.
        Else
            If oRet['response'] <> Nil      
                oHelper:lOk := "Sucesso" $ oRet['response']
            Else 
                oHelper:lOk := .F.
            EndIf
        EndIf
    EndIf

    oHelper:AssertTrue(oHelper:lOk,'')
    
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_017
Get de Todas Condições de Pagamento
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_017() CLASS MATS360TestCase
	
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/paymentcondition/fat/paymentcondition/"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil                
                oHelper:lOk := .F.
            Else  
                oHelper:lOk := oBody['errorCode'] == Nil
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )
	
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_018
Get com cParam
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_018() CLASS MATS360TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/paymentcondition/fat/paymentcondition?Code=AP5"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil                
                oHelper:lOk := .F.
            Else
                If oBody["items"] <> Nil
                    oHelper:lOk := oBody["items"][1]["Code"] == "AP5"
                Else
                    oHelper:lOk := .F.
                Endif
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_019
Get com cParam - Codigo invalido
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_019() CLASS MATS360TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/paymentcondition/fat/paymentcondition?Code=YZW"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil                
                oHelper:lOk := .F.
            Else
                If oBody['errorCode'] <> Nil        
                    oHelper:lOk := oBody['errorCode'] == 404
                Else
                    oHelper:lOk := .F.
                EndIf
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_020
Get com filtro Page
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_020() CLASS MATS360TestCase
	
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/paymentcondition/fat/paymentcondition?Page=2"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil                
                oHelper:lOk := .F.
            Else  
                If oBody["items"] <> Nil
                    oHelper:lOk := oBody["items"][1]["Code"] == "021"
                Else
                    oHelper:lOk := .F.
                Endif
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )
	
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_021
Get com filtro PageSize
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_021() CLASS MATS360TestCase
	
    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/paymentcondition/fat/paymentcondition?PageSize=2"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil                
                oHelper:lOk := .F.
            Else  
                If oBody["items"] <> Nil
                    oHelper:lOk := Len(oBody['items']) <= 2
                Else
                    oHelper:lOk := .F.
                Endif
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )
	
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_022
Get com filtro Fields
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_022() CLASS MATS360TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/paymentcondition/fat/paymentcondition?fields=Description"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil                
                oHelper:lOk := .F.
            Else
                If oBody["items"] <> Nil
                    oHelper:lOk := oBody['items'][1]['Code'] == Nil .And. oBody['items'][1]['Description'] != Nil
                Else
                    oHelper:lOk := .F.
                Endif
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_023
Get com filtro Order
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_023() CLASS MATS360TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cDesc         := ""
    Local cQuery        := ""
    Local cTemp     	:= GetNextAlias()
    Local cURL          := "/paymentcondition/fat/paymentcondition?order=Description"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()

    cQuery := " SELECT TOP 1 E4_DESCRI FROM " + RetSqlName("SE4") + " WHERE E4_FILIAL = '" + xFilial("SE4") + "' AND D_E_L_E_T_ = ' ' Order By E4_DESCRI "    
	cQuery := ChangeQuery(cQuery)
	MPSysOpenQuery( cQuery, cTemp )
    cDesc   := (cTemp)->E4_DESCRI

    (cTemp)->(DbCloseArea())
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil                
                oHelper:lOk := .F.
            Else
                If oBody["items"] <> Nil
                    oHelper:lOk := oBody["items"][1]["Description"] == cDesc
                Else
                    oHelper:lOk := .F.
                Endif
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_024
Get Especifico com codigo invalido
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_024() CLASS MATS360TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/paymentcondition/fat/paymentcondition/D_MG_01_YZW"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil                
                oHelper:lOk := .F.
            Else
                If oBody['errorCode'] <> Nil        
                    oHelper:lOk := oBody['errorCode'] == 404
                Else
                    oHelper:lOk := .F.
                EndIf
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_025
Get Especifico com Tipo 5
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_025() CLASS MATS360TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/paymentcondition/fat/paymentcondition/D+MG+01+AP5"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil                
                oHelper:lOk := .F.
            Else
                If oBody['Code'] <> Nil        
                    oHelper:lOk := oBody['Code'] == 'AP5'
                Else
                    oHelper:lOk := .F.
                EndIf
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_026
Get Especifico com Tipo 6
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_026() CLASS MATS360TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := "/paymentcondition/fat/paymentcondition/D+MG+01+AP6"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil                
                oHelper:lOk := .F.
            Else
                If oBody['Code'] <> Nil        
                    oHelper:lOk := oBody['Code'] == 'AP6'
                Else
                    oHelper:lOk := .F.
                EndIf
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_027
Get Especifico com Tipo 5
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_027() CLASS MATS360TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := '/paymentcondition/fat/paymentcondition/D+MG+01+AP8"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                oHelper:lOk := .F.
            Else
                If oBody['Code'] <> Nil        
                    oHelper:lOk := oBody['Code'] == 'AP8'
                Else
                    oHelper:lOk := .F.
                EndIf
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_028
Get Especifico com Tipo 7
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_028() CLASS MATS360TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := '/paymentcondition/fat/paymentcondition/D+MG+01+AP7"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                oHelper:lOk := .F.
            Else
                If oBody['Code'] <> Nil        
                    oHelper:lOk := oBody['Code'] == 'AP7'
                Else
                    oHelper:lOk := .F.
                EndIf
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} MAT360_029
Get Especifico com Tipo 2
@author     Squad CRM Faturamento
@since      01/10/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD MAT360_029() CLASS MATS360TestCase

    Local aHeader       := {}
    Local cBody         := ''
    Local cURL          := '/paymentcondition/fat/paymentcondition/D+MG+01+064"
    Local oBody         := Nil
    Local oHelper	    := FWTestHelper():New()
	
	oHelper:Activate()

    aHeader := {"Content-Type: application/json","Authorization: Basic "+ oHelper:UtSetAuthorization('ADMIN','1') +"" }

    If !oHelper:UTSetAPI(cURL,"REST")        
        oHelper:lOk := .F.
    Else
        cBody := oHelper:UTGetWS(aHeader,/*cFile*/,/*cGetParms*/,"http://localhost:8082")
        If Empty(cBody)
            oHelper:lOk := .F.
        Else
            oBody := JsonObject():new()
            
            If oBody:fromJson(cBody) <> Nil
                oHelper:lOk := .F.
            Else
                If oBody['Code'] <> Nil        
                    oHelper:lOk := oBody['Code'] == '064'
                Else
                    oHelper:lOk := .F.
                EndIf
            EndIf
        EndIf
    EndIf
	
	oHelper:AssertTrue( oHelper:lOk, "" )

Return oHelper