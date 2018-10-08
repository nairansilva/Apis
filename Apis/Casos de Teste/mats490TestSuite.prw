#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATS020TestSuite

Cria��o da classe principal

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
@see        FWDefaultTestSuit , FWDefaultTestCase
/*/
//-------------------------------------------------------------------

CLASS MATS490TestSuite FROM FWDefaultTestSuite
	
	DATA aParam
	
	// Cria��o dos m�todos na classe
	METHOD MATS490TestSuite() CONSTRUCTOR
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
METHOD MATS490TestSuite() CLASS MATS490TestSuite
	
	_Super:FWDefaultTestSuite()

	Self:AddTestSuite(MATS490TestGroup():MATS490TestGroup() )
	
Return

//-----------------------------------------------------------------
/*/{Protheus.doc} SetUpSuite
Prepara o ambiente para execu��o dos casos de teste

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD SetUpSuite() CLASS MATS490TestSuite
	
	Local oHelper		:= FWTestHelper():New()
	
    oHelper:UTOpenFilial("T1","D MG 01", "SIGACOM", ,"ADMIN","1")
	oHelper:Activate()
	
Return oHelper

//-----------------------------------------------------------------
/*/{Protheus.doc} TearDownSuite
Finaliza o ambiente ap�s a execu��o dos casos de teste

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------

METHOD TearDownSuite() CLASS MATS490TestSuite
	
	Local oHelper		:= FWTestHelper():New()
	
	oHelper:UTCloseFilial()
	
Return oHelper