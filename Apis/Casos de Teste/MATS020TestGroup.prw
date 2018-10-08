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

CLASS MATS020TestGroup FROM FWDefaultTestSuite

	METHOD MATS020TestGroup() CONSTRUCTOR

ENDCLASS
//-----------------------------------------------------------------
/*/{Protheus.doc} MATS020TestGroup
Instancia os casos de teste
 
@author     Squad CRM Faturamento
@since      31/08/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MATS020TestGroup() CLASS MATS020TestGroup
	
	_Super:FWDefaultTestSuite()
	
	Self:AddTestCase(MATS020TestCase():MATS020TestCase() )
	
Return