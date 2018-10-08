#include "PROTHEUS.CH"

CLASS CRMS320TestGroup FROM FWDefaultTestSuite
	METHOD CRMS320TestGroup() CONSTRUCTOR
	
ENDCLASS

METHOD CRMS320TestGroup() CLASS CRMS320TestGroup
	_Super:FWDefaultTestSuite() 
	Self:AddTestCase( CRMS320TestCase():CRMS320TestCase() )
	
Return