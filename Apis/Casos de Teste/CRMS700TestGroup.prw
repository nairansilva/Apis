#include "PROTHEUS.CH"

CLASS CRMS700TestGroup FROM FWDefaultTestSuite
	METHOD CRMS700TestGroup() CONSTRUCTOR
	
ENDCLASS

METHOD CRMS700TestGroup() CLASS CRMS700TestGroup
	_Super:FWDefaultTestSuite() 
	Self:AddTestCase( CRMS700TestCase():CRMS700TestCase() )
	
Return