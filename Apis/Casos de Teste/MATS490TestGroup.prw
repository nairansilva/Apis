#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATS020TestGroup

Criação da classe principal

@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
@see        FWDefaultTestSuit , FWDefaultTestCase
/*/
//-------------------------------------------------------------------

CLASS MATS490TestGroup FROM FWDefaultTestSuite

	METHOD MATS490TestGroup() CONSTRUCTOR

ENDCLASS
//-----------------------------------------------------------------
/*/{Protheus.doc} MATS020TestGroup
Instancia os casos de teste
 
@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MATS490TestGroup() CLASS MATS490TestGroup
	
	_Super:FWDefaultTestSuite()
	
	Self:AddTestCase(MATS490TestCase():MATS490TestCase() )
	
Return