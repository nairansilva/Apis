#include "PROTHEUS.CH"

CLASS OMSS010TestSuite FROM FWDefaultTestSuite

	DATA aParam
	
	METHOD OMSS010TestSuite() CONSTRUCTOR
	METHOD SetUpSuite()
	METHOD TearDownSuite()
	
ENDCLASS

METHOD OMSS010TestSuite() CLASS OMSS010TestSuite

	_Super:FWDefaultTestSuite()

	Self:AddTestSuite(OMSS010TestGroup():OMSS010TestGroup() )
	
Return

METHOD SetUpSuite() CLASS OMSS010TestSuite
    Local oHelper		:= FWTestHelper():New()

    oHelper:UTOpenFilial("T1","D MG 01", "SIGAFAT", ,"ADMIN","1")
    oHelper:Activate()

    Conout("Setup realizado com sucesso!")

Return oHelper

METHOD TearDownSuite() CLASS OMSS010TestSuite
    Local oHelper		:= FWTestHelper():New()

    oHelper:UTRestParam(::aParam)
    oHelper:UTCloseFilial()
Return oHelper
