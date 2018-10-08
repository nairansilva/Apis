#include "PROTHEUS.CH"

CLASS CRMS700TestSuite FROM FWDefaultTestSuite

	DATA aParam
	
	METHOD CRMS700TestSuite() CONSTRUCTOR
	METHOD SetUpSuite()
	METHOD TearDownSuite() 
	
ENDCLASS

METHOD CRMS700TestSuite() CLASS CRMS700TestSuite

	_Super:FWDefaultTestSuite()

	Self:AddTestSuite(CRMS700TestGroup():CRMS700TestGroup() )
	
Return

METHOD SetUpSuite() CLASS CRMS700TestSuite
    Local oHelper		:= FWTestHelper():New()

    oHelper:UTOpenFilial("T1","D MG 01", "SIGAFAT", ,"ADMIN","1")
    oHelper:Activate()

    Conout("Setup realizado com sucesso!")

Return oHelper

METHOD TearDownSuite() CLASS CRMS700TestSuite
    Local oHelper		:= FWTestHelper():New()

    oHelper:UTRestParam(::aParam)
    oHelper:UTCloseFilial()
Return oHelper
