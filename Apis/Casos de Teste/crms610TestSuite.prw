#include "PROTHEUS.CH"

Static _cPwBase64 := ''
//------------------------------------------------------------------------------
/*/{Protheus.doc} CRMS610TestSuite
Estancia o caso de teste da API de Segmentos

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
CLASS CRMS610TestSuite FROM FWDefaultTestSuite

	DATA aParam
	
	METHOD CRMS610TestSuite() CONSTRUCTOR
	METHOD SetUpSuite()
	METHOD TearDownSuite()
	
ENDCLASS

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRMS610TestSuite
Construtor

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRMS610TestSuite() CLASS CRMS610TestSuite

	_Super:FWDefaultTestSuite()

	Self:AddTestSuite(CRMS610TestGroup():CRMS610TestGroup() )
	
Return

//------------------------------------------------------------------------------
/*/{Protheus.doc} SetUpSuite
Prepara ambiente

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD SetUpSuite() CLASS CRMS610TestSuite
    Local oHelper		:= FWTestHelper():New()

    oHelper:UTOpenFilial("T1","D MG 01", "SIGAFAT", ,"ADMIN","1")
    oHelper:Activate()
    
    Conout("Setup realizado com sucesso!")

Return oHelper

//------------------------------------------------------------------------------
/*/{Protheus.doc} TearDownSuite

Encerra conexão

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD TearDownSuite() CLASS CRMS610TestSuite
    Local oHelper		:= FWTestHelper():New()

    oHelper:UTRestParam(::aParam)
    oHelper:UTCloseFilial()
Return oHelper
