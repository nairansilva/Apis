#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATS030TestSuite

Criação da classe principal

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
@see        FWDefaultTestSuit , FWDefaultTestCase
/*/
//-------------------------------------------------------------------

CLASS MATS030TestSuite FROM FWDefaultTestSuite
	
	DATA aParam
	
	// Criação dos métodos na classe
	METHOD MATS030TestSuite() CONSTRUCTOR
	METHOD SetUpSuite()
	METHOD TearDownSuite()
	
ENDCLASS

//-----------------------------------------------------------------
/*/{Protheus.doc} MATS030TestSuite
Instancia os casos de teste

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MATS030TestSuite() CLASS MATS030TestSuite
	
	_Super:FWDefaultTestSuite()

	Self:AddTestSuite(MATS030TestGroup():MATS030TestGroup() )
	
Return

//-----------------------------------------------------------------
/*/{Protheus.doc} SetUpSuite
Prepara o ambiente para execução dos casos de teste

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD SetUpSuite() CLASS MATS030TestSuite
	
	Local oHelper		:= FWTestHelper():New()
	
    oHelper:UTOpenFilial("T1","D MG 01", "SIGACOM", ,"ADMIN","1")
	oHelper:Activate()
	
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} TearDownSuite
Finaliza o ambiente após a execução dos casos de teste

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD TearDownSuite() CLASS MATS030TestSuite
	
	Local oHelper		:= FWTestHelper():New()
	
	oHelper:UTCloseFilial()
	
Return oHelper