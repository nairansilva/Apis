#include "PROTHEUS.CH"

CLASS MATS040TestGroup FROM FWDefaultTestSuite
	METHOD MATS040TestGroup() CONSTRUCTOR
	
ENDCLASS

METHOD MATS040TestGroup() CLASS MATS040TestGroup
	_Super:FWDefaultTestSuite() 
	Self:AddTestCase( MATS040TestCase():MATS040TestCase() )
	
Return