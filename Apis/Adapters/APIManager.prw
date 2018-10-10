#INCLUDE "TOTVS.CH"

#DEFINE PROPERT     1
#DEFINE VALUE       2

#DEFINE RELATION_ALIAS			1
#DEFINE RELATION_ALIASFATHER	2
#DEFINE RELATION_CONDITIONS		3
#DEFINE RELATION_INDEXKEY		4
#DEFINE RELATION_CHILDRENSCHEMA 5
#DEFINE RELATION_FATHERSCHEMA	6
#DEFINE RELATION_CHILDRENNICK	7
#DEFINE RELATION_FATHERNICK		8 

#DEFINE RELITEM_FIELDFATHER		1
#DEFINE RELITEM_FIELDCHILDREN	2

#DEFINE APIMAP_ADAPTER			1
#DEFINE APIMAP_ALIAS			1
#DEFINE APIMAP_STRUCT			1
#DEFINE APIMAP_FIELDAPI			1
#DEFINE APIMAP_TYPE				2
#DEFINE APIMAP_FIELDPROTHEUS	2
#DEFINE APIMAP_NAME				2
#DEFINE APIMAP_VERSION			3
#DEFINE APIMAP_ITEMINFO			3
#DEFINE APIMAP_ITEMNICK			4
#DEFINE APIMAP_FIELDS			5
#DEFINE APIMAP_LIST        		5

#DEFINE ASTRUCT_FIELDAPI		1
#DEFINE ASTRUCT_FIELDPROTHEUS	2
#DEFINE ASTRUCT_TYPE			2
#DEFINE ASTRUCT_NAME			3
#DEFINE ASTRUCT_FIELDS			5

#DEFINE AFILTRO_ALIAS			1
#DEFINE AFILTRO_ALIASAPI		2
#DEFINE AFILTRO_VALUE			1
#DEFINE AFILTRO_FILTER			1
#DEFINE AFILTRO_FIELDS			3

#DEFINE ACHILDRENALIAS          1
#DEFINE AFATHERALIAS            1
#DEFINE ACHILDRENALIAS_SCHEMA   2
#DEFINE AFATHERALIAS_SCHEMA     2

#DEFINE ASTRAUX_NICKCHILD		1
#DEFINE ASTRAUX_FIELDAPI		1
#DEFINE ASTRAUX_FIELDPROT		2
#DEFINE ASTRAUX_NICKFATHER		2
#DEFINE ASTRAUX_CHILD			3
#DEFINE ASTRAUX_FATHER			4
#DEFINE ASTRAUX_TYPE			5
#DEFINE ASTRAUX_ALIAS			6
#DEFINE ASTRAUX_FIELDS			7

//dummy function
Function APIManager()
Return
//-------------------------------------------------------------------
/*/{Protheus.doc} APIManager
Classe utilizada para converter campos de API em campos protheus, 
parsear Json recebidos, converter Jsons em arrays e controlar o De/PARA
entre Protheus e API de acordo com o ApiMap informado

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Class APIManager
	Data aApiMap        As Array
	Data aError         As Array
	Data aFields        As Array
	Data aFilter		As Array
	Data aExpFilter		As Array
	Data aFieldFilter	As Array
	Data aJson			As Array
	Data aRelations     As Array
	Data cAlias         As Character
	Data cAliasApi		As Character
	Data cNickAlias		As Character
	Data cAdapter       As Character
	Data cApiName       As Character
	Data cIndexFather	As Character
	Data cVersion       As Character
	Data nPage          As Numeric
	Data nPageSize      As Numeric
	Data oFieldsJson    As Object
	Data oJsonData		As Object
	Data oJsonError     As Object
	Data lUseHasNext	As Logical
	Data lActive        As Logical
	Data aStrucJson		As Array

	Method New(cAdapter,cVersion) Constructor

	Method SetApiAdapter()
	Method SetApiQstring() 
	Method SetApiVersion()
	Method SetApiAlias()
	Method SetApiHasNext()
	Method SetApiFilter()
	Method SetExpFilter()
	Method SetApiFields()
	Method SetApiMap()
	Method SetApiRelation()
	Method SetIndexKey()
	Method SetJson()
	Method SetJsonObject()
	Method SetPage()
	Method SetPageSize()
	Method SetJsonError()

	Method GetApiAdapter()
	Method GetApiPage()
	Method GetApiPgSize()
	Method GetApiFilter()
	Method GetExpFilter()
	Method GetProtField()
	Method GetEstJson()
	Method GetApiVersion()
	Method GetApiMap()
	Method GetApiRelation()
	Method GetApiAlias()
	Method GetApiFields()
	Method GetJsonObject()
	Method ToJsonArray()
	Method GetJsonArray()
	Method GetJsonSerialize()
	Method ToObjectJson()
	Method ToArray()
	Method ToExecAuto()
	Method GetOrderKey()
	Method GetProtInfo()
	Method GetJsonError()

	Method Activate()
	Method IsActive()
	Method Destroy()

EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} New
M�todo Construtor

@param cAdapter   , caracter, Infor,a o adapter a ser utilizado para iniciar o objeto
@param cVersion   , caracter, informa a vers�o do adapter

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method New(cAdapter, cVersion) Class APIManager
	Default cAdapter    := ''
	Default cVersion    := ''

	Self:aJson			:= {}
	Self:aStrucJson		:= {}
	Self:aApiMap        := {}
	Self:aFieldFilter	:= {}
	Self:aError        	:= {}
	Self:aFields        := {}
	Self:aFilter		:= {}
	Self:aExpFilter		:= {}
	Self:aRelations     := {}
	Self:cAdapter       := cAdapter
	Self:cVersion       := cVersion
	Self:cAlias         := ""
	Self:cIndexFather	:= ""
	Self:cApiName       := ""
	Self:cAliasApi		:= ""
	Self:cNickAlias		:= ""
	Self:nPage          := 1
	Self:nPageSize      := 20
	Self:oJsonData      := Nil
	Self:oFieldsJson	:= Nil
	Self:oJsonError		:= Nil
	Self:lUseHasNext	:= .T.
	Self:lActive        := .F.
Return Self

//-------------------------------------------------------------------
/*/{Protheus.doc} SetApiAdapter
M�todo que atribui o nome do fonte respons�vel pelo Adapter

@param cAdapter   , caracter, Infora o adapter a ser utilizado para iniciar o objeto

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetApiAdapter(cAdapter) Class APIManager
	Default cAdapter  := ""
	If Empty(cAdapter) .And. !Empty(Self:aApiMap) .And. !Empty(Self:aApiMap[APIMAP_ADAPTER])
		Self:cAdapter := Self:aApiMap[APIMAP_ADAPTER]
	Else
		Self:cAdapter := cAdapter
	EndIf
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetApiQstring
M�todo que seta o Fields, PageSize, Page, Order e Filtros no ApiMap

@param aQueryString   , array, Par�metros passados na chamada do WebService (Self:aQueryString)

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetApiQstring(aQueryString) Class APIManager
    Local aChave		:= {}
	Local cChave		:= ""
	Local cApiValue     := ''
	Local cNickName		:= ""
    Local cStringValue  := ''
    Local nQueryString  := 0
    Local nLen          := len(aQueryString)
    Local aMyFilter     := {}
	Local aExpFilter	:= {}

    Default aQueryString := {}
   
	For nQueryString := 1 to nLen
		Do Case
			Case Upper(aQueryString[nQueryString][1]) == "PAGE"
				Self:SetPage( aQueryString[nQueryString][2] )
			
			Case Upper(aQueryString[nQueryString][1]) == "PAGESIZE"
				Self:SetPageSize( aQueryString[nQueryString][2] )
			
			Case Upper(aQueryString[nQueryString][1]) == "ORDER"
				Self:SetIndexKey( aQueryString[nQueryString][2] )

			Case Upper(aQueryString[nQueryString][1]) == "FIELDS"
				Self:SetApiFields(aQueryString[nQueryString][2])

			OtherWise
				cChave			:= "items."+aQueryString[nQueryString][1]
				aChave			:= StrToArray(Upper(cChave), ".")
				cNickName		:= aChave[Len(aChave)-1]  
				cApiValue       := Self:GetProtField(@cNickName, aChave[Len(aChave)], cChave )
				cStringValue    := aQueryString[nQueryString][2]
				If !Empty(cApiValue)
					aAdd(aMyFilter, {Self:cAlias, cNickName,{ cApiValue + " = " + "'" + cStringValue + "'" }  })
				Else
					aAdd(aExpFilter, {aQueryString[nQueryString][1], cNickName,{ cStringValue }  })					
				EndIf
		EndCase 
	Next nQueryString
   

	If Len(aMyFilter) > 0
		Self:SetApiFilter(aMyFilter)
	EndIf

	If Len(aExpFilter) > 0
		Self:SetExpFilter(aExpFilter)
	EndIf	

	FreeObj(aChave)
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetApiVersion
M�todo que atribui a vers�o do Swagger utilizado

@param cVersion   , caracter, informa a vers�o do adapter

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetApiVersion(cVersion) Class APIManager
	Default cVersion  := ""
	If Empty(cVersion) .And. !Empty(Self:aApiMap) .And. !Empty(Self:aApiMap[APIMAP_VERSION])
		Self:cVersion := Self:aApiMap[APIMAP_VERSION]
	Else
		Self:cVersion := cVersion
	EndIf
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetApiMap
M�todo que atribui array com o ApiMap a ser utilizado

@param aApiMap , array, Dados do adapter utilizado no objeto

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetApiMap(aApiMap) Class APIManager
	Default aApiMap	:= {}
	Self:aApiMap := aApiMap
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetApiRelation
M�todo que atribui array com relacionamento entre entidades, utilizado
quando o ADAPTER utiliza cabe�alhoxItens

@param aChildrenAlias , array   , Nome do Alias Filho[1] e Alias Filho API[2]
@param aFatherAlias   , array   , Nome do Alias Pai[1] e Alias Pai API[2]
@param aConditions    , array   , Array contendo as amarra��es entre pai e filho
@param cIndexKey      , caracter, Ordem utilizada no alias filho

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetApiRelation(aChildrenAlias,aFatherAlias,aConditions,cIndexKey) Class APIManager
	Local nPos  := aScan(Self:aRelations,{|x| x[1] == aChildrenAlias[ACHILDRENALIAS_SCHEMA] .And. x[2] == aFatherAlias[AFATHERALIAS_SCHEMA] .And. x[3] == aFatherAlias[AFATHERALIAS_SCHEMA]})

	Default aChildrenAlias		:= {}
	Default aFatherAlias		:= {}
	Default aConditions			:= {}
	Default cIndexKey			:= ""
	
	If nPos == 0
		aAdd(Self:aRelations,{aChildrenAlias[ACHILDRENALIAS],aFatherAlias[AFATHERALIAS],aConditions,cIndexKey,aChildrenAlias[ACHILDRENALIAS_SCHEMA],aFatherAlias[AFATHERALIAS_SCHEMA], aChildrenAlias[3], aFatherAlias[3] })
	Else
		Self:aRelations[nPos][RELATION_ALIAS]		    := aChildrenAlias[ACHILDRENALIAS]
		Self:aRelations[nPos][RELATION_ALIASFATHER]	    := aFatherAlias[AFATHERALIAS]
		Self:aRelations[nPos][RELATION_CONDITIONS]	    := aConditions
		Self:aRelations[nPos][RELATION_INDEXKEY]	    := cIndexKey
		Self:aRelations[nPos][RELATION_CHILDRENSCHEMA]  := aChildrenAlias[ACHILDRENALIAS_SCHEMA]
		Self:aRelations[nPos][RELATION_FATHERSCHEMA]    := aFatherAlias[AFATHERALIAS_SCHEMA]
		Self:aRelations[nPos][RELATION_CHILDRENNICK]   	:= aChildrenAlias[3]
		Self:aRelations[nPos][RELATION_FATHERNICK] 	:= aFatherAlias[3]
	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetApiAlias
M�todo que atribui o Alias e AliasApi da tabela Protheus 

@param aAlias , array, Nome do Alias[1] e AliasApi[2] da tabela principal do adapter

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetApiAlias(aAlias) Class APIManager
	Default aAlias   := {}

	If Len(aAlias) == 0 .And. !Empty(Self:aApiMap) .And. !Empty(Self:aApiMap[APIMAP_LIST])
		Self:cAlias 	:= Self:aApiMap[APIMAP_LIST][APIMAP_STRUCT][APIMAP_ALIAS]
		Self:cAliasApi	:= Self:aApiMap[APIMAP_LIST][APIMAP_ALIAS][APIMAP_ITEMINFO]
		Self:cNickAlias	:= Self:aApiMap[APIMAP_LIST][APIMAP_ALIAS][APIMAP_ITEMNICK]
	Else
		Self:cAlias 	:= aAlias[1]
		Self:cAliasApi	:= aAlias[2]
		Self:cNickAlias := aAlias[3]
	EndIf
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetApiHasNext
M�todo que define se retornar� ou n�o se existem mais p�ginas

@param lHasNext , l�gica, Informa se o retornar� o par�metro de pagina��o ou n�o

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetApiHasNext(lHasNext) Class APIManager
	Default lHasNext	:= .T.
Return Self:lUseHasNext := lHasNext


//-------------------------------------------------------------------
/*/{Protheus.doc} SetApiFilter
M�todo que atribui um filtro de pesquisa

@param aFilter   , array, Array contendo o filtro a ser executado. Exemplo := {Alias,{alias.campo1 = xxx}, {alias.campo2 = yyy}}

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetApiFilter (aFilter) Class APIManager
	Local aRet	:= Self:aFilter
	Local nLen	:= Len(aFilter)
	Local nX	:= 0

	Default	aFilter	:= {}
	
	For nX := 1 To nLen
		nPosaRet := Ascan(aRet,{|x| x[AFILTRO_ALIASAPI] == aFilter[nX][AFILTRO_ALIASAPI]})
		If nPosaRet > 0
			aAdd(aRet[nPosaRet][3],aFilter[nX][AFILTRO_FIELDS][AFILTRO_VALUE])
		Else
			aAdd(aRet,{aFilter[nX][1],aFilter[nX][2],{aFilter[nX][AFILTRO_FIELDS][AFILTRO_VALUE]}})
		EndIf
	Next nX

	Self:aFilter := aRet
	
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetExpFilter
M�todo que atribui um filtro de pesquisa para um campo macroexecut�vel

@param aFilter   , array, Array contendo o filtro a ser executado. Exemplo := {Alias,{alias.campo1 = xxx}, {alias.campo2 = yyy}}

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetExpFilter (aExpFilter) Class APIManager
	Local aRet	:= Self:aExpFilter
	Local nLen	:= Len(aExpFilter)
	Local nX	:= 0

	Default	aExpFilter	:= {}
	
	For nX := 1 To nLen
		nPosaRet := Ascan(aRet,{|x| x[AFILTRO_ALIASAPI] == aExpFilter[nX][AFILTRO_ALIASAPI]})
		If nPosaRet > 0
			aAdd(aRet[nPosaRet][3],aExpFilter[nX][AFILTRO_FIELDS][AFILTRO_VALUE])
		Else
			aAdd(aRet,{aExpFilter[nX][1],aExpFilter[nX][2],{aExpFilter[nX][AFILTRO_FIELDS][AFILTRO_VALUE]}})
		EndIf
	Next nX

	Self:aExpFilter := aRet
	
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetApiFields
M�todo que preenche os campos que ser�o retornados no WS

@param cFields   , caracter, String com os campos da api. Ex: "code, number, date"

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetApiFields(cFields) Class APIManager
	Default cFields := ''
	Self:aFieldFilter := StrToArray(Upper(cFields), ",")
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetIndexKey
M�todo que atribui a ordem do Alias principal

@param cIndexFather   , caracter, Ordem utilizada no alias pai

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetIndexKey(cIndexFather) Class APIManager
	Local aCampos	:= StrToArray(cIndexFather, ",")
	Local cApiValue	:= ""
	Local lAsc		:= .F.
	Local nLoop		:= Len(aCampos)
	Local nX		:= 0

	Default	cIndexFather	:= ""

	If SubStr(cIndexFather, 1, 1) == "-"
		cIndexFather	:= SubStr(cIndexFather, 2, Len(cIndexFather))
		lAsc := .T.
	EndIf

	For nX := 1 To nLoop
		cApiValue := Self:GetProtField(Self:cNickAlias, StrTran(aCampos[nX],"-",""))
		If Empty(Self:cIndexFather)
			If lAsc
				Self:cIndexFather	+= cApiValue + " DESC "
			Else
				Self:cIndexFather	+= cApiValue
			EndIf
		Else
			If lAsc
				Self:cIndexFather	+= "," + cApiValue + " DESC "
			Else
				Self:cIndexFather	+= "," + cApiValue
			EndIf
		Endif
	Next
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetJson
M�todo que monta o objeto Json

@param lHasNext	, l�gico, Informa se existe mais p�ginas para consulta
@param aItens	, array	, Array contendo os dados encontrados

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetJson(lHasNext, aItens) Class APIManager
	Default lHasNext	:= .T.
	Default aItens		:= {}
	Self:oJsonData  := JsonObject():New()
	
	If Self:lUseHasNext
		Self:oJsonData["hasNext"] 	:= lHasNext
	EndIf
	
	Self:oJsonData[Self:cApiName]	:= aItens
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetJsonObject
M�todo que monta o objeto Json de acordo com os atributos atribu�dos na classe

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetJsonObject() Class APIManager
	Local lRet	:= .F.

	If Self:lActive .And. Empty( Self:oJsonData )
		lRet := SetJsonObject( Self, Self:aApiMap, Self:aRelations, /*nPosRelation*/, Self:cAlias, Self:cIndexFather, /*nRecno*/ , /*oItem*/,/*aItemPos*/, /*aItensCab*/, Self:cNickAlias, .F.)
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} SetPage
M�todo que atribui o n�mero da p�gina que o usu�rio ir� navegar

@nPage	, Num�rico, N�mero da p�gina que o usu�rio deseja navegar
@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetPage(nPage) Class APIManager
	Default nPage	:= 1
	If nPage > 0 
	Self:nPage		:= nPage
	Else
		Self:nPage	:= 1
	EndIf
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetPageSize
M�todo que atribui a quantidade de registro por p�ginas
@nPageSize	, Num�rico, N�mero de registros por p�gina

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetPageSize(nPageSize) Class APIManager
	Default nPageSize	:= 20

	If nPageSize > 0 
	Self:nPageSize 		:= nPageSize
	Else
		Self:nPageSize	:= 20
	EndIf
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} SetJsonError
M�todo que monta o Json com as descri��es dos erros ocorridos.

@param cCode	        , caracter, C�digo da mensagem
@param cMessage     	, caracter, Mensagem de erro.
@param cDetailedMessage	, caracter, Detelhes da mensagem.
@param cHelpUrl     	, caracter, Url da publica��o do help.
@param aDetails     	, array   , Lista com os erros no formato
{{cCode,cMessage,cDetailedMessage,cHelpUrl}}

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method SetJsonError(cCode,cMessage,cDetailedMessage, cHelpUrl, aDetails) Class APIManager
	Local oItem         := Nil
	Local aItem			:= {}
	Local nLenDetails   := 0
	Local nX            := 0

	Default cCode               := ""
	Default cMessage            := ""
	Default cDetailedMessage    := ""
	Default cHelpUrl            := ""
	Default aDetails            := {}

	Self:oJsonError := JsonObject():New()
	Self:oJsonError["code"]             := cCode
	Self:oJsonError["message"]          := cMessage
	Self:oJsonError["detailedMessage"]  := cDetailedMessage
	Self:oJsonError["helpUrl"]          := cHelpUrl

	If Empty( aDetails )
		oItem := JsonObject():New()
		oItem["code"]             := cCode
		oItem["message"]          := cMessage
		oItem["detailedMessage"]  := cDetailedMessage
		aItem := {oItem}
	Else
		nLenDetails := Len(aDetails)
		For nX := 1 To nLenDetails
			aAdd(aItem,JsonObject():New())
			aItem[nX]["code"]             := aDetails[nX][1]
			aItem[nX]["message"]          := aDetails[nX][2]
			aItem[nX]["detailedMessage"]  := aDetails[nX][3]
		Next nX
	EndIf

	Self:oJsonError["details"] := aItem
	
	If !Empty(aItem)
		aSize(aItem,0)
		aItem := {}
	EndIf
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} GetOrderKey
M�todo que retorna o �ndice utilizado na tabela pai

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetOrderKey() Class APIManager
Return Self:cIndexFather

//-------------------------------------------------------------------
/*/{Protheus.doc} GetProtInfo
M�todo que retorna um array com alias, alias api e campos do Protheus

@param cFields	, caracter, Campos da Api

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetProtInfo(cFields) Class APIManager
	Local aRet			:= {}
	Local aCampos		:= StrToArray(cFields, ",")
	Local nPosStruct	:= 0
	Local nPosaRet		:= 0
	Local nX			:= 0
	Local nY			:= 0
	Local nLenFields	:= Len(aCampos)
	Local nLenApiMap	:= Len(Self:aApiMap[APIMAP_LIST])

	Default cFields := ''

	For nX := 1 To nLenFields
		For nY := 1 to nLenApiMap
			nPosStruct	:= aScan(Self:aApiMap[APIMAP_LIST][nY][ASTRUCT_FIELDS],{|x| x[1] == aCampos[nX] })
			If nPosStruct > 0
				nPosaRet := Ascan(aRet,{|x| x[1] == Self:aApiMap[APIMAP_LIST][nY][APIMAP_ALIAS]})
				If nPosaRet > 0
					aAdd(aRet[nPosaRet][3],Self:aApiMap[APIMAP_LIST][nY][ASTRUCT_FIELDS][nPosStruct][ASTRUCT_FIELDPROTHEUS])
				Else
					aAdd(aRet,{Self:aApiMap[APIMAP_LIST][nY][APIMAP_ALIAS],Self:aApiMap[APIMAP_LIST][nY][APIMAP_ITEMINFO], Self:aApiMap[APIMAP_LIST][nY][APIMAP_ITEMNICK],{Self:aApiMap[APIMAP_LIST][nY][ASTRUCT_FIELDS][nPosStruct][ASTRUCT_FIELDPROTHEUS]}})
				EndIf
			EndIf
		Next nY
	Next nX

Return aRet
//-------------------------------------------------------------------
/*/{Protheus.doc} GetApiAdapter
M�todo que retorna o nome do fonte respons�vel pelo Adapter

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetApiAdapter() Class APIManager
Return Self:cAdapter

//-------------------------------------------------------------------
/*/{Protheus.doc} GetApiFilter
M�todo que retorna os filtros para um determinado alias

@param cInfoItem, caracter, nome do alias do modelo a ser pesquisado

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetApiFilter(cInfoItem) Class APIManager
	Local cRet	:= ""
	Local nPos	:= aScan(Self:aFilter,{|x| x[2] == cInfoItem })
	Local nX	:= 0

	Default cInfoItem := ""

	If nPos  > 0
		For nX := 1 To Len (Self:aFilter[nPos][AFILTRO_FIELDS])
			cRet += " AND " + Self:aFilter[nPos][AFILTRO_ALIASAPI] + "." + Self:aFilter[nPos][AFILTRO_FIELDS][nX]
		Next nX
	EndIf

Return cRet

//-------------------------------------------------------------------
/*/{Protheus.doc} GetExpFilter
M�todo que retorna os filtros para um determinado elemento

@param cInfoItem, caracter, nome do elemento do modelo a ser pesquisado

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetExpFilter(cInfoItem) Class APIManager
	Local aRet	:= {}
	Local nPos	:= aScan(Self:aExpFilter,{|x| x[2] == cInfoItem })
	Local nX	:= 0

	Default cInfoItem := ""

	If nPos  > 0
		For nX := 1 To Len (Self:aExpFilter[nPos][AFILTRO_FIELDS])
			Aadd( aRet, {Self:aExpFilter[nPos][AFILTRO_ALIAS], Self:aExpFilter[nPos][AFILTRO_FIELDS][nX]})
		Next nX
	EndIf

Return aRet

//-------------------------------------------------------------------
/*/{Protheus.doc} GetProtField
M�todo que retorna o nome do campo Protheus de acordo com o AliasAPi e FieldApi

@param cNickAlias, caracter, nome do alias do modelo (API) a ser pesquisado
@param cFieldApi, caracter, nome do campo do modelo (API) a ser pesquisado

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetProtField(cNickAlias, cFieldApi, cStrucJson) Class APIManager
	Local aJsonStruct	:= {}
	Local cAliasTrb		:= ""
	Local nPosField		:= 0
	Local nPosInfo		:= 0
	Local cRet			:= "" 
	
	Default cNickAlias	:= "" 
	Default cFieldApi	:= ""
	Default cStrucJson	:= ""

	cStrucJson	:= StrTran(cStrucJson, ".", ":")
	
	aJsonStruct := Self:GetEstJson(.T.)
	nPosStrucJson	:= aScan(aJsonStruct,{|x| Upper( x[1] ) + ':' + Upper(x[2]) == Upper( cStrucJson ) })

	If nPosStrucJson > 0
		cNickAlias = aJsonStruct[nPosStrucJson][07]
	EndIf

	If !Empty(cNickAlias) .And. !Empty(cFieldApi)
		nPosInfo := aScan(Self:aApiMap[APIMAP_LIST],{|x| Upper( x[APIMAP_ITEMNICK] ) == Upper( cNickAlias ) })
		If nPosInfo > 0
			cAliasTrb := Self:aApiMap[APIMAP_LIST][nPosInfo][APIMAP_ALIAS]
			nPosField := aScan(Self:aApiMap[APIMAP_LIST][nPosInfo][APIMAP_FIELDS],{|x| Upper( x[APIMAP_FIELDAPI] ) == Upper( cFieldApi ) })
			If nPosField > 0
				DbSelectArea(cAliasTrb)
				If FieldPos( Self:aApiMap[APIMAP_LIST][nPosInfo][APIMAP_FIELDS][nPosField][APIMAP_FIELDPROTHEUS] ) 
					cRet := Self:aApiMap[APIMAP_LIST][nPosInfo][APIMAP_FIELDS][nPosField][APIMAP_FIELDPROTHEUS]
				EndIf
			EndIf
		EndIf
	EndIf  
Return cRet

//-------------------------------------------------------------------
/*/{Protheus.doc} GetEstJson
M�todo para retornar a strutura json de acordo com o APIMAP

@param lTran, L�gico, Retorna os nomes oficiais, sen�o, retorna a estrutura com base no nickname

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetEstJson(lTran) Class APIManager

	Default lTran	:= .T.

	If !(Len(Self:aStrucJson) > 0)
		Self:aStrucJson := MontaEstrut(Self, lTran)
	EndIf

Return Self:aStrucJson

//-------------------------------------------------------------------
/*/{Protheus.doc} GetApiFields
M�todo que retorna os campos que ser�o retornados pelo Adapter

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetApiFields() Class APIManager
Return Self:aFieldFilter

//-------------------------------------------------------------------
/*/{Protheus.doc} GetApiVersion
M�todo que retorna a vers�o do Swagger utilizado

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetApiVersion() Class APIManager
Return Self:cVersion

//-------------------------------------------------------------------
/*/{Protheus.doc} GetApiPage
M�todo que retorna a p�gina atual

@author Squad CRM/Faturamento
@since 20/08/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetApiPage() Class APIManager
Return Self:nPage

//-------------------------------------------------------------------
/*/{Protheus.doc} GetApiPgSize
M�todo que retorna o tamanho da p�gina��o atual

@author Squad CRM/Faturamento
@since 20/08/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetApiPgSize() Class APIManager
Return Self:nPageSize

//-------------------------------------------------------------------
/*/{Protheus.doc} GetApiMap
M�todo que retona array com mapa do Swagger utilizado

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetApiMap() Class APIManager
Return Self:aApiMap

//-------------------------------------------------------------------
/*/{Protheus.doc} GetApiRelation
M�todo que retorna array com relacionamento entre entidades, utilizado
quando o ADAPTER utiliza cabe�alhoxItens

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetApiRelation() Class APIManager
Return Self:aRelations

//-------------------------------------------------------------------
/*/{Protheus.doc} GetApiAlias
M�todo que retorna o Alias da tabela Protheus usada pelo RESTFull

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetApiAlias() Class APIManager
Return Self:cAlias

//-------------------------------------------------------------------
/*/{Protheus.doc} GetJsonObject
M�todo que retorna o objeto Json da classe

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetJsonObject() Class APIManager
Return Self:oJsonData

//-------------------------------------------------------------------
/*/{Protheus.doc} GetJsonSerialize
M�todo que retorna o objeto Json serealizado

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetJsonSerialize() Class APIManager
Return EncodeUtf8(FwJsonSerialize(Self:oJsonData,.T.,.T.))


//-------------------------------------------------------------------
/*/{Protheus.doc} ToObjectJson
M�todo que retorna o JsonSerializado apanas para um objeto e n�o um array de objetos.

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method ToObjectJson() Class APIManager
	Local cRet	:= ""
	Local oRet 	:= Self:GetJsonObject() 

	If oRet['items'] != Nil .And. ValType(oRet['items']) == "A"
		cRet := EncodeUtf8(FwJsonSerialize(oRet['items'][1],.T.,.T.))
	EndIf

Return cRet

Method GetJsonArray( cJson ) Class APIManager
	Local oJson         := Nil
	Local nRetParser    := 0
	Local nX            := 0
	Local nLenMList     := 0
	Local aJsonParser   := {}
	Local aJsonArray    := {}
	Local aJsonObj      := {}
	Local cNameObj      := ""

	Default cJson       := ""

	If Self:lActive
		If !Empty( cJson )
			cJson := '{"items": [' + cJson + ' ]}'
			oJson := tJsonParser():New()
			
			If oJson:Json_Parser( cJson, Len( cJson ), @aJsonParser , @nRetParser )
				cNameObj  := Self:aApiMap[2]
				If !Empty( cNameObj )
					nLenMList := Len( Self:aApiMap[APIMAP_LIST] )
					For nX := 1 To nLenMList
						SeekJsonObj( aJsonParser, Self:aApiMap[5][nX][3], Self:aApiMap[5][nX], @aJsonObj, Self:aApiMap[5][nX][4], aJsonArray )
						If !Empty( aJsonObj )
							aAdd( aJsonArray, { aJsonObj[1], Self:aApiMap[APIMAP_LIST][nX][APIMAP_ALIAS], Self:aApiMap[APIMAP_LIST][nX][APIMAP_TYPE] ,aJsonObj[2], Self:aApiMap[APIMAP_LIST][nX][APIMAP_ITEMNICK]  } )
							aJsonObj := {}
						EndIf
					Next nX
				EndIf
			Else
				Self:SetJsonError("400","Falha ao converter mensagem para formato em array.","Json: " + SubStr( cJson, nRetParser + 1 ),/*cHelpUrl*/,/*aDetails*/)
			EndIf
		Else
			Self:SetJsonError("400","Json n�o entrado!","Verifique se o Json foi enviado no corpo da requisi��o.",/*cHelpUrl*/,/*aDetails*/)
		EndIf
	Else
		Self:SetJsonError("400","O Objeto Json n�o est� ativo","Ative o objeto antes de utilizar este m�todo.",/*cHelpUrl*/,/*aDetails*/)
	EndIf

	aSize(aJsonParser,0)
	aJsonParser := Nil
	
	aSize(aJsonObj,0)
	aJsonObj := Nil

	oJson := Nil

Return aJsonArray

//-------------------------------------------------------------------
/*/{Protheus.doc} GetApiError
M�todo que retorna os erros setado na API.

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method GetJsonError() Class APIManager
Return EncodeUtf8(FwJsonSerialize(Self:oJsonError,.T.,.T.))

//-------------------------------------------------------------------
/*/{Protheus.doc} Activate
Realiza as valida��es para ativar o modelo.

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method Activate() Class APIManager
	
	If Len(Self:aApiMap) == 0
		Self:aApiMap := LoadMap(Self:cAdapter)
	EndIf

	If !Empty(Self:aApiMap)
		Self:aFields := LoadFields(Self:aApiMap)

		If Empty(Self:cVersion)
			Self:cVersion := LoadVersion(Self:aApiMap)
		EndIf
		
		If Empty(Self:cApiName)
			Self:cApiName := LoadName(Self:aApiMap)
		EndIf
		
		If Empty(Self:cAlias)
			Self:SetApiAlias()
		EndIf
	EndIf

	Do Case
		Case Empty(Self:cAdapter)
		Self:SetJsonError("400","Adapter n�o encontrado!","Verifique a estrutura do APIMAP.",/*cHelpUrl*/,/*aDetails*/)
		Case Empty(Self:aApiMap)
		Self:SetJsonError("400","APIMAP n�o encontrada!","Verifique se existe a fun��o APIMAP no adapter informado.",/*cHelpUrl*/,/*aDetails*/)
		Case Empty(Self:aFields)
		Self:SetJsonError("400","Campos da APIMAP n�o foi informado!","Verifique o De/Para de campos API x Protheus na APIMAP.",/*cHelpUrl*/,/*aDetails*/)
		Case !RelationValidate(Self:aRelations,Self:aApiMap)
		Self:SetJsonError("400","Relacionamento da API inv�lido","Verifique se existe a tabela relacionada na APIMAP.",/*cHelpUrl*/,/*aDetails*/)
	EndCase

	Self:lActive := Self:oJsonError == Nil
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} IsActive
M�todo que retorna se o objeto est� ativo

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method IsActive() Class APIManager
Return Self:lActive

//-------------------------------------------------------------------
/*/{Protheus.doc} MontaArray
	Fun��o para retornar o prefixo de cada objeto do json recebido

	@param cBody		, caracter	, Estrutura de dados de acordo com o relacionamento declarados
	@param oAPIManager	, objeto	, NickName Alias filho

	@return aRet		, array		, Retorno com 3 posi��es: [1] Cabe�alho, [2] Items, [3] Objetos

	@author Squad CRM/Faturamento
	@since 24/07/2018
	@version Protheus 12
/*/
//-------------------------------------------------------------------
Method ToArray(cBody) Class APIManager
	Local aRelation 	:= Self:aRelations
	Local aMap			:= Self:GetApiMap()
	Local aAux			:= {}
	Local aStruct		:= {}
	Local aRet			:= {}
	Local nX			:= 0
	Local nY			:= 0
	Local nZ			:= 0
	Local nPosMap		:= 0
	Local items			:= Nil
	Local aItem			:= {}
	Local aItems		:= {}
	Local aObj			:= {}
	Local aObjs			:= {}
	Local aItensArray	:= {}
	Local aCab			:= {}
	Local aItens		:= {}	
	Local xVal			:= Nil	
	Local xMacroLaco	:= Nil

	aAux	:= MontaEstrut(Self, .T.)

	If FWJsonDeserialize(cBody,@items)

		ASORT(aAux, , , { | x,y | x[4] > y[4] } )

		For nX := 1 To Len(aAux)
			If Empty(aAux[nX][5])
				If "Exp" $ aAux[nX][3]
					aAux[nX][5] := "Ok"
					Loop
				ElseIf Upper(aAux[nX][4]) == "OBJECT"
					For nY := nX + 1 To Len(aAux)
						If aAux[nX][1] $ aAux[nY][1] .And. Empty(aAux[nY][5])
							aAux[nY][5] := "Ok"
						EndIf
					Next
					If VldMacro(aAux[nX][1], items)			
						xMacroLaco := &(aAux[nX][1])
						If ValType(xMacroLaco) == "A"
							For nZ := 1 To Len(xMacroLaco)
								xMacroLaco := &(aAux[nX][1] + "["+cValToChar(nZ)+"]")
								aAdd(aObj,xMacroLaco)
							Next

							If Len(aObj) > 0
								aAdd(aObjs,aObj)
							EndIf
							aObj	:= {}
						EndIf
					EndIf
				ElseIf Upper(aAux[nX][4]) == "ITEM"
					aItensArray := {}
					aAux[nX][5] := "Ok"
					aAdd(aItensArray,{aAux[nX][1], aAux[nX][2], aAux[nX][3], aAux[nX][6]})
					For nY :=  nX + 1 To Len(aAux)
						If aAux[nX][1] $ aAux[nY][1] .And. Empty(aAux[nY][5])
							aAux[nY][5] := "Ok"
							aAdd(aItensArray,{aAux[nY][1], aAux[nY][2], aAux[nY][3], aAux[nY][6]})
						EndIf
					Next
					If VldMacro(aAux[nX][1], items)
						xMacroLaco := &(aAux[nX][1])
						If ValType(xMacroLaco) == "A"
							For nZ := 1 To Len(xMacroLaco)
								For nY := 1 To Len(aItensArray)
									If (Len(AllTrim(aAux[nX][1])) != Len(AllTrim(aItensArray[nY][1]))) .And. aAux[nX][1] $ aItensArray[nY][1]
										cAux	 := aAux[nX][1] + "[" + cValToChar(nZ) + "]"  + Strtran(aItensArray[nY][1],aAux[nX][1],"")
										MacroStr := &(cAux)
									Else
										cAux		:= aAux[nX][1] + "[" + cValToChar(nZ) + "]"
										MacroStr 	:= &(cAux)
									EndIf
									If AttIsMemberOf(MacroStr, aItensArray[nY][2])
										If ValType(MacroStr) == "O"
											xVal := &(cAux + ":" + aItensArray[nY][2])
										EndIf

										xVal := AjustaVar(aItensArray[nY][4], aItensArray[nY][3], xVal)

										If !Empty(xVal)
							
											nPos := aScan(aItem,{|x| Upper( x[1] ) == Upper( aItensArray[nY][4] ) })
											If nPos > 0
												aAdd(aItem[nPos][2],{aItensArray[nY][3], xVal})
											Else
												aAdd(aItem,{aItensArray[nY][4],{{aItensArray[nY][3], xVal}}})
											EndIf

										EndIf
									EndIf
								Next

								If Len(aItem) > 0
									aAdd(aItems,aItem)
								EndIf
								aItem	:= {}
							Next
						EndIf
					EndIf
				Else
					aAux[nX][5] := "Ok"
					If VldMacro(aAux[nX][1], items)
						xMacroLaco 	:= &(aAux[nX][1])
						If AttIsMemberOf(xMacroLaco, aAux[nX][2])
							xVal := &(aAux[nX][1] + ":" + aAux[nX][2])
							
							xVal := AjustaVar(aAux[nX][6], aAux[nX][3], xVal)

							If !Empty(xVal)
								nPos := aScan(aCab,{|x| Upper( x[1] ) == Upper( aAux[nX][6] ) })
								If nPos > 0
									aAdd(aCab[nPos][2],{aAux[nX][3], xVal})
								Else
									aAdd(aCab,{aAux[nX][6],{{aAux[nX][3], xVal}}})
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		Next
	EndIf

	aAdd(aRet, {aCab, aItems, aObjs})

Return aRet

//-------------------------------------------------------------------
/*/{Protheus.doc} VldMacro
	Valida se a estrutura passada na Macro � v�lida

	@param cCampo	, array		, Carminho do campo na api : Ex: items:address:city
	@param items	, objeto	, Nome do objeto Json
	
	@return lRet	, boleano	, Retorna se encontrou ou n�o a estrutura informada

	@author Squad CRM/Faturamento
	@since 24/07/2018
	@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function VldMacro(cCampo, items)
	Local lRet 	:= .T.
	Local nX	:= 0
	Local cAux	:= ""
	Local aInfo	:= StrToArray(cCampo, ":")

	Default items	:= Nil

	If items != Nil .And. Len(aInfo) > 1
		cAux := aInfo[1]
		For nX := 2 To Len(aInfo)
			xMacro := &(cAux)
			If AttIsMemberOf(xMacro, aInfo[nX])
				cAux +=  ":" + aInfo[nX]
			Else
				lRet := .F.
				Exit
			EndIf
		Next nX
	EndIf

Return lRet
//-------------------------------------------------------------------
/*/{Protheus.doc} ToExecAuto
	Fun��o para retornar o prefixo de cada objeto do json recebido

	@param nTipo	, num�rico	, Tipo de Retorno: 1 - Cabe�alho, 2 - Item
	@param aDados	, array		, Dados retornados atrav�s do m�todo ToArray

	@return aRet 	, array		, Dados tratados para o Execauto

	@author Squad CRM/Faturamento
	@since 24/07/2018
	@version Protheus 12
/*/
//-------------------------------------------------------------------
Method ToExecAuto(nTipo, aDados, aRet) Class APIManager
	Local nX	:= 0
	Local nDados:= Len(aDados)
	Local aItem	:= {}

	Default aRet	:= {}

	If nTipo == 1
		For nX := 1 To nDados
			aAdd(aRet, {aDados[nX][1], aDados[nX][2], Nil})
		Next nX
	Else
		For nX := 1 To nDados
			aAdd(aItem, {aDados[nX][1], aDados[nX][2], Nil})
		Next nX

		aAdd(aRet, aItem)
	EndIf
Return aRet

//-------------------------------------------------------------------
/*/{Protheus.doc} Destroy
M�todo que destroi o objeto

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Method Destroy() Class APIManager
	
	aSize(Self:aApiMap, 0)
	Self:aApiMap := Nil

	aSize(Self:aError, 0)
	Self:aError := Nil

	aSize(Self:aFields, 0)
	Self:aFields := Nil

	aSize(Self:aFilter, 0)
	Self:aFilter := Nil

	aSize(Self:aFieldFilter, 0)
	Self:aFieldFilter := Nil

	aSize(Self:aRelations, 0)
	Self:aRelations := Nil

	FreeObj(Self:oFieldsJson)
	Self:oFieldsJson := Nil

	FreeObj(Self:oJsonData)
	Self:oJsonData := Nil

	If Self:oJsonError != Nil 
		FreeObj(Self:oJsonError)
		Self:oJsonError := Nil
	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} LoadMap
Realiza a chamada da fun��o ApiMap para popular a vari�vel aApiMap

@param cAdapter, caracter, nome do adapter a ser utilizado.

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function LoadMap(cAdapter)
	Default cAdapter := ''
	If Empty(cAdapter)
		aApiMap := {}
	Else
		aApiMap := &( "StaticCall(" + cAdapter + ", APIMAP )" )
	EndIf
Return aApiMap

//-------------------------------------------------------------------
/*/{Protheus.doc} LoadFields
Realiza a chamada da fun��o para fazer o De/Para entre os campos da API e do Protheus

@param aApiMap, array, Dados do adapter utilizado no objeto

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function LoadFields(aApiMap)
	Local nX 		 := 0
	Local nY		 := 0
	Local nLenFields := 0
	Local nLenApiMap := Len(aApiMap[APIMAP_LIST])
	Local aFields    := {}

	Default aApiMap := {}

	For nX := 1 to nLenApiMap
		aAdd( aFields,{} )
		nLenFields := Len(aApiMap[APIMAP_LIST][nX][APIMAP_FIELDS])
		For nY := 1 to  nLenFields
			aAdd( aFields[nX],{ aApiMap[APIMAP_LIST][nX][APIMAP_FIELDS][nY][APIMAP_FIELDAPI], aApiMap[APIMAP_LIST][nX][APIMAP_FIELDS][nY][APIMAP_FIELDPROTHEUS] } )
		Next nY
	Next nX

Return aFields

//-------------------------------------------------------------------
/*/{Protheus.doc} IdJsonIndex
	Fun��o para retornar o prefixo de cada objeto do json recebido

	@param aStruct	, array		, Estrutura de dados de acordo com o relacionamento declarados
	@param cIdPos	, caracter	, NickName Alias filho
	@param cIdPai   , caracter	, NickName Alias pai
	@param cIdChOri , caracter	, Nome Original Alias Filho
	@param cIdPaiOri, caracter	, Nome Original Alias Pai

	@return cIndex

	@author Squad CRM/Faturamento
	@since 24/07/2018
	@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function IdJsonIndex(aStruct, cIdPos, cIdPai, cIdChOri, cIdPaiOri, lTran)
	Local cIndex	:= "" 
	Local cIndexPai	:= cIdPos 

	Default lTran	:= .T.

	If !Empty( cIdPai ) 
		GetIndex(aStruct, cIdPos, cIdPai, @cIndexPai, cIdChOri, cIdPaiOri, lTran)
		If !Empty( cIndexPai )
			cIndex := cIndexPai 
		EndIf
	Else
		cIndex := cIndexPai 
	EndIf
	
	If lTran
		cIndex := Strtran(cIndex, cIdPos, cIdChOri)
		cIndex := Strtran(cIndex, cIdPai, cIdPaiOri)
	EndIf

	If SubStr(cIndex, Len(cIndex), 1) == ":" //Tipo objeto, sem conte�do final
		cIndex := SubStr(cIndex, 1, Len(cIndex) - 1)
	EndIf
Return cIndex 

//-------------------------------------------------------------------
/*/{Protheus.doc} GetIndex
	Fun��o recursiva para retornar o prefixo de cada objeto do json recebido

	@param aStruct	, array		, Estrutura de dados de acordo com o relacionamento declarados
	@param cIdPos	, caracter	, NickName Alias filho
	@param cIdPai   , caracter	, NickName Alias pai
	@param cIdChOri , caracter	, Nome Original Alias Filho
	@param cIdPaiOri, caracter	, Nome Original Alias Pai

	@return cIndex

	@author Squad CRM/Faturamento
	@since 24/07/2018
	@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function GetIndex(aStruct, cIdPos, cIdPai, cIndex, cIdChOri, cIdPaiOri, lTran)
	Local nPos := 0

	Default lTran	:= .T.

	nPos := aScan(aStruct, {|x| Upper( x[1] ) == Upper( cIdPai )}) 
	If nPos > 0 .And. !Empty( aStruct[nPos][2] )
		cIndex := aStruct[nPos][1] + ":" + cIndex 
		If lTran
			cIndex := Strtran(cIndex, aStruct[nPos][1], aStruct[nPos][3])
		EndIf
 		GetIndex(aStruct, aStruct[nPos][1], aStruct[nPos][2], @cIndex, , , lTran)
	Else
		If !Empty( cIndex ) 
			cIndex := cIdPai + ":" + cIndex
		Else
			cIndex := cIdPos
		EndIf
	EndIf
Return Nil 

//-------------------------------------------------------------------
/*/{Protheus.doc} AjustaVar
	Fun��o para validar o campo recebido.

	@param cAliasTrb, array		, Nome do Alias Protheus
	@param cField	, caracter	, Nome do campo Protheus
	@param xVal   	, vari�vel	, Valor recebido

	@return xVal	, vari�vel	, Valor tratado

	@author Squad CRM/Faturamento
	@since 24/07/2018
	@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function AjustaVar(cAliasTrb, cField, xVal)

	Local cX3Type	:= ""
	
	If Len(AllTrim(cField)) <= 10
		cX3Type	:= GetSx3Cache( cField, "X3_TIPO" )
		If cX3Type != Nil
			If xVal == Nil
				xVal := CreateVar(cAliasTrb, cField)
			Else
				If cX3Type == "D"
					xVal := StoD(StrTran(xVal, "-", ""))
				Else
					xVal := xVal
				EndIf
			EndIf	
		Else
			xVal := ""
		EndIf
	Else
		xVal := ""
	EndIf
	
Return xVal			


//-------------------------------------------------------------------
/*/{Protheus.doc} LoadVersion
Retorna a vers�o do adapter utilizado

@param aApiMap, array, Dados do adapter utilizado no objeto

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function LoadVersion(aApiMap)
	Local cVersion := ''
	
	Default aApiMap := {}
	
	If !Empty(aApiMap) .And. !Empty(aApiMap[APIMAP_VERSION]) .And. ValType(aApiMap[APIMAP_VERSION]) == 'C'
		cVersion := aApiMap[APIMAP_VERSION]
	EndIf

Return cVersion

//-------------------------------------------------------------------
/*/{Protheus.doc} LoadVersion
Retorna a o nome do adapter utilizado

@param aApiMap, array, Dados do adapter utilizado no objeto

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function LoadName(aApiMap)
	Local cApiName	:= ''
	Default aApiMap := {}
	If !Empty(aApiMap) .And. !Empty(aApiMap[APIMAP_NAME]) .And. ValType(aApiMap[APIMAP_NAME]) == 'C'
		cApiName := aApiMap[APIMAP_NAME]
	EndIf
Return cApiName

//-------------------------------------------------------------------
/*/{Protheus.doc} SeekJsonObj
Procura um objeto Json no array aJsonParser.

@param aJsonParser, array   , Array com as informa��es da string Json.
@param cNameObj   , caracter, Nome do objeto para ser procurado.
@param aMapStruct , array   , Estrutura do Protheus referente ao um objeto Json.
@param aJsonObj   , array   , Array com os dados do objeto encontrado.

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function SeekJsonObj( aJsonParser, cNameObj, aMapStruct, aJsonObj, cNickName, aJsonArray )
	Local nX        := 0
	Local nY        := 0
	Local nZ        := 0
	Local nLenItem  := 0
	Local nPos      := 0
	Local aColumn   := {}
	Local aItem     := {}
	Local xContent	:= Nil

	Default cNameObj    := ""
	Default aJsonParser := {}
	Default aMapStruct	:= {}
	Default aJsonObj    := {}

	If Empty( aJsonObj )

		nLenJParser :=  Len( aJsonParser )

		For nX := 1 To nLenJParser
			If ValType( aJsonParser[nX] ) == "A"
				SeekJsonObj( aJsonParser[nX], cNameObj, aMapStruct, @aJsonObj, cNickName, aJsonArray )
			Else
				If Len(aJsonParser) > 1 .And. Upper( aJsonParser[1] ) == Upper( cNameObj )// .And. !("convertido" $ aJsonParser[1])
				
					If ValType(aJsonParser[2]) != "A"// .And. Len( aJsonParser[2] ) > 1
						loop
					EndIf

					For nZ := 1 To Len( aJsonParser[2] )
						nLenItem := Len( aJsonParser[2][nZ][2] )

						For nY := 1 To nLenItem
							If Len(aJsonParser[2][nZ][2][nY]) < 2
								If "OBJECT" $ aJsonParser[2][nZ][2][nY+1][1]
									aAdd(aJsonParser[2][nZ][2][nY],{aJsonParser[2][nZ][2][nY+1]}) //Tratamento para objetos com mais de um n�vel e n�o s�o arrays
									loop
								EndIf
							EndIf
							If ValType( aJsonParser[2][nZ][2][nY][2] ) <> "A"
								nPos := aScan(aMapStruct[APIMAP_LIST],{|x| Upper( x[APIMAP_FIELDAPI] ) == Upper( aJsonParser[2][nZ][2][nY][1] ) })
								If nPos > 0
									If aJsonParser[2][nZ][2][nY][2] == Nil
										xContent := CreateVar(aMapStruct[APIMAP_ALIAS],aMapStruct[APIMAP_LIST][nPos][APIMAP_FIELDPROTHEUS])
									Else
										If ( GetSx3Cache( aMapStruct[APIMAP_LIST][nPos][APIMAP_FIELDPROTHEUS], "X3_TIPO" ) ) == "D"
											xContent := StoD(StrTran(aJsonParser[2][nZ][2][nY][2], "-", ""))
										Else
											xContent := aJsonParser[2][nZ][2][nY][2]
										EndIf
									EndIf
									aAdd( aColumn, { aJsonParser[2][nZ][2][nY][1],aMapStruct[APIMAP_LIST][nPos][APIMAP_FIELDPROTHEUS] , xContent }  )
								EndIf
							EndIf
						Next nY

						If !Empty( aColumn )
							aAdd( aItem, aColumn )
							aColumn := {}
						EndIf

					Next nZ

					If !Empty( aItem )
						If Upper( aMapStruct[APIMAP_TYPE] ) == "ITEM"
							aJsonObj := { aJsonParser[1], aItem }
						Else
							aJsonObj := { aJsonParser[1], aItem[1] }
						EndIf
						aJsonParser[1] := aJsonParser[1]+"convertido"
					EndIf

					Exit
				ElseIf ("convertido" $ aJsonParser[1])
					Loop
				ElseIf Len(aJsonParser) > 1 .And. ValType( aJsonParser[2] ) == "A" 
					SeekJsonObj(aJsonParser[2],cNameObj,aMapStruct, @aJsonObj, cNickName, aJsonArray)
				EndIf
			EndIf
		Next nX

	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} CreateVar
Cria variavel no tipo de dado do campo informado no Json.

@param cAlias   , caracter        , Alias da tabela informada na APIMAP.
@param cMapField, acaracterrray   , Campo informado na APIMAP.

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function CreateVar(cAlias,cMapField)

	Local cPrefix       := ""
	Local aMapFields    := {}
	Local uRet          := Nil
	Local nX            := 0
	Local nLenFields	:= Len(aMapFields)

	Default cAlias      := ""
	Default cMapField   := ""

	If !Empty(cAlias) .And. !Empty(cMapField)
		aMapFields  := StrToArray(cMapField, ",")
		cPrefix     := PrefixoCpo(cAlias)
		uRet        := ""
		For nX := 1 To nLenFields
			cField  := PadR(aMapFields[nX],10)
			If cPrefix $ cField
				uRet += CriaVar(cField,Nil,Nil,.F.)
			Else
				uRet := Nil
				Exit
			EndIf
		Next
	EndIf
	aSize(aMapFields, 0)
	aMapFields := Nil

Return uRet

//-------------------------------------------------------------------
/*/{Protheus.doc} SetJsonObject
Realiza as consultas dos alias informados e retorna um objeto Json serealizado

@param aApiMap		, array		, Dados do adapter utilizado no objeto
@param oAPIManager	, objeto	, Objeto ApiManager
@param aRelations	, array		, Rela��es entre o alias pai e filho
@param nPosRelation	, num�rico	, N�mero da rela��o posicionada
@param cAlias		, caracter	, Nome do Alias pai utilizado
@param cIndexFather	, caracter	, Ordem do campo pai utilizado
@param nRecno		, num�rico	, Recno posicionado
@param oItem		, objeto	, Objeto contendo os dados dos alias relacionados (filhos)
@param aItemPos		, array		, Array com os dados dos alias filho
@param aItensCab	, array		, Array com os dados do alias pai
@param cInfoItem	, caracter, nome do alias do modelo a ser pesquisado

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------

Static Function SetJsonObject( oApiManager, aApiMap, aRelations, nPosRelation, cAlias, cIndexFather, nRecno, oItem, aItemPos, aItensCab, cInfoItem, lPula)

	Local aFields			:= oApiManager:GetApiFields()
	Local aStruct 			:= {}
	Local aStructItem		:= {}
	Local xConteudo			:= ""
	Local cFilName			:= TrataFil(cAlias)
	Local cFilter			:= ""
	Local aExpFilter		:= ""
	Local cJson				:= ""
	Local cQuery    		:= ""
	Local cTemp     		:= GetNextAlias()
	Local lHasnext			:= .T.
	Local lRet				:= .F.
	Local lFilter			:= .F.
	Local nCount       		:= 0
	Local nPosStruct		:= 0
	Local nPosStructItem	:= 0
	Local nPosFilExp		:= 0
	Local nStart        	:= 0
	Local nLinPos			:= 0
	Local nX				:= 0
	Local nY				:= 0
	Local nLenRel			:= 0
	Local nLenFields		:= 0
	Local xParam			:= Nil

	Default aApiMap			:= {}
	Default aItemPos		:= Nil
	Default aItensCab		:= {}
	Default aRelations 		:= {}
	Default cAlias 			:= ""
	Default cIndexFather	:= ""
	Default cInfoItem       := ""
	Default nPosRelation	:= 1
	Default nRecno			:= 0
	Default oItem			:= Nil
	Default oApiManager		:= Nil
	
	nPosStruct	:= aScan(aApiMap[APIMAP_LIST],{|x| x[APIMAP_ITEMNICK] == cInfoItem })
	aStruct 	:= aApiMap[APIMAP_LIST][nPosStruct]

	aExpFilter  := oApiManager:GetExpFilter(cInfoItem)

	If nPosRelation == 1
		cJoin		:= MontaJoin(oApiManager, cInfoItem, aRelations, @cFilter)
	EndIf

	cQuery 		:= " SELECT " + cInfoItem + ".R_E_C_N_O_ RECNO "
	cQuery 		+= " FROM " + RetSqlName(cAlias) + " " + cInfoItem
	
	If nPosRelation == 1 .And. !Empty(cJoin)
		cQuery 		+= " " + cJoin
	EndIf

	cQuery 		+= " WHERE "
	
	If nRecno > 0
		cQuery 	+=  cInfoItem	+ ".R_E_C_N_O_ = " + Str(nRecno) + " AND "
	EndIf
	
	cQuery		+= cInfoItem + "." + cFilName + " = '" + xFilial(cAlias) + "' AND "
	cQuery 		+=  cInfoItem	+ ".D_E_L_E_T_ = ' ' "
	
	If !Empty(cFilter)
		cQuery 		+=  cFilter
	EndIf
	If !Empty(cIndexFather) 
		cQuery 		+= " ORDER BY " + cIndexFather
	EndIf

	//cQuery := ChangeQuery(cQuery)
	MPSysOpenQuery( cQuery, cTemp ) 

	If nPosRelation == 1
		If oApiManager:nPage > 1
			nStart := ( (oApiManager:nPage-1) * oApiManager:nPageSize )
			If nStart > 0
				(cTemp)->( DbSkip( nStart ) )
			EndIf
		EndIf
	EndIf

	nLenRel 	:= Len(aRelations)
	nLenFields	:= Len( aStruct[ASTRUCT_FIELDS] )

	If !Empty(cFilter) .And. (cTemp)->(Eof())
		If ValType(oItem) == "U"
			oItem := JsonObject():New()
		EndIf
		lPula := .T.
		oItem['pula'] := .T.
	EndIf

	While (cTemp)->(!Eof()) .And. !lPula
		lFilter := .F.
		
		(cAlias)->( DBGoTo( (cTemp)->RECNO ) )

		If Len(aExpFilter) > 0
			For nX := 1 To Len (aExpFilter)
				nPosFilExp := aScan(aStruct[5], {|x| Upper(x[1]) == aExpFilter[nX][1] })
				If nPosFilExp > 0
					xConteudo := ""
					TrataRet(@xConteudo, cAlias, nPosFilExp, aStruct)
					If AllTrim(xConteudo) == AllTrim(aExpFilter[nX][2])
						lFilter := .T.
					EndIf
				EndIf
			Next nX
		Else
			lFilter := .T.
		EndIf

		If !lFilter
			(cTemp)->( DBSkip() )
			Loop
		EndIf

		If oItem != Nil .And. aItemPos == Nil
			If ValidSkip(oItem)
				nCount++
				aAdd(aItensCab,oItem )
			EndIf
		EndIf

		If nRecno == 0 
			oItem := JsonObject():New()

			For nY := 1 To nLenFields
				xConteudo := ""
				If Empty(aFields) .Or. aScan(aFields, Upper(aStruct[ASTRUCT_FIELDS][nY][ASTRUCT_FIELDAPI])) > 0
					TrataRet(@xConteudo, cAlias, nY, aStruct)
					If xConteudo != Nil .And. (!Empty(xConteudo) .Or. ValType(xConteudo) == "L" .And. !xConteudo)
						oItem[aStruct[ASTRUCT_FIELDS][nY][ASTRUCT_FIELDAPI]] := xConteudo
					EndIf
				EndIf
			Next nY
		Else
			If Upper(aStruct[2]) == "ITEM"
				If nLenFields > 0 
					aAdd( aItemPos, JsonObject():New() )
					nLinPos := Len( aItemPos )
					For nY := 1 To nLenFields
						If Empty(aFields) .Or. aScan(aFields, Upper(aStruct[ASTRUCT_FIELDS][nY][ASTRUCT_FIELDAPI])) > 0
							TrataRet(@xConteudo, cAlias, nY, aStruct)
							aItemPos[nLinPos][aStruct[ASTRUCT_FIELDS][nY][ASTRUCT_FIELDAPI]] := xConteudo
						EndIf
					Next nY
				EndIf
			ElseIf Upper(aStruct[2]) == "OBJECT"
				aAdd( aItemPos, JsonObject():New() )
				nLinPos := Len( aItemPos )
				For nY := 1 To nLenFields
					If Empty(aFields) .Or. aScan(aFields, Upper(aStruct[ASTRUCT_FIELDS][nY][ASTRUCT_FIELDAPI])) > 0
						TrataRet(@xConteudo, cAlias, nY, aStruct)
						aItemPos[nLinPos][aStruct[ASTRUCT_FIELDS][nY][ASTRUCT_FIELDAPI]] := xConteudo
					EndIf
				Next nY
			Else
				For nY := 1 To nLenFields
					xConteudo := ""
					If Empty(aFields) .Or. aScan(aFields, Upper(aStruct[ASTRUCT_FIELDS][nY][ASTRUCT_FIELDAPI])) > 0
						TrataRet(@xConteudo, cAlias, nY, aStruct)
						aItemPos[aStruct[ASTRUCT_FIELDS][nY][ASTRUCT_FIELDAPI]] := xConteudo
					EndIf
				Next nY
			EndIf
		EndIf

		
		For nX := nPosRelation To nLenRel
			If cInfoItem == aRelations[nX][RELATION_FATHERNICK]
				nPosStructItem	:= aScan(aApiMap[APIMAP_LIST],{|x| x[APIMAP_ITEMNICK] == aRelations[nX][RELATION_CHILDRENNICK] })
				aStructItem 	:= aApiMap[APIMAP_LIST][nPosStructItem]
				If aItemPos != Nil
					If Upper(aStructItem[ASTRUCT_TYPE]) != "OBJECT"
						If Upper(aStructItem[ASTRUCT_TYPE]) == "ITEM"
							If nLinPos > 0
								aItemPos[nLinPos][aStructItem[ASTRUCT_NAME]]	:= {}
							Else
								aItemPos[aStructItem[ASTRUCT_NAME]]	:= {}
							EndIf
						ElseIf nLinPos > 0
							aItemPos[nLinPos][aStructItem[ASTRUCT_NAME]]	:= JsonObject():New()
						Else
							aItemPos[aStructItem[ASTRUCT_NAME]]	:= JsonObject():New()
						EndIf
					EndIf
				Else
					If Upper(aStructItem[ASTRUCT_TYPE]) == "ITEM"
						oItem[aStructItem[ASTRUCT_NAME]] 	:= {}
					Else
						oItem[aStructItem[ASTRUCT_NAME]]	:= JsonObject():New()
					EndIf
				EndIf

				If aItemPos != Nil
					If Upper(aStructItem[ASTRUCT_TYPE]) != "OBJECT"
						If (Upper(aStructItem[ASTRUCT_TYPE]) == "ITEM" .And. nLinPos > 0) .Or. nLinPos > 0
							xParam := aItemPos[nLinPos][aStructItem[ASTRUCT_NAME]]
						Else
							xParam := aItemPos[aStructItem[ASTRUCT_NAME]]
						EndIf
					Else
						xParam := aItemPos
					EndIf
				Else
					xParam := oItem[aStructItem[ASTRUCT_NAME]]
				EndIf
				
				RelationExecuteItem(aRelations[nX][RELATION_ALIAS], aRelations[nX][RELATION_ALIASFATHER],;
				aRelations[nX][RELATION_CONDITIONS], aRelations[nX][RELATION_INDEXKEY],;
				aRelations, nX,  oApiManager, aApiMap, oItem, xParam, aItensCab, @lPula)
			EndIf
		Next nX
		
		(cTemp)->( DBSkip() )

		If nPosRelation == 1
			lPula	:= .F.
			If nCount == oApiManager:nPageSize
				Exit
			EndIf
		EndIf
	EndDo

	If nRecno == 0
		If Len(aItensCab) > 0 .Or. oItem != Nil
			If oItem != Nil .And. nCount != oApiManager:nPageSize
				If ValidSkip(oItem)
					aAdd(aItensCab,oItem)
				EndIf
			EndIf
			
			If (cTemp)->(Eof())
				lHasnext := .F.
			EndIf

			oApiManager:SetJson(lHasnext, aItensCab)
			lRet	:= .T.
		Else
			oApiManager:SetJsonError("404","Registro n�o encontrado.","N�o foi encontrado o registro especificado.",/*cHelpUrl*/,/*aDetails*/)
		EndIf
	EndIf

	(cTemp)->(DBCloseArea())

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} RelationExecuteItem
Executa a rela��o entre os alias e faz a chamada recursiva da fun��o SetJsonObject

@param cAlias		, caracter	, Alias filho
@param cAliasFather	, caracter	, Alias pai
@param aRelationItem, caracter	, Rela��es entre os campos do alias pai e filho
@param cOrderKey	, caracter	, Rela��es entre o alias pai e filho
@param aRelations	, array		, Rela��es entre o alias pai e filho
@param nY			, num�rico	, Posi��o do la�o principal
@param oApiManager	, objeto	, Objeto ApiManager
@param aApiMap		, array		, Dados do adapter utilizado no objeto
@param oItem		, objeto	, Objeto contendo os dados dos alias relacionados (filhos)
@param aItemPos		, array		, Array com os dados dos alias filho
@param aItensCab�	, array		, Array com os dados do alias pai

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function RelationExecuteItem(cAlias, cAliasFather, aRelationItem, cOrderKey, aRelations, nY, oApiManager, aApiMap, oItem, aItemPos, aItensCab, lPula )

	Local cTemp     := GetNextAlias()
	Local cQuery    := ""
	Local nX        := 0
	Local nFieldPos	:= 0
	Local uValue	:= Nil 
	Local nLenRItem := Len( aRelationItem )

	Default cAlias 			:= ''
	Default cAliasFather	:= ''
	Default cOrderKey		:= ''
	Default nY				:= 0
	Default aRelationItem	:= {}
	Default aRelations		:= {}
	Default aApiMap			:= {}
	Default aItemPos		:= {}
	Default aItensCab		:= {}
	Default oApiManager		:= Nil
	Default oItem			:= Nil

	cQuery := "SELECT " + cAlias + ".R_E_C_N_O_ RECNO "
	cQuery += " FROM " + RetSqlName(cAlias) + " " + cAlias

	cQuery += " WHERE "

	DbSelectArea(cAliasFather)

	For nX := 1 To nLenRItem

		nFieldPos := FieldPos( aRelationItem[nX][1] )
		If nFieldPos > 0 
			uValue	:= FieldGet( nFieldPos )
			If ValType(uValue) == "D"
				cQuery += aRelationItem[nX][RELITEM_FIELDCHILDREN] + " = '" + DTOS(uValue) + "' "
			Elseif ValType(uValue) == "N"
				cQuery += aRelationItem[nX][RELITEM_FIELDCHILDREN] + " = '" + CValToChar(uValue) + "' "
			Else
				cQuery += aRelationItem[nX][RELITEM_FIELDCHILDREN] + " = '" + uValue  + "' "
			Endif	
			If nX <> nLenRItem
				cQuery += " AND "
			EndIf
		Endif
	Next nX

	cQuery +=  " AND " + cAlias + ".D_E_L_E_T_ = ' ' "
	cQuery += " ORDER BY " + cOrderKey

	MPSysOpenQuery( cQuery, cTemp )

	If (cTemp)->(!Eof()) .And. !lPula
		While (cTemp)->(!Eof())
			SetJsonObject(oApiManager, aApiMap, aRelations, nY+1, aRelations[nY][RELATION_ALIAS],  aRelations[nY][RELATION_INDEXKEY], (cTemp)->RECNO, oItem, aItemPos, aItensCab, aRelations[nY][RELATION_CHILDRENNICK], @lPula )
			(cTemp)->(DBSkip())
		EndDo
	EndIf

	(cTemp)->(DBCloseArea())

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TrataRet
Realiza a tratativa dos campos Api x Protheus

@param xConteudo, N�o Definido	, Conte�do que ser� retornado no Json
@param cAlias	, caracter		, Alias posicionado
@param nY		, Num�rico		, Posi��o do campo posicionado
@param aStruct	, caracter		, Array com o nome do campo na API e Protheus

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function TrataRet(xConteudo, cAlias, nY,aStruct)
	
	Local aConteudo := StrToArray(aStruct[ASTRUCT_FIELDS][nY][ASTRUCT_FIELDPROTHEUS], ",")
	Local nLenCont	:= Len(aConteudo) 
	Local nX		:= 0
	Local nFieldPos	:= 0
	Local uValue	:= Nil

	Default xConteudo := Nil
	Default cAlias	  := ''
	Default nY		  := 0
	Default aStruct	  := {}

	DbSelectArea(cAlias)

	If nLenCont > 1
		For nX := 1 To nLenCont
			If "Exp:" $ aConteudo[nX]
				xConteudo += &(AllTrim(SubStr(aConteudo[nX],5, Len(aConteudo[nX]))))
			Else
				nFieldPos := FieldPos( aConteudo[nX] )
				If nFieldPos > 0
					uValue := FieldGet( nFieldPos )
					If ValType(uValue) == "D"
						xConteudo += DToS(uValue)
					ElseIf ValType(uValue) == "N"
						xConteudo += CValToChar(uValue)
					ElseIf ValType(uValue) == "C"
						xConteudo += uValue
					EndIf
				EndIf
			EndIf
		Next nX
	Else
		If "Exp:" $ aConteudo[1]
			xConteudo := &(AllTrim(SubStr(aConteudo[1],5, Len(aConteudo[1]))))
		Else
			nFieldPos := FieldPos( aConteudo[1] )
			If nFieldPos > 0
				xConteudo := (cAlias)->( FieldGet( nFieldPos) )
			EndIf
		EndIf
	Endif
	
	If !Empty(aConteudo)
		aSize(aConteudo,0)
		aConteudo := Nil
	EndIf
Return Nil 

//-------------------------------------------------------------------
/*/{Protheus.doc} RelationValidate
Valida��o do relacionamento da API.

@param aRelations   , array	, Relacionamentos
@param aApiMap  	, array	, APIMAP.

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function RelationValidate(aRelations,aApiMap)
	Local nX            := 0
	Local nLenRelation  := Len( aRelations )
	Local lRet          := .T.

	Default aRelations	:= {}
	Default aApiMap		:= Nil

	For nX := 1 To nLenRelation
		If aScan(aApiMap[APIMAP_LIST],{|x| Upper( x[APIMAP_ALIAS] ) == Upper( aRelations[nX][RELATION_ALIAS] ) }) == 0
			lRet := .F.
			Exit
		EndIf
	Next nX
	
Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} TrataFil
Retorna o nome do campo filial de acordo com o alias informado.

@param cAliasTrb  	, caracter	, Nome do Alias.

@author Squad CRM/Faturamento
@since 24/07/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function TrataFil(cAliasTrb)
Return PrefixoCpo(cAliasTrb) + "_FILIAL"


//----------------------------------------------------------------------------
/*/{Protheus.doc} ApiMainGet
Retorno usado em GET nas APIS da Squad CRM/Faturamento para carregar o Objeto 
oApiManager como uma instancia da classe APIManager.

@param	oApiManager		, Objeto	, Objeto do APIManager
		aQueryString	, Array		, Array contendo a queryString da requisi��o
		aConditions		, Array		, Condi��o de vinculo Pai x Filho Ex.:   {{"DA0_FILIAL","DA1_FILIAL"},{"DA0_CODTAB","DA1_CODTAB"}}
		aChildrenAlias	, Array		, Array Contendo Alias da tabela x nome do objeto filho no Json Ex.: {"DA1", "PriceListItems"}
		aFatherAlias	, Array		, Array Contendo Alias da tabela x nome do objeto pai no Json Ex.:{"DA0", "PriceList"}
		cIndexKey		, Caracter	, Indice aplicado na Query Ex.: "DA1_FILIAL, DA1_CODTAB, DA1_ITEM"
		cSource			, Caracter	, Nome do fonte (sem .prw) onde ser� lido o APIMap Ex.: 'omss010'
		cVersion		, Caracter	, Vers�o da API desejada Ex.: '2_001'
		lHasNext		, L�gico	, Indica se deve ser colocado o schema 'hasNext' no Json de retorno do GET
		
@return	    lRet   			, L�gico 	, Indica se todo o processamento ocorreu sem problemas

@author 	Nairan Alves Silva / Renato da Cunha
@version	12.1.17
@since		10/08/2018 
/*/
//----------------------------------------------------------------------------
Function ApiMainGet(oApiManager, aQueryString,aConditions,aChildrenAlias,aFatherAlias, cIndexKey,cSource, cVersion, lHasNext)
	Local lRet := .T.
	
	Default	cIndexKey		:= ''
	Default	cSource			:= ''
	Default cVersion		:= ''
	Default aQueryString	:= {,}
	Default aConditions		:= {}
	Default aChildrenAlias 	:= {}
	Default aFatherAlias	:= {}
	Default oApiManager		:= Nil
	Default lHasNext		:= .T.

	If Empty(cSource) .Or. Empty(cVersion)
		lRet := .F.
	Else
		If oApiManager == Nil
			oApiManager := APIMANAGER():New(cSource,cVersion)
		EndIf
		
		If Len(aConditions) > 0 .And. Len(aChildrenAlias) > 0
			oApiManager:SetApiRelation(aChildrenAlias,aFatherAlias,aConditions,cIndexKey)
		EndIf
		
		If !lHasNext
			oApiManager:SetApiHasNext(lHasNext)
		EndIf
		
		oApiManager:Activate()

		If oApiManager:IsActive()
			oApiManager:SetApiQstring(aQueryString)
			lRet := oApiManager:SetJsonObject()
		Else
			lRet := .F.
		EndIf
	EndIf
Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} MontaEstrut
Retorna a estrutura de acordo com o SetRelation

@param cAliasTrb  	, caracter	, Nome do Alias.

@author Squad CRM/Faturamento
@since 08/10/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------

Static Function MontaEstrut(Self, lTran)
	Local aRet			:= {}
	Local aRelation 	:= Self:aRelations
	Local aMap			:= Self:GetApiMap()
	Local aStruct		:= {}
	Local nX			:= 0
	Local nY			:= 0
	Local nZ			:= 0
	Local nPosMap		:= 0
	Local items			:= Nil
	Local aItem			:= {}
	Local aItems		:= {}
	Local aObj			:= {}
	Local aObjs			:= {}
	Local aItensArray	:= {}
	Local aCab			:= {}
	Local aItens		:= {}	
	Local xVal			:= Nil	
	Local xMacroLaco	:= Nil

	//Inicia a posi��o pai
	Aadd(aStruct, {aMap[APIMAP_LIST][1][APIMAP_ITEMNICK], "", aMap[APIMAP_LIST][1][APIMAP_ITEMNICK], aMap[APIMAP_LIST][1][APIMAP_ITEMNICK], aMap[APIMAP_LIST][1][APIMAP_TYPE], aMap[APIMAP_LIST][1][APIMAP_ALIAS]})
	If Len(aMap[APIMAP_LIST][1][APIMAP_FIELDS]) > 1
		aAdd(aStruct[Len(aStruct)], {})
		For nY := 1 To Len(aMap[APIMAP_LIST][1][APIMAP_FIELDS])
			aAdd(aStruct[Len(aStruct)][ASTRAUX_FIELDS], aMap[APIMAP_LIST][1][APIMAP_FIELDS][nY])
		Next nY
	EndIf

	For nX := 1 To Len(aRelation)
		nPosMap := aScan(aMap[APIMAP_LIST],{|x| Upper( x[APIMAP_ITEMNICK] ) == Upper( aRelation[nX][RELATION_CHILDRENNICK] ) })
		If nPosMap > 0
			Aadd(aStruct, {aRelation[nX][RELATION_CHILDRENNICK], aRelation[nX][RELATION_FATHERNICK], aRelation[nX][RELATION_CHILDRENSCHEMA], aRelation[nX][RELATION_FATHERSCHEMA], aMap[APIMAP_LIST][nPosMap][APIMAP_TYPE], aMap[APIMAP_LIST][nPosMap][APIMAP_ALIAS]})
			aAdd(aStruct[Len(aStruct)], {})
			For nY := 1 To Len(aMap[APIMAP_LIST][nPosMap][APIMAP_FIELDS])
				aAdd(aStruct[Len(aStruct)][ASTRAUX_FIELDS], aMap[APIMAP_LIST][nPosMap][APIMAP_FIELDS][nY])
			Next nY
		EndIf
	Next

	If Len(aStruct) > 0
		For nX := 1 To Len (aStruct)
			cIndex := IdJsonIndex(aStruct, aStruct[nX][ASTRAUX_FIELDAPI], aStruct[nX][ASTRAUX_NICKFATHER], aStruct[nX][ASTRAUX_CHILD], aStruct[nX][ASTRAUX_FATHER], lTran)
			If Len(aStruct[nX][7]) > 0
				For nY := 1 To Len(aStruct[nX][ASTRAUX_FIELDS])
					If !Empty(aStruct[nX][ASTRAUX_FIELDS][nY][ASTRAUX_FIELDPROT]) .And. GetSx3Cache( aStruct[nX][ASTRAUX_FIELDS][nY][ASTRAUX_FIELDPROT], 'X3_TIPO' ) != Nil
						aAdd(aRet,{cIndex, aStruct[nX][ASTRAUX_FIELDS][nY][ASTRAUX_FIELDAPI], aStruct[nX][ASTRAUX_FIELDS][nY][ASTRAUX_FIELDPROT], UPPER(aStruct[nX][ASTRAUX_TYPE]), "", UPPER(aStruct[nX][ASTRAUX_ALIAS]), aStruct[nX][ASTRAUX_NICKCHILD]})
					EndIf
				Next nY
			Else
				aAdd(aRet,{cIndex, "", "", UPPER(aStruct[nX][ASTRAUX_TYPE]), "", UPPER(aStruct[nX][ASTRAUX_ALIAS]), aStruct[nX][ASTRAUX_NICKCHILD]})
			EndIf
		Next
	EndIf

Return aRet

//-------------------------------------------------------------------
/*/{Protheus.doc} ValidSkip
Valida se o registro deve ser ignorado

@param oJson  	, objeto	, Objeto Json que ser� impresso

@author Squad CRM/Faturamento
@since 08/10/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function ValidSkip(oJson)
	Local lRet	:= .T.
	Local aRet	:= {}
	
	aRet := oJson:GetNames()

	lRet := AsCan(aRet,'pula') == 0

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} MontaJoin
Valida se o registro deve ser ignorado

@param oApiManager  , objeto	, Objeto ApiManager
@param cInfoItem  	, objeto	, NickName da estrutura
@param aRelations  	, objeto	, Rela��es das entruturas
@param cFilter  	, objeto	, Filtro a ser realizado na query

@author Squad CRM/Faturamento
@since 08/10/2018
@version Protheus 12
/*/
//-------------------------------------------------------------------
Static Function MontaJoin(oApiManager, cInfoItem, aRelations, cFilter)
	Local aTeste	:= {}
	Local cRet		:= ""
	Local lFirst	:= .T.
	Local nX		:= 0
	Local nY		:= 0

	If Len(aRelations) > 0
		For nX := 1 To Len(aRelations)
			cFilter		+= oApiManager:GetApiFilter(aRelations[nX][RELATION_FATHERNICK])
			cFilter		+= oApiManager:GetApiFilter(aRelations[nX][RELATION_CHILDRENNICK])
			If cInfoItem == aRelations[nX][RELATION_FATHERNICK] .Or. AsCan(aTeste, aRelations[nX][RELATION_FATHERNICK]) > 0
				aAdd(aTeste,aRelations[nX][RELATION_CHILDRENNICK])
				lFirst := .T.
				cRet += " INNER JOIN " + RetSqlName(aRelations[nX][RELATION_ALIAS]) + " " + aRelations[nX][RELATION_CHILDRENNICK] + " ON "
				For nY := 1 To Len(aRelations[nX][RELATION_CONDITIONS])
					If !lFirst
						cRet += " AND "
					Else
						cRet += aRelations[nX][RELATION_FATHERNICK] + ".D_E_L_E_T_ = " + aRelations[nX][RELATION_CHILDRENNICK] + ".D_E_L_E_T_ AND "
						lFirst := .F.
					EndIf
					cRet += aRelations[nX][RELATION_FATHERNICK] + "." + aRelations[nX][RELATION_CONDITIONS][nY][1] + " = " + aRelations[nX][RELATION_CHILDRENNICK] + "." + aRelations[nX][RELATION_CONDITIONS][nY][2]
				Next nY
			EndIf
		Next nX
	Else
		cFilter		+= oApiManager:GetApiFilter(cInfoItem)
	EndIf

Return cRet