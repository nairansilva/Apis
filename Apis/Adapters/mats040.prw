#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#Include 'FWMVCDEF.CH'
#INCLUDE "RESTFUL.CH"

//dummy function
Function MATS040()
Return

/*/{Protheus.doc} Seller

API de integração de Cadastro de Vendedor

@author		Squad Faturamento/SRM
@since		02/08/2018
/*/
WSRESTFUL Seller DESCRIPTION "Cadastro de Vendedor" //"Cadastro de Vendedor"
	WSDATA Fields			AS STRING	OPTIONAL
	WSDATA Order			AS STRING	OPTIONAL
	WSDATA Page				AS INTEGER	OPTIONAL
	WSDATA PageSize			AS INTEGER	OPTIONAL
	WSDATA Code		AS STRING	OPTIONAL
 
    WSMETHOD GET Main ;
    DESCRIPTION "Carrega todos os vendedores" ;
    WSSYNTAX "/Sellers/{Order, Page, PageSize, Fields}" ;
    PATH "/Sellers"

    WSMETHOD POST Main ;
    DESCRIPTION "Cadastra um novo Vendedor" ;
    WSSYNTAX "/Sellers/" ;
    PATH "/Sellers"	

	WSMETHOD GET Code ;
    DESCRIPTION "Carrega um vendedor específico" ;
    WSSYNTAX "/Sellers/{Code}/{Order, Page, PageSize, Fields}" ;
    PATH "/Sellers/{Code}"

	WSMETHOD PUT Code ;
    DESCRIPTION "Altera um vendedor específico" ;
    WSSYNTAX "/Sellers/{Code}/{Order, Page, PageSize, Fields}" ;
    PATH "/Sellers/{Code}"

	WSMETHOD DELETE Code ;
    DESCRIPTION "Deleta um vendedor específico" ;
    WSSYNTAX "/Sellers/{Code}/{Order, Page, PageSize, Fields}" ;
    PATH "/Sellers/{Code}"


ENDWSRESTFUL

/*/{Protheus.doc} GET / Seller/Sellers
Retorna todos os vendedores

@param	Order		, caracter, Ordenação da tabela principal
@param	Page		, numérico, Número da página inicial da consulta
@param	PageSize	, numérico, Número de registro por páginas
@param	Fields		, caracter, Campos que serão retornados no GET.

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

WSMETHOD GET Main WSRECEIVE Order, Page, PageSize, Fields WSSERVICE Seller

	Local cError			:= ""
	Local lRet				:= .T.
	Local oApiManager		:= Nil
	
    Self:SetContentType("application/json")

	oApiManager := APIMANAGER():New("mats040","2.001") 
	
	lRet := GetMain(@oApiManager, Self:aQueryString)

	If lRet
		Self:SetResponse( oApiManager:GetJsonSerialize() )
	Else
		cError := oApiManager:GetJsonError()	
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf
	
	oApiManager:Destroy()

Return lRet

/*/{Protheus.doc} POST / Seller/Sellers
Inclui um novo vendedor

@param	Order		, caracter, Ordenação da tabela principal
@param	Page		, numérico, Número da página inicial da consulta
@param	PageSize	, numérico, Número de registro por páginas
@param	Fields		, caracter, Campos que serão retornados no GET.

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/
WSMETHOD POST Main WSRECEIVE Order, Page, PageSize, Fields WSSERVICE Seller
	Local aQueryString	:= Self:aQueryString
    Local cBody 		:= ""
	Local cError		:= ""
    Local lRet			:= .T.
    Local oJsonPositions:= JsonObject():New()
	Local oApiManager 	:= APIMANAGER():New("mats040","2.001")

	Self:SetContentType("application/json")
    cBody 	   := Self:GetContent()

	lRet := ManutVend(3, @oApiManager, cBody)

	If lRet
		aAdd(aQueryString,{"Code",SA3->A3_COD})
		lRet := GetMain(@oApiManager, aQueryString, .F.)
	EndIf

	If lRet
		Self:SetResponse( oApiManager:ToObjectJson() )
	Else
		cError := oApiManager:GetJsonError()
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf

	oApiManager:Destroy()
    FreeObj( oJsonPositions )
	FreeObj( aQueryString )	

Return lRet

/*/{Protheus.doc} GET / Seller/Sellers/Code
Retorna um vendedor específico

@param	Order		, caracter, Ordenação da tabela principal
@param	Page		, numérico, Número da página inicial da consulta
@param	PageSize	, numérico, Número de registro por páginas
@param	Fields		, caracter, Campos que serão retornados no GET.

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/
WSMETHOD GET Code PATHPARAM Code WSRECEIVE Order, Page, PageSize, Fields  WSSERVICE Seller

	Local aFilter			:= {}
	Local cError			:= ""
    Local lRet 				:= .T.
	Local oApiManager		:= APIMANAGER():New("mats040","2.001")
	
	Default Self:Code:= ""

    Self:SetContentType("application/json")
    
	Aadd(aFilter, {"SA3", "cabeçalho",{"A3_COD = '" + Self:Code + "'"}})
	oApiManager:SetApiFilter(aFilter) 	

	If lRet
		lRet := GetMain(@oApiManager, Self:aQueryString)
	EndIf

	If lRet
		
		Self:SetResponse( oApiManager:ToObjectJson() )

	Else
		cError := oApiManager:GetJsonError()
		SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
	EndIf

	oApiManager:Destroy()
	FreeObj(aFilter)

Return lRet

/*/{Protheus.doc} PUT / Seller/Sellers
Altera um vendedor especíifco

@param	Order		, caracter, Ordenação da tabela principal
@param	Page		, numérico, Número da página inicial da consulta
@param	PageSize	, numérico, Número de registro por páginas
@param	Fields		, caracter, Campos que serão retornados no GET.

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/
WSMETHOD PUT Code PATHPARAM Code WSRECEIVE Order, Page, PageSize, Fields  WSSERVICE Seller
	Local aQueryString	:= Self:aQueryString
    Local cBody 		:= ""
	Local cError		:= ""
    Local lRet			:= .T.
    Local oJsonPositions:= JsonObject():New()
	Local oApiManager 	:= APIMANAGER():New("mats040","2.001")

	Self:SetContentType("application/json")

	If lRet
		cBody 	   := Self:GetContent()

		If SA3->(Dbseek(xFilial("SA3") + Self:Code))
			lRet := ManutVend(4, @oApiManager, cBody, aQueryString, Self:Code)
		Else
			lRet := .F.
			oApiManager:SetJsonError("404","Erro durante a alteração do vendedor!","Vendedor não encontrado",/*cHelpUrl*/,/*aDetails*/)
		EndIf 

		If lRet
			aAdd(aQueryString,{"Code",SA3->A3_COD})
			lRet := GetMain(@oApiManager, aQueryString, .F.)
		EndIf 

		If lRet
			Self:SetResponse( oApiManager:ToObjectJson() )
		Else
			cError := oApiManager:GetJsonError()
			SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cError) )
		EndIf

	EndIf

    oApiManager:Destroy()
	FreeObj( oJsonPositions )
 	FreeObj( aQueryString )	

Return lRet

/*/{Protheus.doc} DELETE / Seller/Sellers
Deleta um vendedor

@param	Order		, caracter, Ordenação da tabela principal
@param	Page		, numérico, Número da página inicial da consulta
@param	PageSize	, numérico, Número de registro por páginas
@param	Fields		, caracter, Campos que serão retornados no GET.

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/
WSMETHOD DELETE Code PATHPARAM Code WSRECEIVE Order, Page, PageSize, Fields  WSSERVICE Seller
	Local aFilter			:= {}
	Local cError			:= ""
	Local cResp				:= "Registro Deletado com Sucesso"
    Local lRet 				:= .T.
	Local oApiManager		:= APIMANAGER():New("mats040","2.001")
    Local oJsonPositions	:= JsonObject():New()
	
	Default Self:Code:= ""

    Self:SetContentType("application/json")

	If lRet
		cBody 	   := Self:GetContent()
		If SA3->(Dbseek(xFilial("SA3") + Self:Code))
			lRet := ManutVend(5, @oApiManager, cBody, Self:aQueryString, Self:Code)
		Else
			lRet	:= .F.
			oApiManager:SetJsonError("404","Erro durante a exclusão do vendedor!","Vendedor não encontrado",/*cHelpUrl*/,/*aDetails*/)
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
	FreeObj(aFilter)

Return lRet

/*/{Protheus.doc} ManutVend
Função para incluir/alterar/excluir um vendedor

@param	nOpc			, numérico	, Informa se é uma inclusão (3), alteração (4) ou exclusão (5)
@param	oApiManager		, objeto	, Objeto com a classe API Manager
@param	cBody			, caracter	, Json recebido
@param	aQueryString	, array		, Array com os filtros

@return lRet	, Lógico, Informa se o processo foi executado com sucesso.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/
Static Function ManutVend(nOpc, oApiManager, cBody, aQueryString, cVendedor)
	Local aCab			:= {}
	Local aMsgErro		:= {}
	Local aJson			:= {}
	Local aFatherAlias	:= {"SA3","items", "cabeçalho"}
    Local lRet			:= .T.
	Local nPosVend		:= 0
	Local nX			:= 0
    
	Private lMsErroAuto 	:= .F.
	Private lAutoErrNoFile	:= .T.
	
	Default cVendedor	:= ""
	Default aQueryString:= ""
    
	oApiManager:SetApiQstring(aQueryString)
	oApiManager:SetApiAlias(aFatherAlias)
	oApiManager:Activate()

	If !oApiManager:IsActive()
		lRet := .F.
	Else 
		aJson := oApiManager:GetJsonArray(cBody)
		lRet := CRMJsonToArray({'SA3','items'},, aCab, ,, aJson, 1)
		If lRet
			CRMJsonToArray({'SA3','address'}				,, aCab,,, aJson, 1)
			CRMJsonToArray({'SA3','state'}					,, aCab,,, aJson, 1)
			CRMJsonToArray({'SA3','country'}				,, aCab,,, aJson, 1)
			CRMJsonToArray({'SA3','city'}					,, aCab,,, aJson, 1)
			CRMJsonToArray({'SA3','salesChargeInformation'}	,, aCab,,, aJson, 1)

			nPosVend := (aScan(aCab ,{|x| AllTrim(x[1]) == "A3_COD"}))

			If nOpc == 3
				If nPosVend == 0
					aAdd( aCab, {'A3_COD',MATI40PNum(), Nil})
				EndIf
			ElseIf nOpc == 4
				If nPosVend == 0
					aAdd( aCab, {'A3_COD',cVendedor, Nil})
				Else
					aCab[nPosVend][2] := cVendedor
				EndIf
			Else
				If nPosVend == 0
					aAdd( aCab, {'A3_COD',cVendedor, Nil})
				Else
					aCab[nPosVend][2] := cVendedor
				EndIf
			EndIf
			
			MSExecAuto( { |x, y| MATA040( x, y ) }, aCab, nOpc )

			If lMsErroAuto
				aMsgErro := GetAutoGRLog()
				cResp	 := ""
				For nX := 1 To Len(aMsgErro)
					cResp += StrTran( StrTran( aMsgErro[nX], "<", "" ), "-", "" ) + (" ") 
				Next nX	
				lRet := .F.
				oApiManager:SetJsonError("400","Erro durante inclusão/alteração do vendedor!.", cResp,/*cHelpUrl*/,/*aDetails*/)
			EndIf
		Else
			oApiManager:SetJsonError("400","Erro durante a conversão do Json!.", "Verifique o Json Informado",/*cHelpUrl*/,/*aDetails*/)
		EndIf
	EndIf
    FreeObj( aCab )

Return lRet

/*/{Protheus.doc} GetMain
Realiza o Get da tabela SA3

@param oApiManager	, Objeto	, Objeto ApiManager inicializado no método 
@param aQueryString	, Array		, Array com os filtros a serem utilizados no Get
@param lHasNext		, Lógico	, Informa se informará se existem ou não mais páginas a serem exibidas

@return lRet	, Lógico	, Retorna se conseguiu ou não processar o Get.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

Static Function GetMain(oApiManager, aQueryString, lHasNext)
	Local aRelation			:= {{"A3_FILIAL","A3_FILIAL"},{"A3_COD","A3_COD"}}
	Local aChildAddress		:= {"SA3", "address","EndCabeçalho"}
	Local aChildState		:= {"SA3", "state","EstadoCabeçalho"}
	Local aChildCountry		:= {"SA3", "country", "PaisCabeçalho"}
	Local aChildCity		:= {"SA3", "city","CidadeCabeçalho"}
	Local aChildChInfo		:= {"SA3", "salesChargeInformation", "InfoCom"}
	Local aFatherAlias		:= {"SA3", "items","cabeçalho"}
	Local cIndexKey			:= "A3_FILIAL, A3_COD"
    Local lRet 				:= .T.
	Local nLenJson			:= 0
	Local oJson				:= Nil

	Default aQueryString	:={,}
	Default oApiManager		:= Nil
	Default lHasNext		:= .T.

	oApiManager:SetApiRelation(aChildChInfo	,aFatherAlias,aRelation,cIndexKey)
	oApiManager:SetApiRelation(aChildAddress,aFatherAlias,aRelation,cIndexKey)
	oApiManager:SetApiRelation(aChildState	,aChildAddress,aRelation,cIndexKey)
	oApiManager:SetApiRelation(aChildCountry,aChildAddress,aRelation,cIndexKey)
	oApiManager:SetApiRelation(aChildCity	,aChildAddress,aRelation,cIndexKey)

	lRet := ApiMainGet(@oApiManager, aQueryString, , , aFatherAlias, , oApiManager:GetApiAdapter(), oApiManager:GetApiVersion(), lHasNext)

	If lRet
		oJson	:= oApiManager:GetJsonObject()
		nLenJson	:= Len(oJson[oApiManager:cApiName])
	EndIf

	FreeObj( aRelation )
	FreeObj( aFatherAlias )
	FreeObj( aChildAddress )
	FreeObj( aChildChInfo )	
	FreeObj( aChildState )
	FreeObj( aChildCountry )
	FreeObj( aChildCity )	

Return lRet

/*/{Protheus.doc} MATI40PNum

Rotina para retornar o Proximo numero para gravação

@return cProxNum	, caracter	, Código do vendedor.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/
Static Function MATI40PNum()

	Local cProxNum := ""

	cProxNum := GETSX8NUM("SA3","A3_COD")
	While .T.
		If SA3->( DbSeek( xFilial("SA3")+cProxNum ) )
			ConfirmSX8()
			cProxNum:=GetSXeNum("SA3","A3_COD")
		Else
			Exit
		Endif
	Enddo

Return(cProxNum)

/*/{Protheus.doc} ApiMap
Estrutura a ser utilizada na classe ServicesApiManager

@return cRet	, caracter	, Mensagem de retorno de sucesso/erro.

@author		Squad Faturamento/CRM
@since		06/08/2018
@version	12.1.20
/*/

Static Function ApiMap()
	Local apiMap		:= {}
	Local aStrSA3Pai    := {}
	Local aStrSA3End    := {}
	Local aStrSA3Cid	:= {}
	Local aStrSA3Est    := {}
	Local aStrSA3Con    := {}	
	Local aStrSA3Com	:= {}
	Local aStructAlias  := {}
	
	aStrSA3Pai    :=	{"SA3","Field","items","cabeçalho",;
							{;
								{"companyId"					, "Exp:cEmpAnt"													},;
								{"branchID"						, "Exp:cFilAnt"													},;
								{"CompanyInternalId"			, "Exp:cFilAnt, Exp:cFilAnt"									},;
								{"code"							, "A3_COD"														},;
								{"internalId"					, "A3_FILIAL, A3_COD"											},;
								{"name"							, "A3_NOME"														},;
								{"shortName"					, "A3_NREDUZ"													},;
								{"personalIdentification"		, "A3_CGC"														},;
								{"sellerPassWord"				, "A3_SENHA"													},;
								{"sellerPhoneDDD"				, "A3_DDDTEL"													},;
								{"sellerPhone"					, "A3_TEL"														},;
								{"sellerEmail"					, "A3_EMAIL"													},;
								{"representativeType"			, ""															},;
								{"active"						, "A3_MSBLQL"													};
							},;
						}
							
	aStrSA3End    := 	{"SA3","Field","address","EndCabeçalho",;
							{;
								{"address"						, "A3_END"	},;
								{"complement"					, ""															},;
								{"number"						, ""															},;
								{"district"						, "A3_BAIRRO"													},;
								{"region"						, ""															},;
								{"zipCode"						, "A3_CEP"  													},;
								{"poBox"						, ""															},;
								{"mainAddress"					, "Exp:.T."														},;
								{"shippingAddress"				, "Exp:.T."														},;
								{"billingAddress"				, "Exp:.T."														};
							},;
						}

	aStrSA3Cid    := 	{"SA3","Field","city","CidadeCabeçalho",;
							{; 
								{"cityId"						, "A3_MUN"														},;
								{"cityInternalId"				, "A3_MUN"														},;
								{"cityDescription"				, ""															};
							},;
						}

	aStrSA3Est    := 	{"SA3","Field","state","EstadoCabeçalho",;
							{;
								{"stateId"						, "A3_EST"														},;
								{"stateInternalId"				, "A3_EST"														},;
								{"stateDescription"				, ""															};
							},;
						}

	aStrSA3Con    := 	{"SA3","Field","country","PaisCabeçalho",;
							{;
								{"countryId"					, "A3_PAIS"														},;
								{"countryInternalId"			, "A3_PAIS"														},;
								{"countryDescription"			, ""															};
							},;
						}


	aStrSA3Com    := 	{"SA3","Field","salesChargeInformation","InfoCom",;
							{;
								{"customerVendorInternalId"		, "A3_FORNECE"													},;
								{"salesChargeInterface"			, "A3_GERASE2"													},;
								{"indirectSeller"				, "A3_GERASE2"													},;
								{"indirectSellerInternalId"		, ""															};
							},;
						}

	aStructAlias  := {aStrSA3Pai, aStrSA3End, aStrSA3Cid, aStrSA3Est, aStrSA3Con, aStrSA3Com}
	
	apiMap := {"MATS040","items","2.001","MATA040",aStructAlias,"cabeçalho"}

Return apiMap