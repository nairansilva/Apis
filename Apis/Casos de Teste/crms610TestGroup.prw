#include "PROTHEUS.CH"

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRMS610TestGroup
Grupo de teste da automação da API de Segmentos

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
CLASS CRMS610TestGroup FROM FWDefaultTestSuite
	METHOD CRMS610TestGroup() CONSTRUCTOR
	
ENDCLASS

//------------------------------------------------------------------------------
/*/{Protheus.doc} CRMS610TestGroup

Adiciona os casos de teste ao grupo

@author		Renato da Cunha
@since		15/08/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
METHOD CRMS610TestGroup() CLASS CRMS610TestGroup
	_Super:FWDefaultTestSuite()
	Self:AddTestCase( CRMS610TestCase():CRMS610TestCase() )
	
Return