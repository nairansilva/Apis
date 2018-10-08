#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"

//dummy function
Function CRMS610()
Return

//------------------------------------------------------------------------------
/*/{Protheus.doc} MarketSegments

RESTfull service to perform a list of HTTP Verbs for the MarketSegment  

@author		Renato da Cunha
@since		26/07/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
WSRESTFUL MarketSegments DESCRIPTION "Segmentos"
    WSDATA MarketSegmentID	AS STRING 	OPTIONAL
    WSDATA Order        	AS STRING 	OPTIONAL
	WSDATA Fields        	AS STRING 	OPTIONAL
    WSDATA Page			    AS INTEGER	OPTIONAL
	WSDATA PageSize		    AS INTEGER	OPTIONAL 

    WSMETHOD GET main  ;
    DESCRIPTION  'Lista todos os Seguimentos cadastrados na tabela AOV'    ;
    WSSYNTAX "/marketSegments/{Order, Page, PageSize, Fields}";
    PATH "/marketSegment" 

    WSMETHOD Post main  ;
    DESCRIPTION  'Inclui um cadastrado na tabela AOV';
    WSSYNTAX "/marketSegments/";
    PATH "/marketSegment" 
	
    WSMETHOD GET segmentId;
    DESCRIPTION  'Obtem um segmento pelo seu código (AOV_CODSEG)';
    WSSYNTAX "/marketSegments/{MarketSegmentID}/{Order, Page, PageSize, Fields}";
    PATH "/marketSegment/{MarketSegmentID}"

    WSMETHOD PUT segmentId;
    DESCRIPTION  'Altera um segmento pelo seu código (AOV_CODSEG)';
    WSSYNTAX "/marketSegments/{MarketSegmentID}";
    PATH "/marketSegment/{MarketSegmentID}"

    WSMETHOD DELETE segmentId;
    DESCRIPTION  'Excluí um segmento pelo seu código (AOV_CODSEG)';
    WSSYNTAX "/marketSegments/{MarketSegmentID}";
    PATH "/marketSegment/{MarketSegmentID}"

ENDWSRESTFUL

//------------------------------------------------------------------------------
/*/{Protheus.doc} MarketSegments

    Return a object with a list of MarketSegments data.

@author		Renato da Cunha
@since		26/07/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
WSMETHOD GET main WSRECEIVE Order, Page, PageSize, Fields  WSSERVICE MarketSegments
    Local cIndexKey	        := "AOV_FILIAL, AOV_CODSEG"
    Local cMsgErr           := 'Erro na Requisição'
    Local aConditions	    := {{"AOV_FILIAL","AOV_FILIAL"},{"AOV_CODSEG","AOV_PAI"}}
    Local aChildrenAlias    := { "AOV", "childs", "childs"}
    Local aFatherAlias      := { "AOV","items", "marketSegment" }
    Local oApiManager       := Nil
    Local lRet              := .T.

    Default Self:Fields		    := ''
	Default Self:Order		    := ''
	Default Self:Page		    := 0
	Default Self:PageSize	    := 0
    Default Self:aQueryString   := {}
    Private lMsErroAuto         := .F.
    Self:SetContentType('application/json')
    oApiManager := APIMANAGER():New("crms610","2.000")

    If !ApiMainGet(@oApiManager, Self:aQueryString, aConditions, aChildrenAlias,aFatherAlias, cIndexKey,'crms610', '2.000', .T.)
        lRet := .F.
        cMsgErr := oApiManager:GetJsonError()	
		SetRestFault( Val(oApiManager:oJsonError['code']) , EncodeUtf8(cMsgErr) )
    Else    
        Self:SetResponse( oApiManager:GetJsonSerealize() )
    EndIf
    
    Asize(aConditions,0)
    aConditions	    := {}
   
    Asize(aChildrenAlias,0)
    aChildrenAlias  := {}
   
    Asize(aFatherAlias,0)
    aFatherAlias    := {}

    oApiManager:Destroy()
    oApiManager := Nil 

Return lRet

//------------------------------------------------------------------------------
/*/{Protheus.doc} MarketSegments

    Return a object with a list of MarketSegments data.

@author		Renato da Cunha
@since		26/07/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
WSMETHOD POST main  WSSERVICE MarketSegments
    Local aFatherAlias := { "AOV","items", "marketSegment" }
    Local cErr         := ''
    Local cBody        := ''
    Local oApiManager  := Nil
    Local lRet         := .T.

    Private lMsErroAuto := .F.
    
    Self:SetContentType('application/json')
    cBody       := Self:GetContent()
    oApiManager := APIMANAGER():New("crms610","2.000")
    oApiManager:SetApiQstring(Self:aQueryString)
	oApiManager:SetApiAlias(aFatherAlias)
	oApiManager:Activate()

    If !oApiManager:IsActive() .Or. !UpDateMyAOV(@oApiManager,Nil,oApiManager:GetJsonArray(cBody), 3)
        lRet := .F. 
        cErr := oApiManager:GetJsonError()
        SetRestFault( Val(oApiManager:oJsonError['code']), EncodeUtf8(cErr) )
    Else
        Self:SetResponse( oApiManager:ToObjectJson() )
    EndIf
	
Return lRet

//------------------------------------------------------------------------------
/*/{Protheus.doc} MarketSegments

Obtem segmento pelo ID

@author		Renato da Cunha
@since		26/07/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
WSMETHOD GET segmentId PATHPARAM MarketSegmentID  WSSERVICE MarketSegments
    Local lRet          := .T.
    Local cErr          := ''
    Local cIndexKey     := 'AOV_FILIAL, AOV_CODSEG'
    Local cSource       := 'crms610'
    Local cVersion      := '2.000'
    Local aChildrenAlias:= { "AOV", "childs", "childs" }
    Local aFatherAlias  := { "AOV","items", "marketSegment" }
    Local aConditions   := {{"AOV_FILIAL","AOV_FILIAL"},{"AOV_CODSEG","AOV_PAI"}} 
    Local aFilter       := {}
    Local oApiManager   := Nil

    Default Self:MarketSegmentID:= ''
    
    Self:SetContentType('application/json')
    oApiManager := APIMANAGER():New(cSource,cVersion)
    
    Aadd(aFilter, {"AOV", "marketSegment",{"AOV_CODSEG = '" + Self:MarketSegmentID + "'"}})
    oApiManager:SetApiFilter(aFilter) 
    
    If !ApiMainGet(@oApiManager, Self:aQueryString, aConditions, aChildrenAlias,aFatherAlias, cIndexKey,cSource, cVersion, .T.)
        lRet := .F.
        cErr := oApiManager:GetJsonError()	
		SetRestFault( Val(oApiManager:oJsonError['code']) , EncodeUtf8(cErr) )
    Else    
        Self:SetResponse( oApiManager:ToObjectJson() )
    EndIf
    
Return lRet

//------------------------------------------------------------------------------
/*/{Protheus.doc} MarketSegments
Altera um Segmento

@author		Renato da Cunha
@since		26/07/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
WSMETHOD PUT segmentId PATHPARAM MarketSegmentID  WSSERVICE MarketSegments
    Local lRet          := .T.
    Local cErr          := ''
    Local cBody         := ''
    Local aFatherAlias  := { "AOV","items", "marketSegment" }
    Local oApiManager   := Nil

    Private lMsErroAuto := .F.

    Default Self:MarketSegmentID    := ''
    
    Self:SetContentType('application/json')
    cBody       := Self:GetContent()
    oApiManager := APIMANAGER():New("crms610","2.000")
    oApiManager:SetApiQstring(Self:aQueryString)
	oApiManager:SetApiAlias(aFatherAlias)
	oApiManager:Activate()
   
    If !UpDateMyAOV(@oApiManager, Self:MarketSegmentID,  oApiManager:GetJsonArray(cBody) , 4 )//!lRet .Or. !ApiMainGet(@oApiManager, Self:aQueryString, aConditions, aChildrenAlias,aFatherAlias, cIndexKey,cSource, cVersion, .T.)
        lRet := .F.
        cErr := oApiManager:GetJsonError()	
		SetRestFault( Val(oApiManager:oJsonError['code']) , EncodeUtf8(cErr) )
    Else    
        Self:SetResponse( oApiManager:ToObjectJson() )
    EndIf
    
Return lRet

//------------------------------------------------------------------------------
/*/{Protheus.doc} MarketSegments
Deleta o segmento informado

@author		Renato da Cunha
@since		26/07/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
WSMETHOD DELETE segmentId PATHPARAM MarketSegmentID  WSSERVICE MarketSegments
    Local lRet          := .T.
    Local cErr          := ''
    Local cBody         := ''
    Local aFatherAlias  := { "AOV","items", "marketSegment" }
    Local oApiManager   := Nil
    Local oJsonResponse := Nil

    Private lMsErroAuto := .F.

    Default Self:MarketSegmentID    := ''
    
    Self:SetContentType('application/json')
    cBody       := Self:GetContent()
    oApiManager := APIMANAGER():New("crms610","2.000")
    oApiManager:SetApiQstring(Self:aQueryString)
	oApiManager:SetApiAlias(aFatherAlias)
	oApiManager:Activate()
   
    If !UpDateMyAOV(@oApiManager, Self:MarketSegmentID,  oApiManager:GetJsonArray(cBody) , 5 )
        lRet := .F.
        cErr := oApiManager:GetJsonError()	
		SetRestFault(Val(oApiManager:oJsonError['code']) , EncodeUtf8(cErr))
    Else
        oJsonResponse := JsonObject():New()
        oJsonResponse['response'] := 'Segmento Deletado com Sucesso!!!'
		Self:SetResponse( EncodeUtf8(FwJsonSerialize( oJsonResponse, .T. )))
        
        oJsonResponse:Destroy()
    EndIf
    
Return lRet

//------------------------------------------------------------------------------
/*/{Protheus.doc} FindMyAAOV

Indica se o registro existe na base.

@author		Renato da Cunha
@since		26/07/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
Static Function FindMyAAOV(cCodSegment)
    Local lRet := .T.
    Default cCodSegment := ''
    
    If Empty(cCodSegment)
        lRet := .F.
    Else
        DbSelectArea('AOV')
        DbSetOrder(1)//AOV_FILIAL+AOV_CODSEG
        If !MsSeek(xFilial('AOV') + cCodSegment)
            lRet := .F. 
        EndIf
    EndIf
Return lRet

//------------------------------------------------------------------------------
/*/{Protheus.doc} UpDateMyAOV

Atualiza o registro conforme NOPC

@author		Renato da Cunha
@since		26/07/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
Static Function UpDateMyAOV(oApiManager, cCodSegment, aJson, nOpc)
    Local lRet              := .T.
    Local lSx8Num           := .F.

    Local cIndexKey	        := "AOV_FILIAL, AOV_CODSEG"
    Local cErr              := 'Erro na Requisição'
    Local aConditions	    := {{"AOV_FILIAL","AOV_FILIAL"},{"AOV_CODSEG","AOV_PAI"}}
    Local aChildrenAlias    := { "AOV", "childs", "childs" }
    Local aFatherAlias      := { "AOV","items", "marketSegment" }
    Local aHeader           := {}
    Local aMsgErro          := {}
    Local aQueryString      := {}

    Local nPosCodSeg        := 0
    Local nPosMain          := 0 
    Local nX                := 0 

    Default oApiManager     := Nil 
    Default  cCodSegment    := ''
    Default  aJson          := {} 
    Default  nOpc           := 3

    Private lAutoErrNoFile	:= .T.

    Do Case 
        //Post
        Case nOpc == 3
            If !CRMJsonToArray({'AOV','items'},Nil, aHeader, Nil, Nil, aJson, 1)
                lRet := .F.
                oApiManager:SetJsonError("400","Erro durante inclusão do Segmento.", cErr,/*cHelpUrl*/,/*aDetails*/)
            Else
                nPosCodSeg := aScan( aHeader, { |x| x[1] == 'AOV_CODSEG' } )
                nPosMain   := aScan( aHeader, { |x| x[1] == 'AOV_PRINC' } )

                If nPosCodSeg ==  0
                    cCodSegment := GetSX8num("AOV", "AOV_CODSEG")
                    lSx8Num     := .T.
                    aadd(aHeader, {"AOV_CODSEG", cCodSegment} )
                Else
                    cCodSegment := aHeader[nPosCodSeg][2]
                EndIf

                If nPosMain > 0 
                    //Se não for Segmento principal remove do array por conta do Gatilho que lima o campo
                    If aHeader[nPosMain][2] <> '1'
                        adel(aHeader, nPosMain)
                        aSize(aHeader,Len(aHeader)-1)
                    EndIf
                EndIf
            EndIf
       
        //Put    
        Case nOpc == 4 
            If !FindMyAAOV(cCodSegment)
                lRet := .F.
                cErr := "Segmento Não Encontrado!!!"
                oApiManager:SetJsonError("404","Erro durante Alteração do Segmento.", cErr,/*cHelpUrl*/,/*aDetails*/)
            
            ElseIf !CRMJsonToArray({'AOV','items'},Nil, aHeader, Nil, Nil, aJson, 1)
                lRet := .F.
                oApiManager:SetJsonError("400","Erro durante Alteração do Segmento.", cErr,/*cHelpUrl*/,/*aDetails*/)
            Else
                nPosMain   := aScan( aHeader, { |x| x[1] == 'AOV_PRINC' } )
                If nPosMain > 0 
                    //Se não for Segmento principal remove do array por conta do Gatilho que limpa o campo
                    If aHeader[nPosMain][2] <> '1' .And. AOV->AOV_PRINC <> '1'
                        adel(aHeader, nPosMain)
                        aSize(aHeader,Len(aHeader)-1)
                    EndIf
                EndIf

            EndIf
       
        //Delete
        Case nOpc == 5
            If !FindMyAAOV(cCodSegment)
                lRet := .F.
                cErr := "Segmento Não Encontrado!!!"
                oApiManager:SetJsonError("404","Erro durante exclusão do Segmento.", cErr,/*cHelpUrl*/,/*aDetails*/)
            
            ElseIf !CRMJsonToArray({'AOV','items'},Nil, aHeader, Nil, Nil, aJson, 1)
                lRet := .F.
                oApiManager:SetJsonError("400","Erro durante exclusão do Segmento.", cErr,/*cHelpUrl*/,/*aDetails*/)
            EndIf

        OtherWise
            lRet := .F.
    EndCase

    If lRet
        MSExecAuto({|x, y| CRMA610(x, y)}, aHeader,nOpc)

        If lMsErroAuto
            If lSx8Num
                RollBackSx8()
            EndIf

            aMsgErro := GetAutoGRLog()
            cErr	 := ""
            
            For nX := 1 To Len(aMsgErro)
                cErr += StrTran( StrTran( aMsgErro[nX], "<", "" ), "-", "" ) + (" ") 
            Next nX	
            
            lRet := .F.
            oApiManager:SetJsonError("400","Erro durante inclusão do Segmento.", cErr,/*cHelpUrl*/,/*aDetails*/)
        Else
            If lSx8Num
                ConfirmSx8()
            EndIf

            If nOpc <> 5
                 aAdd(aQueryString,{"marketSegmentID",cCodSegment})
                 lRet := ApiMainGet(@oApiManager, aQueryString, aConditions, aChildrenAlias,aFatherAlias, cIndexKey,'crms610', '2.000', .T.)
            EndIf
        EndIf

    EndIf
Return lRet

//------------------------------------------------------------------------------
/*/{Protheus.doc} APIMAP

Mapa de dados utilizado pela classe APIManager

@author		Renato da Cunha
@since		26/07/2018
@version	12.1.17
/*/
//------------------------------------------------------------------------------
Static Function APIMAP()
    Local aStructAOV    := {}
	Local aStructAlias  := {}
    Local aStructChilds := {}
    Local aApiMap       := {}
	
    aStructAOV := {"AOV","Field","items", "marketSegment",;
							{;
								{"marketSegmentID"                  , "AOV_CODSEG"      },;
								{"branchID"				            , "AOV_FILIAL" 	    },;
								{"marketSegmentDescription"			, "AOV_DESSEG"  	},;
								{"mainMarketSegment"				, "AOV_PRINC"       },;
								{"parentMarketSegment"				, "AOV_PAI"	    	},;
								{"parentMarketSegmentDescription"	, "AOV_DESPAI"		};							
							};
					}
    aStructChilds := { "AOV", "ITEM", "childs", "childs",;
                        {;
                        	{"childMarketSegmentId"			, "AOV_CODSEG" 	},;
							{"childMarketSegmantDescription" , "AOV_DESSEG"   };
                        };
                    }
	aStructAlias  := {aStructAOV,aStructChilds}
	aApiMap := {"crms610","items","2.000","crms610",aStructAlias}
Return aApiMap