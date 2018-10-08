#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATS030TestGroup

Criação da classe principal

@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
@see        FWDefaultTestSuit , FWDefaultTestCase
/*/
//-------------------------------------------------------------------

CLASS MATS030TestGroup FROM FWDefaultTestSuite

	METHOD MATS030TestGroup() CONSTRUCTOR

ENDCLASS
//-----------------------------------------------------------------
/*/{Protheus.doc} MATS030TestGroup
Instancia os casos de teste
 
@author     Squad CRM Faturamento
@since      04/09/2018
@version    1.0
/*/
//-----------------------------------------------------------------
METHOD MATS030TestGroup() CLASS MATS030TestGroup
	
	_Super:FWDefaultTestSuite()
	
	Self:AddTestCase(MATS030TestCase():MATS030TestCase() )
	
Return