#include "PROTHEUS.CH"

CLASS OMSS010TestGroup FROM FWDefaultTestSuite
	METHOD OMSS010TestGroup() CONSTRUCTOR
	
ENDCLASS

METHOD OMSS010TestGroup() CLASS OMSS010TestGroup
	_Super:FWDefaultTestSuite()
	Self:AddTestCase( OMSS010TestCase():OMSS010TestCase() )
	
Return