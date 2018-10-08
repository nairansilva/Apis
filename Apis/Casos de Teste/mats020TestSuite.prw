#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATS020TestSuite

Criação da classe principal

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
@see        FWDefaultTestSuit , FWDefaultTestCase
/*/
//-------------------------------------------------------------------

CLASS MATS020TestSuite FROM FWDefaultTestSuite
	
	DATA aParam
	
	// Criação dos métodos na classe
	METHOD MATS020TestSuite() CONSTRUCTOR
	METHOD SetUpSuite()
	METHOD TearDownSuite()
	
ENDCLASS

//-----------------------------------------------------------------
/*/{Protheus.doc} MATS020TestSuite
Instancia os casos de teste

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MATS020TestSuite() CLASS MATS020TestSuite
	
	_Super:FWDefaultTestSuite()

	Self:AddTestSuite(MATS020TestGroup():MATS020TestGroup() )
	
Return

//-----------------------------------------------------------------
/*/{Protheus.doc} SetUpSuite
Prepara o ambiente para execução dos casos de teste

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD SetUpSuite() CLASS MATS020TestSuite
	
	Local oHelper		:= FWTestHelper():New()
	
    oHelper:UTOpenFilial("T1","D MG 01", "SIGACOM", ,"ADMIN","1")
	oHelper:Activate()
	
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} TearDownSuite
Finaliza o ambiente após a execução dos casos de teste

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD TearDownSuite() CLASS MATS020TestSuite
	
	Local oHelper		:= FWTestHelper():New()
	
	oHelper:UTCloseFilial()
	
Return oHelper