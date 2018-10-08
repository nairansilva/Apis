#include "PROTHEUS.CH"

CLASS CRMS320TestSuite FROM FWDefaultTestSuite

	DATA aParam
	
	METHOD CRMS320TestSuite() CONSTRUCTOR
	METHOD SetUpSuite()
	METHOD TearDownSuite() 
	
ENDCLASS

METHOD CRMS320TestSuite() CLASS CRMS320TestSuite

	_Super:FWDefaultTestSuite()

	Self:AddTestSuite(CRMS320TestGroup():CRMS320TestGroup() )
	
Return

METHOD SetUpSuite() CLASS CRMS320TestSuite
    Local oHelper		:= FWTestHelper():New()

    oHelper:UTOpenFilial("T1","D MG 01", "SIGAFAT", ,"ADMIN","1")
    oHelper:Activate()

    Conout("Setup realizado com sucesso!")

Return oHelper

METHOD TearDownSuite() CLASS CRMS320TestSuite
    Local oHelper		:= FWTestHelper():New()

    oHelper:UTRestParam(::aParam)
    oHelper:UTCloseFilial()
Return oHelper
