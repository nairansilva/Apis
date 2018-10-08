#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATS360TestGroup

Criação da classe principal

@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
@see        FWDefaultTestSuit , FWDefaultTestCase
/*/
//-------------------------------------------------------------------

CLASS MATS360TestGroup FROM FWDefaultTestSuite

	METHOD MATS360TestGroup() CONSTRUCTOR

ENDCLASS
//-----------------------------------------------------------------
/*/{Protheus.doc} MATS360TestGroup
Instancia os casos de teste
 
@author     Squad CRM Faturamento
@since      26/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MATS360TestGroup() CLASS MATS360TestGroup
	
	_Super:FWDefaultTestSuite()
	
	Self:AddTestCase(MATS360TestCase():MATS360TestCase() )
	
Return