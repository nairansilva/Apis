#include "PROTHEUS.CH"

CLASS MATS040TestSuite FROM FWDefaultTestSuite

	DATA aParam
	
	METHOD MATS040TestSuite() CONSTRUCTOR
	METHOD SetUpSuite()
	METHOD TearDownSuite() 
	
ENDCLASS

METHOD MATS040TestSuite() CLASS MATS040TestSuite

	_Super:FWDefaultTestSuite()

	Self:AddTestSuite(MATS040TestGroup():MATS040TestGroup() )
	
Return

METHOD SetUpSuite() CLASS MATS040TestSuite
    Local oHelper		:= FWTestHelper():New()

    oHelper:UTOpenFilial("T1","D MG 01", "SIGAFAT", ,"ADMIN","1")
    oHelper:Activate()

    Conout("Setup realizado com sucesso!")

Return oHelper

METHOD TearDownSuite() CLASS MATS040TestSuite
    Local oHelper		:= FWTestHelper():New()

    oHelper:UTRestParam(::aParam)
    oHelper:UTCloseFilial()
Return oHelper
