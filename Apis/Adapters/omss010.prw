#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE 'FWMVCDEF.CH'
#INCLUDE "RESTFUL.CH"

//dummy function
Function OMSS010()
Return

/*/{Protheus.doc} PriceListHeaderItems

API de integração de tabelas de Preço

@author		Squad Faturamento/SRM
@since		02/08/2018
/*/
WSRESTFUL PriceListHeaderItems DESCRIPTION "Tabela de Preços de Venda" //"Tabela de Preços de Venda"
	WSDATA Fields			AS STRING	OPTIONAL
	WSDATA Order			AS STRING	OPTIONAL
	WSDATA Page				AS INTEGER	OPTIONAL
	WSDATA PageSize			AS INTEGER	OPTIONAL
	WSDATA Code				AS STRING	OPTIONAL
	WSDATA ItemList 		AS STRING	OPTIONAL
 
    WSMETHOD GET Main ;
    DESCRIPTION "Carrega todas as tabelas de preço" ;
    WSSYNTAX "/pricelist/{Order, Page, PageSize, Fields}" ;
    PATH "/pricelist"

    WSMETHOD POST Main ;
    DESCRIPTION "Cadastra uma nova tabela de preço" ;
    WSSYNTAX "/pricelist/" ;
    PATH "/pricelist"

    WSMETHOD GET TableID ;
    DESCRIPTION "Carrega uma tabela de preço específica" ;
    WSSYNTAX "/pricelist/{Code}/{Order, Page, PageSize, Fields}" ;
    PATH "/pricelist/{Code}"

    WSMETHOD PUT TableID ;
    DESCRIPTION "Altera uma tabela de preço específica" ;
    WSSYNTAX "/pricelist/{Code}" ;
    PATH "/pricelist/{Code}"
    
    WSMETHOD DELETE TableID ;
    DESCRIPTION "Deleta uma tabela de preço específica" ;
    WSSYNTAX "/pricelist/{Code}" ;
    PATH "/pricelist/{Code}"    
    	
    WSMETHOD GET itensTablePrice ;
    DESCRIPTION "Carrega os itens da tabela de preço específica" ;
    WSSYNTAX "/pricelist/{Code}/itensTablePrice/{Order, Page, PageSize, Fields, ItemList}" ;
    PATH "/pricelist/{Code}/itensTablePrice"
    
    WSMETHOD POST itensTablePrice ;
    DESCRIPTION "Carrega os itens da tabela de preço específica" ;
    WSSYNTAX "/pricelist/{Code}/itensTablePrice/" ;
    PATH "/pricelist/{Code}/itensTablePrice"    
    
    WSMETHOD GET ItemID ;
    DESCRIPTION "Carrega os itens da tabela de preço específica" ;
    WSSYNTAX "/pricelist/{Code}/itensTablePrice/{Order, Page, PageSize, Fields, ItemList}" ;
    PATH "/pricelist/{Code}/itensTablePrice/{ItemList}"	
    
    WSMETHOD PUT ItemID ;
    DESCRIPTION "Carrega os itens da tabela de preço específica" ;
    WSSYNTAX "/pricelist/{Code}/itensTablePrice/{ItemList}" ;
    PATH "/pricelist/{Code}/itensTablePrice/{ItemList}"    
    
    WSMETHOD DELETE ItemID ;
    DESCRIPTION "Carrega os itens da tabela de preço específica" ;
    WSSYNTAX "/pricelist/{Code}/itensTablePrice/{ItemList}" ;
    PATH "/pricelist/{Code}/itensTablePrice/{ItemList}"        
ENDWSRESTFUL

/*/{Protheus.doc} GET / PriceListHeaderItems/pricelist
Retorna todas as tabelas de preços cadastradas

@param	Order		, caracter, Ordenação da tabela principal
@param	Page		, numérico, Número da página inicial da consulta
@param	PageSize	, numérico, Número de registro por páginas
@param	Fields		, caracter, Campos que serão retornados no GET.

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

WSMETHOD GET Main WSRECEIVE Order, Page, PageSize, Fields WSSERVICE PriceListHeaderItems

	Local cError			:= ""
	Local lRet				:= .T.
	Local oApiManager		:= Nil
	
    Self:SetContentType("application/json")

	oApiManager := APIMANAGER():New("omss010","2.001") 
	
	lRet := GetMain(@oApiManager, Self:aQueryString)

	If lRet
		Self:SetResponse( oApiManager:GetJsonSerialize() )
	Else
		cError := oApiManager:GetJsonError()	
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf
	
	FreeObj(oApiManager)

Return lRet

/*/{Protheus.doc} POST/ PriceListHeaderItems
Inclui uma nova tabela de preço

@param	Fields		, caracter, Campos que serão retornados no GET.

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

WSMETHOD POST Main WSSERVICE PriceListHeaderItems
	Local aCab			:= {}
	Local aMsgErro		:= {}
	Local aItens		:= {}
	Local aQueryString	:= Self:aQueryString
	Local aIgnore		:= {}
	Local aJson			:= {}
	Local aFatherAlias	:= {"DA0","items","PriceListHeaderItems"}
    Local cBody 		:= ""
	Local cError		:= ""
    Local cResp			:= "Operação Realizada com Sucesso"
    Local lRet			:= .T.
	Local nX			:= 0
	Local oApiManager 	:= APIMANAGER():New("omss010","2.001")
    
	Private lMsErroAuto 	:= .F.
	Private lAutoErrNoFile	:= .T.

	Self:SetContentType("application/json")
    cBody 	   := Self:GetContent()
    
	oApiManager:SetApiAlias(aFatherAlias)
	oApiManager:Activate()

	If !oApiManager:IsActive()
		lRet := .F.
	Else
		aadd(aIgnore, {'DA1_CODTAB'})
		aJson := oApiManager:GetJsonArray(cBody)
		lRet := CRMJsonToArray({'DA0','items'},{'DA1','itensTablePrices'}, aCab, aItens, aIgnore, aJson, 3)
		If lRet
			MSExecAuto({|x, y, z| OMSA010(x, y, z)}, aCab, aItens, 3)
		EndIf

		If lMsErroAuto
			aMsgErro := GetAutoGRLog()
			cResp	 := ""
			For nX := 1 To Len(aMsgErro)
				cResp += StrTran( StrTran( aMsgErro[nX], "<", "" ), "-", "" ) + (" ") 
			Next nX	
			lRet := .F.
			oApiManager:SetJsonError("400","Erro durante inclusão da tabela de preço!.", cResp,/*cHelpUrl*/,/*aDetails*/)
		EndIf
		
		If lRet
			aAdd(aQueryString,{"Code",DA0->DA0_CODTAB})
			lRet := GetMain(@oApiManager, aQueryString, .F.)
		EndIf

		If lRet
			Self:SetResponse( oApiManager:ToObjectJson() )
		Else
			cError := oApiManager:GetJsonError()
			SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
		EndIf
	EndIf
	FreeObj( oApiManager )
    FreeObj( aCab )
	FreeObj( aItens )
	FreeObj( aQueryString )	

Return lRet

/*/{Protheus.doc} GET / PriceListHeaderItems/pricelist/{tableid}
Retorna uma tabela de preço específica

@param	Code	, caracter, Código da tabela de preço
@param	Order		, caracter, Ordenação da tabela principal
@param	Page		, numérico, Número da página inicial da consulta
@param	PageSize	, numérico, Número de registro por páginas
@param	Fields		, caracter, Campos que serão retornados no GET.

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

WSMETHOD GET tableid PATHPARAM Code WSRECEIVE Order, Page, PageSize, Fields WSSERVICE PriceListHeaderItems

	Local aFilter			:= {}
	Local aQueryString		:= {}
	Local cError			:= ""
	Local cIndexKey			:= "DA1_FILIAL, DA1_CODTAB, DA1_ITEM"
    Local lRet 				:= .T.
	Local oApiManager		:= Nil
	
	Default Self:Code:= ""

    Self:SetContentType("application/json")

	oApiManager := APIMANAGER():New("omss010","2.001") 

	Aadd(aFilter, {"DA0", "PriceListHeaderItems",{"DA0_CODTAB = '" + Self:Code + "'"}})
	oApiManager:SetApiFilter(aFilter) 	
	
	lRet := GetMain(@oApiManager, Self:aQueryString)

	If lRet
		Self:SetResponse( oApiManager:ToObjectJson() )
	Else
		cError := oApiManager:GetJsonError()
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf

	FreeObj( oApiManager )

	FreeObj( aFilter )
	FreeObj( aQueryString )	

Return lRet

/*/{Protheus.doc} PUT / PriceListHeaderItems/{TableID}
Altera dados da tabela de preço

@param	Code	, caracter, Código da tabela de preço

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

WSMETHOD PUT TableID PATHPARAM Code WSSERVICE PriceListHeaderItems
	Local aCab			:= {}
	Local aItens		:= {}
	Local aQueryString	:= {}
	Local aIgnore		:= {}
	Local aJson			:= {}
    Local cBody 		:= ""
	Local cError		:= ""
    Local cResp			:= "Operação Realizada com Sucesso"
    Local lRet			:= .T.
	Local oApiManager 	:= APIMANAGER():New("omss010","2.001")
    
    Default Self:Code := ""
    
	If Empty(Self:Code) .Or. !(DA0->(DbSeek(xFilial("DA0") + Self:Code)))
		lRet := .F.
		oApiManager:SetJsonError("404","Registro não encontrado!", "Informe o código da tabela.",/*cHelpUrl*/,/*aDetails*/)
	EndIf    
    
	If lRet
    	cBody 	   := Self:GetContent()
		oApiManager:SetApiQstring(Self:aQueryString)
		oApiManager:Activate()

		If oApiManager:IsActive()
			aadd(aIgnore, {'DA1_CODTAB'})
			aJson := oApiManager:GetJsonArray(cBody)
			lRet := CRMJsonToArray({'DA0','items'},{'DA1','itensTablePrices'}, aCab, aItens, aIgnore, aJson, 3)
			If lRet
				lRet := GravaTab(aCab, aItens, MODEL_OPERATION_UPDATE, Self:Code, @oApiManager)
			EndIf
		EndIf
	EndIf

	If lRet
		aAdd(aQueryString,{"code", Self:Code})
		lRet := GetMain(@oApiManager, aQueryString, .F.)
	EndIf

    If lRet
		Self:SetResponse( oApiManager:ToObjectJson() )
	Else
		cError := oApiManager:GetJsonError()
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf

    FreeObj( oApiManager )
    FreeObj( aCab )
	FreeObj( aItens )
	FreeObj( aQueryString )
	
Return lRet

/*/{Protheus.doc} DELETE / PriceListHeaderItems/{TableID}
Deleta uma tabela de preço

@param	Code	, caracter, Código da tabela de preço

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

WSMETHOD DELETE TableID PATHPARAM Code WSSERVICE PriceListHeaderItems
    Local lRet				:= .T.
	Local aMsgErro			:= {}
	Local cError			:= ""
    Local cResp				:= "Registro Deletado com Sucesso!"
	Local nX				:= 0
    Local oJsonPositions	:= JsonObject():New()
	Local oModel 		:= Nil 
	Local oModelDA0		:= Nil
	Local oModelDA1		:= Nil	
	Local oApiManager 	:= APIMANAGER():New("omss010","2.001")
    
   	Private	lAutoOMS010 := .T.
    
    Default Self:Code := ""

    cBody 	   := Self:GetContent()
    
    If lRet
	    If DA0->(DbSeek(xFilial("DA0") + Self:Code))
			oModel 	:= FwLoadModel( 'OMSA010' )
			oModel:SetOperation(5)
			oModel:Activate()
				
			oModelDA0 := oModel:GetModel('DA0MASTER')	//Model parcial Master (DA0)
			oModelDA1 := oModel:GetModel('DA1DETAIL')	//Model parcial Detail (DA1)
			
			If oModel:IsActive()
				If !oModel:VldData()
					lRet := .F.
					aMsgErro := oModel:GetErrorMessage()
					cError := ''
					
					For nX := 1 To Len(aMsgErro)
					
						If ( ValType( aMsgErro[nX] ) == 'C' )
							cError += aMsgErro[nX] + '|'
						EndIf 
						
					Next nX
					
					oApiManager:SetJsonError("400","Erro durante a exclusão da tabela de preço!",cError,/*cHelpUrl*/,/*aDetails*/)
				Else
					oModel:CommitData()
				EndIf
			EndIf
	    Else
			lRet := .F.
	    	oApiManager:SetJsonError("404","Erro durante a exclusão da tabela de preço!!","Tabela não encontrada",/*cHelpUrl*/,/*aDetails*/)
	    EndIf
    EndIf

	If lRet
		oJsonPositions['response'] := cResp
		cResp := EncodeUtf8(FwJsonSerialize( oJsonPositions, .T. ))
		Self:SetResponse( cResp )
	Else
		cError := oApiManager:GetJsonError()
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf

    FreeObj( oJsonPositions )
    FreeObj( oApiManager )
	FreeObj( aMsgErro )
	FreeObj( oModel )
	FreeObj( oModelDA0 )
	FreeObj( oModelDA1 )

Return lRet

/*/{Protheus.doc} GET / PriceListHeaderItems/pricelist/{tableid}/itensTablePrice
Retorna os itens da tabela de preço

@param	Code	, caracter, Código da tabela de preço
@param	ItemList	, caracter, Código do item da tabela de preço
@param	Order		, caracter, Ordenação da tabela principal
@param	Page		, numérico, Número da página inicial da consulta
@param	PageSize	, numérico, Número de registro por páginas
@param	Fields		, caracter, Campos que serão retornados no GET.

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

WSMETHOD GET itensTablePrice PATHPARAM Code WSRECEIVE Order, Page, PageSize, Fields  WSSERVICE PriceListHeaderItems

	Local aApiMap			:= ApiMapDA1()
	Local aFilter			:= {}
    Local lRet 				:= .T.
	Local oApiManager		:= APIMANAGER():New("omss010","2.001")
	
	Default Self:Code:= ""

    Self:SetContentType("application/json")
    
	Aadd(aFilter, {"DA1", "itensTablePrices",{"DA1_CODTAB = '" + Self:Code + "'"}})
	oApiManager:SetApiFilter(aFilter) 	

	If lRet
		lRet := GetItens(@oApiManager, Self:aQueryString)
	EndIf

	If lRet
		Self:SetResponse( oApiManager:GetJsonSerialize() )
	Else
		cError := oApiManager:GetJsonError()
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf

	FreeObj(oApiManager)
	FreeObj(aApiMap)
	FreeObj(aFilter)

Return lRet

/*/{Protheus.doc} GET / PriceListHeaderItems/pricelist/{tableid}/itensTablePrice/{ItemID}
Retorna os itens da tabela de preço

@param	Code	, caracter, Código da tabela de preço
@param	ItemList	, caracter, Código do item da tabela de preço
@param	Order		, caracter, Ordenação da tabela principal
@param	Page		, numérico, Número da página inicial da consulta
@param	PageSize	, numérico, Número de registro por páginas
@param	Fields		, caracter, Campos que serão retornados no GET.

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

WSMETHOD GET ItemID PATHPARAM Code, ItemList WSRECEIVE Order, Page, PageSize, Fields  WSSERVICE PriceListHeaderItems

	Local aApiMap			:= ApiMapDA1()
	Local aFilter			:= {}
	Local cError			:= ""
    Local lRet 				:= .T.
	Local oApiManager		:= APIMANAGER():New("omss010","2.001")
	
	Default Self:Code:= ""

    Self:SetContentType("application/json")
    
	Aadd(aFilter, {"DA1", "itensTablePrices",{"DA1_CODTAB = '" + Self:Code + "'"}})
	Aadd(aFilter, {"DA1", "itensTablePrices",{"DA1_ITEM = '" + Self:ItemList + "'"}})

	oApiManager:SetApiFilter(aFilter) 	

	If lRet
		lRet := GetItens(@oApiManager, Self:aQueryString)
	EndIf

	If lRet
		Self:SetResponse( oApiManager:ToObjectJson() )
	Else
		cError := oApiManager:GetJsonError()
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf

	FreeObj(oApiManager)
	FreeObj(aApiMap)
	FreeObj(aFilter)

Return lRet

/*/{Protheus.doc} PUT / PriceListHeaderItems/pricelist/{tableid}/itensTablePrice/{ItemID}
Altera um item da tabela de preço

@param	Code	, caracter, Código da tabela de preço
@param	ItemList	, caracter, Código do item da tabela de preço

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

WSMETHOD PUT ItemID PATHPARAM Code, ItemList WSRECEIVE Fields WSSERVICE PriceListHeaderItems
	Local aApiMap		:= ApiMapDA1()
	Local aCab			:= {}
	Local aItem			:= {}
	Local aFilter		:= {}
	Local aItens		:= {}
	Local aQueryString	:= {}
	Local aIgnore		:= {}
	Local aJson			:= {}
    Local cBody 		:= ""
	Local cError		:= ""
    Local cResp			:= "Operação Realizada com Sucesso"
    Local lRet			:= .T.
	Local oApiManager 	:= APIMANAGER():New("omss010","2.001")
    
    Default Self:Code 	:= ""
    Default Self:ItemList		:= ""
	
	Aadd(aFilter, {"DA1", "itensTablePrices",{"DA1_CODTAB = '" + Self:Code + "'"}})
	Aadd(aFilter, {"DA1", "itensTablePrices",{"DA1_ITEM = '" + Self:ItemList + "'"}})
	oApiManager:SetApiFilter(aFilter)

	oApiManager:SetApiMap(aApiMap)

	If lRet
	    cBody 	   := Self:GetContent()
		oApiManager:SetApiQstring(Self:aQueryString)
		oApiManager:Activate()
		IF !oApiManager:IsActive()
			lRet := .F.
		Else
			aadd(aIgnore, {'DA1_CODTAB','DA1_ITEM'})
			aJson := oApiManager:GetJsonArray(cBody)
			If CRMJsonToArray({'DA1','items'},Nil, aItens, Nil, aIgnore, aJson, 1)
				aAdd(aItem, aItens)
				If Len(aJson[1][4]) == 1 
					aAdd(aItem[1],{"DA1_ITEM", Self:ItemList, Nil})
					lRet := GravaItem(aItem, @cResp, Self:Code, 4, @oApiManager)
				Else
					lRet := .F.
					oApiManager:SetJsonError("400","Itens incompatíveis!", "Só é possível alterar um item. Verifique os dados informados",/*cHelpUrl*/,/*aDetails*/)
				EndIf
			Else
					lRet := .F.
					oApiManager:SetJsonError("400","Itens incompatíveis!", "Não foi possível converter o json informado.",/*cHelpUrl*/,/*aDetails*/)			
	    	EndIf
		EndIf
	EndIf

	If lRet
		lRet := GetItens(@oApiManager, Self:aQueryString, .F.)
	EndIf

	If lRet
		Self:SetResponse( oApiManager:ToObjectJson())
	Else
		cError := oApiManager:GetJsonError()
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf

    oApiManager:Destroy()
	FreeObj( aApiMap )
    FreeObj( aCab )
	FreeObj( aItens )	
	FreeObj( aQueryString )	

Return lRet

/*/{Protheus.doc} POST / PriceListHeaderItems/pricelist/{tableid}/itensTablePrice
Incluir um item na tabela de preço

@param	Code	, caracter, Código da tabela de preço

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

WSMETHOD POST itensTablePrice PATHPARAM Code WSSERVICE PriceListHeaderItems
	Local aApiMap		:= ApiMapDA1()
	Local aCab			:= {}
	Local aItem			:= {}
	Local aItens		:= {}
	Local aQueryString	:= Self:aQueryString
	Local aJson			:= {}
	Local aIgnore		:= {}
    Local cBody 		:= ""
	Local cError		:= ""
    Local cResp			:= "Operação Realizada com Sucesso"
    Local lRet			:= .T.
	Local oApiManager 	:= APIMANAGER():New("omss010","2.001")

	oApiManager:SetApiMap(aApiMap)

    Default Self:Code 	:= ""
    
	If lRet
	    cBody 	   := Self:GetContent()
		oApiManager:SetApiQstring(aQueryString)
		oApiManager:Activate()

		If !oApiManager:IsActive()
			lRet := .F.
		Else
			aadd(aIgnore, {'DA1_CODTAB'})
			aJson := oApiManager:GetJsonArray(cBody)	
			If CRMJsonToArray({'DA1','items'},Nil, aItens, Nil, aIgnore, aJson, 1)
				aAdd(aItem, aItens)
				lRet := GravaItem(aItem, @cResp, Self:Code, 3, @oApiManager)
		    EndIf
		EndIf
	EndIf

	If lRet
		aAdd(aQueryString,{"code", Self:Code})
			aAdd(aQueryString,{"itemList"	, DA1->DA1_ITEM})

		lRet := GetItens(@oApiManager, aQueryString, .F.)
	EndIf	

	If lRet
		Self:SetResponse( oApiManager:ToObjectJson() )
	Else
		cError := oApiManager:GetJsonError()
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf

    oApiManager:Destroy()
    FreeObj( aApiMap )
	FreeObj( aCab )
	FreeObj( aItens ) 
	FreeObj( aQueryString )
		
Return lRet


/*/{Protheus.doc} DELETE / PriceListHeaderItems/pricelist/{tableid}/itensTablePrice/{ItemID}
Deleta um item da tabela de preço

@param	Code	, caracter, Código da tabela de preço
@param	ItemList	, caracter, Código do item da tabela de preço

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

WSMETHOD DELETE ItemID PATHPARAM Code, ItemList WSRECEIVE ItemList WSSERVICE PriceListHeaderItems
    Local aBusca			:= {}
	Local aMsgErro			:= {}
	Local cResp			 	:= "Operação Realizada com Sucesso"
    Local lRet			 	:= .T.
	Local nX				:= 0
    Local oJsonPositions	:= JsonObject():New()
	Local oModel 		:= Nil 
	Local oModelDA0		:= Nil
	Local oModelDA1		:= Nil
	Local oApiManager 		:= APIMANAGER():New("omss010","2.001")
    
   	Private	lAutoOMS010 := .T.
    
    Default Self:Code 	:= ""
    Default Self:ItemList 		:= ""

    cBody 	   := Self:GetContent()
    
    If lRet
	    If DA0->(DbSeek(xFilial("DA0") + Self:Code))
			oModel 	:= FwLoadModel( 'OMSA010' )
			oModel:SetOperation(4)
			oModel:Activate()

			If oModel:IsActive()	
				oModelDA0 := oModel:GetModel('DA0MASTER')	//Model parcial Master (DA0)
				oModelDA1 := oModel:GetModel('DA1DETAIL')	//Model parcial Detail (DA1)
				
				aBusca := {}
				aAdd( aBusca, { 'DA1_CODTAB', DA0->DA0_CODTAB 	} )	
				aAdd( aBusca, { 'DA1_ITEM'	, Self:ItemList		} )					

				If (oModelDA1:SeekLine( aBusca ))
					If !oModelDA1:DeleteLine() .Or. !oModel:VldData()
						lRet := .F.
						aMsgErro := oModel:GetErrorMessage()
						cError := ''
						
						For nX := 1 To Len(aMsgErro)
						
							If ( ValType( aMsgErro[nX] ) == 'C' )
								cError += aMsgErro[nX] + '|'
							EndIf 
							
						Next nX
						
						oApiManager:SetJsonError("400","Erro durante a exclusão da tabela de preço!",cError,/*cHelpUrl*/,/*aDetails*/)
					Else
						oModel:CommitData()
					EndIf
				Else
					lRet := .F.
					oApiManager:SetJsonError("404","Erro durante a exclusão da tabela de preço!!","Item da Tabela não encontrado",/*cHelpUrl*/,/*aDetails*/)
				EndIf
			EndIf
	    Else
			lRet := .F.
	    	oApiManager:SetJsonError("404","Erro durante a exclusão da tabela de preço!!","Tabela não encontrada",/*cHelpUrl*/,/*aDetails*/)
	    EndIf
    EndIf

	If lRet
		oJsonPositions['response'] := cResp
		cResp := EncodeUtf8(FwJsonSerialize( oJsonPositions, .T. ))
		Self:SetResponse( cResp )
	Else
		cError := oApiManager:GetJsonError()
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf

	oApiManager:Destroy()
    FreeObj( oJsonPositions )
	FreeObj( aBusca )
	FreeObj( aMsgErro )
	FreeObj( oModel )
	FreeObj( oModelDA0 )
	FreeObj( oModelDA1 )

Return lRet

/*/{Protheus.doc} GravaTab
Realiza manutenção na tabela de preço.

@param	aCab		, array		, Dados do cabeçalho da tabela de preço
@param	aItens		, array		, Dados dos itens da tabela de preço
@param	nOper		, numérico	, Operação realizada (Inlusão/Alteração)
@param	cCodTab		, caracter	, Código da tabela de preço
@param	oApiManager	, objeto , Objeto ApiManager

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

Static Function GravaTab(aCab, aItens, nOper, cCodTab, oApiManager)
	Local oModel 		:= Nil 
	Local oModelDA0		:= Nil
	Local oModelDA1		:= Nil
	Local aBusca 		:= {}
	Local aMsgErro		:= {}
	Local cResp			:= ""
	Local lRet			:= .T.
	Local nPosTab		:= nPosTab := aScan( aCab, { |x| x[1] == 'DA0_CODTAB' } )
	Local nPosItem		:= 0
	Local nLenaCab		:= Len(aCab)
	Local nLenaItens	:= Len(aItens)
	Local nLenaItnX		:= 0
	Local nX			:= 0
	Local nY			:= 0
	
	Default aCab		:= {}
	Default aItens		:= {}
	Default nOper		:= {}
	Default cResp		:= ""
	Default cCodTab		:= IIF(nPosTab > 0, DA0->(DbSeek(xFilial("DA0") + aCab[nPosTab][2])), "")

	Private	lAutoOMS010 := .T.

	If (nOper == MODEL_OPERATION_INSERT) .Or. ( nOper == MODEL_OPERATION_UPDATE .And. nPosTab > 0 .And. DA0->(DbSeek(xFilial("DA0") + cCodTab)))
		
		oModel 	:= FwLoadModel( 'OMSA010' )
		oModel:SetOperation(nOper)
		oModel:Activate()
			
		oModelDA0 := oModel:GetModel('DA0MASTER')	//Model parcial Master (DA0)
		oModelDA1 := oModel:GetModel('DA1DETAIL')	//Model parcial Detail (DA1)
		
		For nX := 1 To nLenaCab
			If oModelDA0:CanSetValue(aCab[nX][1])//Verifica os campos que não podem ser editados
				oModelDA0:SetValue( aCab[nX][1], aCab[nX][2] )
			EndIf
		Next
		
		For nX := 1 To nLenaItens
			If nOper == MODEL_OPERATION_UPDATE
				nPosItem 	:= aScan( aItens[nX], { |x| x[1] == 'DA1_ITEM' } )	//Posicao do Cod. Produto no array
				If nPosItem > 0
					aBusca := {}
					aAdd( aBusca, { 'DA1_CODTAB', DA0->DA0_CODTAB } )	
					aAdd( aBusca, { 'DA1_ITEM', aItens[nX][nPosItem][2] } )	
					If !(oModelDA1:SeekLine( aBusca ))
						lRet := .F. 
						oApiManager:SetJsonError("400","Não foi possível realizar alterar o item na tabela!","Item: " + AllTrim(aItens[nX][nPosItem][2]) + "não encontrado",/*cHelpUrl*/,/*aDetails*/)
					EndIf
				EndIf
			Elseif nX > 1 
				nAux := oModelDA1:Length()
				If ( !oModelDA1:AddLine() == nAux + 1 )
				     lRet := .F. 
					 oApiManager:SetJsonError("400","Não foi possível realizar incluir um novo item na tabela!","Item: " + AllTrim(Str(nAux)),/*cHelpUrl*/,/*aDetails*/)
				EndIf			
			EndIf

			nLenaItnX := Len(aItens[nX])	
			
			For nY := 1 To nLenaItnX
				If oModelDA1:CanSetValue(aItens[nX][nY][1])
					oModelDA1:SetValue( aItens[nX][nY][1], aItens[nX][nY][2] )
				EndIf
			Next
			aBusca := Nil
		Next
		
		If lRet .And. oModel:VldData()
			oModel:CommitData()
		Else
			lRet := .F.
		    aMsgErro := oModel:GetErrorMessage()
		    cResp := ''
		    
		    For nX := 1 To Len(aMsgErro)
		    
		    	If ( ValType( aMsgErro[nX] ) == 'C' )
					cResp += aMsgErro[nX] + '|'
				EndIf 
				
			Next nX
			
			oApiManager:SetJsonError("400","Erro ao alterar a tabela de preço!", cResp,/*cHelpUrl*/,/*aDetails*/)
		EndIf
	Else
		lRet	:= .F.
		oApiManager:SetJsonError("400","Não foi possível realizar incluir um novo item na tabela!","Verifique os dados informados",/*cHelpUrl*/,/*aDetails*/)
	EndIf

	FreeObj( aBusca )
	FreeObj( aMsgErro )
	FreeObj( oModel )
	FreeObj( oModelDA0 )
	FreeObj( oModelDA1 )	
Return lRet

/*/{Protheus.doc} GravaItem
Realiza manutenção nos itens da tabela de preço.

@param	aItens		, array		, Dados dos itens da tabela de preço
@param	cResp		, caracter	, Retorno da operação
@param	cCodTab		, caracter	, Código da tabela de preço
@param	nTipo		, caracter	, Informa se é uma inclusão ou alteração de item
@param oApiManager	, object	, Objeto ApiManager

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

Static Function GravaItem(aItens, cResp, cCodTab, nTipo, oApiManager)
	Local aBusca		:= {}
	Local aMsgErro		:= {}
	Local cNewItem		:= ""
	Local lRet			:= .T.
	Local nLenaItens	:= Len(aItens)
	Local nLenaItnX		:= 0	
	Local nPosItem		:= 0
	Local nX			:= 0
	Local nY			:= 0
	Local oModel 		:= Nil 
	Local oModelDA0		:= Nil
	Local oModelDA1		:= Nil

	Default aItens		:= {}
	Default cResp		:= ""
	Default cCodTab		:= ""
	Default nTipo		:= 4

	Private	lAutoOMS010 := .T.
	
	If DA0->(DbSeek(xFilial("DA0") + cCodTab))
	
		oModel 	:= FwLoadModel( 'OMSA010' )
		oModel:SetOperation(4)
		oModel:Activate()
			
		oModelDA0 := oModel:GetModel('DA0MASTER')	//Model parcial Master (DA0)
		oModelDA1 := oModel:GetModel('DA1DETAIL')	//Model parcial Detail (DA1)
	
		For nX := 1 To nLenaItens
			nPosItem 	:= aScan( aItens[nX], { |x| x[1] == 'DA1_ITEM' } )	//Posicao do Cod. Produto no array
			If nTipo == 4 .And. nPosItem > 0
				aBusca := {}
				aAdd( aBusca, { 'DA1_CODTAB', DA0->DA0_CODTAB } )	
				aAdd( aBusca, { 'DA1_ITEM', aItens[nX][nPosItem][2] } )	
				If !(oModelDA1:SeekLine( aBusca ))
					lRet	:= .F.
					oApiManager:SetJsonError("404","Erro durante a alteração da tabela de preço!!","Item " + aItens[nX][nPosItem][2] + "não encontrado",/*cHelpUrl*/,/*aDetails*/)
					Exit
				EndIf
			Else 
				nAux := oModelDA1:Length()
				If oModelDA1:GoLine(nAux)
					cNewItem := Soma1(oModelDA1:GetValue("DA1_ITEM"))
					If ( !oModelDA1:AddLine() == nAux + 1 )
						lRet	:= .F.
						oApiManager:SetJsonError("404","Erro durante a alteração da tabela de preço!!","Problema ao editar o item " + aItens[nX][nPosItem][2],/*cHelpUrl*/,/*aDetails*/)
						Exit
					EndIf
	
					If oModelDA1:CanSetValue("DA1_ITEM")
						lRet := oModelDA1:SetValue( "DA1_ITEM", cNewItem )
					EndIf					
				EndIf
			EndIf
				
			nLenaItnX := Len(aItens[nX])

			For nY := 1 To nLenaItnX
				If AllTrim(aItens[nX][nY][1]) != "DA1_CODTAB"
					If oModelDA1:CanSetValue(aItens[nX][nY][1])
						lRet := oModelDA1:SetValue( aItens[nX][nY][1], aItens[nX][nY][2] )
					EndIf
				EndIf
			Next
		Next
		
		If lRet .And. oModel:VldData()
			oModel:CommitData()
		Else
			lRet := .F.
		    aMsgErro := oModel:GetErrorMessage()
		    cResp := ''
		    
		    For nX := 1 To Len(aMsgErro)
		    
		    	If ( ValType( aMsgErro[nX] ) == 'C' )
					cResp += aMsgErro[nX] + '|'
				EndIf 
				
			Next nX
			oApiManager:SetJsonError("400","Erro durante a alteração da tabela de preço!!",cResp,/*cHelpUrl*/,/*aDetails*/)	
		EndIf
	Else
		lRet := .F.
		oApiManager:SetJsonError("404","Erro durante a alteração da tabela de preço!!","Tabela não encontrado",/*cHelpUrl*/,/*aDetails*/)
	EndIf

	FreeObj( aBusca )
	FreeObj( aMsgErro )
	FreeObj( oModel )
	FreeObj( oModelDA0 )
	FreeObj( oModelDA1 )	
Return lRet

/*/{Protheus.doc} GetMain
Realiza o Get considerando cabeçalho e filho (DA0 e DA1)

@param oApiManager	, Objeto	, Objeto ApiManager inicializado no método 
@param aQueryString	, Array		, Array com os filtros a serem utilizados no Get
@param lHasNext		, Lógico	, Informa se informará se existem ou não mais páginas a serem exibidas

@return lRet	, Lógico	, Retorna se conseguiu ou não processar o Get.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

Static Function GetMain(oApiManager, aQueryString, lHasNext)
	Local aRelation 		:= {{"DA0_FILIAL","DA1_FILIAL"},{"DA0_CODTAB","DA1_CODTAB"}}
	Local aChildrenAlias	:= {"DA1", "itensTablePrices", "itensTablePrices"}
	Local aFatherAlias		:= {"DA0", "items", "PriceListHeaderItems"}
	Local cIndexKey			:= "DA1_FILIAL, DA1_CODTAB, DA1_ITEM"
    Local lRet 				:= .T.

	Default aQueryString	:={,}
	Default oApiManager		:= Nil
	Default lHasNext		:= .T.

	lRet := ApiMainGet(@oApiManager, aQueryString, aRelation , aChildrenAlias, aFatherAlias, cIndexKey, oApiManager:GetApiAdapter(), oApiManager:GetApiVersion(), lHasNext)

	FreeObj( aRelation )
	FreeObj( aChildrenAlias )
	FreeObj( aFatherAlias )

Return lRet

/*/{Protheus.doc} GetItens
Realiza o Get considerando o filho (DA1)

@param oApiManager	, Objeto	, Objeto ApiManager inicializado no método 
@param aQueryString	, Array		, Array com os filtros a serem utilizados no Get
@param lHasNext		, Lógico	, Informa se informará se existem ou não mais páginas a serem exibidas

@return lRet	, Lógico	, Retorna se conseguiu ou não processar o Get.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

Static Function GetItens(oApiManager, aQueryString, lHasNext)
	Local aApiMap			:= ApiMapDA1()
	Local aFatherAlias		:= {"DA1","items", "itensTablePrices"}
    Local lRet 				:= .T.

	Default aQueryString	:={,}
	Default oApiManager		:= Nil
	Default lHasNext		:= .T.
	
	oApiManager:SetApiMap(aApiMap)
	oApiManager:SetApiAlias(aFatherAlias)

	lRet := ApiMainGet(@oApiManager, aQueryString, , , aFatherAlias, , oApiManager:GetApiAdapter(), oApiManager:GetApiVersion(), lHasNext)

	FreeObj( aApiMap )
	FreeObj( aFatherAlias )

Return lRet

/*/{Protheus.doc} ApiMap
Estrutura a ser utilizada na classe ServicesApiManager

@return cRet	, caracter	, Mensagem de retorno de sucesso/erro.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

Static Function ApiMap()
	Local apiMap		:= {}
	Local aStructDA0    := {}
	Local aStructDA1    := {}
	Local aStructAlias  := {}
	
	aStructDA0    :=	{"DA0","Field","items","PriceListHeaderItems",;
							{;
								{"branchId"					, "Exp:cFilAnt"													},;
								{"companyInternalId"		, "Exp:cEmpAnt, Exp:cFilAnt"									},;
								{"internalId"				, "Exp:cEmpAnt, DA0_FILIAL, DA0_CODTAB"							},;
								{"companyId"				, "Exp:cEmpAnt"													},;
								{"code"						, "DA0_CODTAB"													},;
								{"name"						, "DA0_DESCRI"													},;
								{"initialDate"				, "DA0_DATDE" 													},;
								{"finalDate"				, "DA0_DATATE"													},;
								{"initiaHour"				, "DA0_HORADE"													},;
								{"finalHour"				, "DA0_HORATE"													},;
								{"valueDescount"			, ""															},;
								{"activeTablePrice"			, "DA0_ATIVO"													};
							},;
						}
							
	aStructDA1    := 	{"DA1","Item","itensTablePrices","itensTablePrices",;
							{;
								{"code"						, "DA1_CODTAB"													},;
								{"itemList"					, "DA1_ITEM"  													},;
								{"itemCode"					, "DA1_CODPRO"													},;
								{"itemInternalId"			, "Exp:cEmpAnt, DA1_FILIAL, DA1_CODPRO, DA1_CODTAB, DA1_ITEM"	},;
								{"referenceCode"			, ""															},;
								{"unitOfMeasureCode"		, ""															},;
								{"minimumSalesPrice"		, "DA1_PRCVEN"													},;
								{"minimumSalesPriceFOB"		, ""															},;								
								{"discountValue"			, "DA1_VLRDES"													},;
								{"discountFactor"			, "DA1_PERDES"													},;
								{"minimumAmount"			, ""															},;
								{"cifPrice"					, ""															},;
								{"fobPrice"					, ""															},;
								{"itemValidity"				, "DA1_DATVIG"													},;
								{"typePrice"				, ""															},;
								{"activeItemPrice"			, "DA1_ATIVO"													};																					
							},;
						}
	
	aStructAlias  := {aStructDA0, aStructDA1}
	
	apiMap := {"OMSS010","items","2.001","OMSA010",aStructAlias,"PriceListHeaderItems"}

Return apiMap

/*/{Protheus.doc} ApiMapDA1
Estrutura a ser utilizada na classe ServicesApiManager para a tabela DA1

@return cRet	, caracter	, Mensagem de retorno de sucesso/erro.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

Static Function ApiMapDA1()
	Local apiMap		:= {}
	Local aStructDA1    := {}
	Local aStructAlias  := {}
							
	aStructDA1    := 	{"DA1","Field","items","itensTablePrices",;
							{;
								{"code"						, "DA1_CODTAB"													},;
								{"itemList"					, "DA1_ITEM"  													},;
								{"itemCode"					, "DA1_CODPRO"													},;
								{"itemInternalId"			, "Exp:cEmpAnt, DA1_FILIAL, DA1_CODPRO, DA1_CODTAB, DA1_ITEM"	},;
								{"referenceCode"			, ""															},;
								{"unitOfMeasureCode"		, ""															},;
								{"minimumSalesPrice"		, "DA1_PRCVEN"													},;
								{"minimumSalesPriceFOB"		, ""															},;								
								{"discountValue"			, "DA1_VLRDES"													},;
								{"discountFactor"			, "DA1_PERDES"													},;
								{"minimumAmount"			, ""															},;
								{"cifPrice"					, ""															},;
								{"fobPrice"					, ""															},;
								{"itemValidity"				, "DA1_DATVIG"													},;
								{"typePrice"				, ""															},;
								{"activeItemPrice"			, "DA1_ATIVO"													};																					
							},;
						}
	
	aStructAlias  := {aStructDA1}
	
	apiMap := {"OMSS010","items","2.001","OMSA010",aStructAlias,"itensTablePrices"}

Return apiMap