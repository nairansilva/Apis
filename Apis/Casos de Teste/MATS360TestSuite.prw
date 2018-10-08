#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATS360TestSuite

Criação da classe principal

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
@see        FWDefaultTestSuit , FWDefaultTestCase
/*/
//-------------------------------------------------------------------

CLASS MATS360TestSuite FROM FWDefaultTestSuite
	
	DATA aParam

	METHOD MATS360TestSuite() CONSTRUCTOR
	METHOD SetUpSuite()
	METHOD TearDownSuite()
	
ENDCLASS

//-----------------------------------------------------------------
/*/{Protheus.doc} MATS360TestSuite
Instancia os casos de teste

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MATS360TestSuite() CLASS MATS360TestSuite
	
	_Super:FWDefaultTestSuite()

	Self:AddTestSuite(MATS360TestGroup():MATS360TestGroup() )
	
Return

//-----------------------------------------------------------------
/*/{Protheus.doc} SetUpSuite
Prepara o ambiente para execução dos casos de teste

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD SetUpSuite() CLASS MATS360TestSuite
	
	Local oHelper		:= FWTestHelper():New()
	
    oHelper:UTOpenFilial("T1","D MG 01 ", "SIGAFAT", ,"ADMIN","1")
	oHelper:Activate()
	
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} TearDownSuite
Finaliza o ambiente após a execução dos casos de teste

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD TearDownSuite() CLASS MATS360TestSuite
	
	Local oHelper		:= FWTestHelper():New()
	
	oHelper:UTCloseFilial()
	
Return oHelper