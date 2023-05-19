object kmServer: TkmServer
  OldCreateOrder = False
  OnDestroy = RemoteDataModuleDestroy
  Height = 417
  Width = 505
  object DB: TDatabase
    AliasName = 'kmService'
    DatabaseName = 'kmService_Data'
    LoginPrompt = False
    Params.Strings = (
      'username=SYSDBA'
      'password=masterkey'
      '')
    SessionName = 'Session_1'
    TransIsolation = tiDirtyRead
    Left = 20
    Top = 10
  end
  object DBIndex: TDatabase
    AliasName = 'kmService'
    DatabaseName = 'DBIndex'
    LoginPrompt = False
    Params.Strings = (
      'USERNAME=SYSDBA'
      'PASSWORD=masterkey')
    SessionName = 'Session_1'
    TransIsolation = tiDirtyRead
    Left = 17
    Top = 58
  end
  object Session: TSession
    Active = True
    AutoSessionName = True
    Left = 16
    Top = 109
  end
  object qUpd: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    ParamCheck = False
    SQL.Strings = (
      '')
    Left = 344
    Top = 7
  end
  object qUpd1: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    ParamCheck = False
    Left = 344
    Top = 52
  end
  object qUpd2: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    ParamCheck = False
    Left = 344
    Top = 97
  end
  object qUpd3: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    ParamCheck = False
    Left = 344
    Top = 142
  end
  object MiscQuery: TDataSetProvider
    DataSet = qMiscQuery
    Options = [poAllowCommandText]
    UpdateMode = upWhereChanged
    BeforeUpdateRecord = PR_BeforeUpdateRecord
    Left = 342
    Top = 273
  end
  object qMiscQuery: TQuery
    ObjectView = True
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    ParamCheck = False
    Left = 305
    Top = 273
  end
  object qrTemp: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    ParamCheck = False
    Left = 416
    Top = 8
  end
  object tArticle: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    SQL.Strings = (
      'SELECT'
      '  ARTICLE.ID,'
      '  ARTICLE.CODE,'
      '  ARTICLE.REPLCODE,'
      '  ARTICLE.NAME,'
      '  ARTICLE.PRICE,'
      '  ARTICLE.SUPPLYPRICE,'
      '  ARTICLE.DESCRIPTION,'
      '  ARTICLE.USED,'
      '  ARTICLE.C_USER_ID,'
      '  ARTICLE.C_ACTIONDATETIME'
      'FROM ARTICLE')
    Left = 164
    Top = 27
    object tArticleID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tArticleCODE: TStringField
      FieldName = 'CODE'
      Origin = 'MTKAMI2000_DATA_SL.ARTICLE.CODE'
      Size = 35
    end
    object tArticleREPLCODE: TStringField
      FieldName = 'REPLCODE'
      Origin = 'KMSERVICE_DATA.ARTICLE.REPLCODE'
      Size = 32
    end
    object tArticleNAME: TStringField
      FieldName = 'NAME'
      Origin = 'MTKAMI2000_DATA_SL.ARTICLE.NAME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object tArticlePRICE: TFloatField
      FieldName = 'PRICE'
    end
    object tArticleSUPPLYPRICE: TFloatField
      FieldName = 'SUPPLYPRICE'
      Origin = 'KMSERVICE_DATA.ARTICLE.SUPPLYPRICE'
    end
    object tArticleDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Origin = 'KMSERVICE_DATA.ARTICLE.DESCRIPTION'
      Size = 250
    end
    object tArticleUSED: TSmallintField
      FieldName = 'USED'
    end
    object tArticleC_ACTIONDATETIME: TDateTimeField
      FieldName = 'C_ACTIONDATETIME'
      Origin = 'MTKAMI2000_DATA_SL.ARTICLE.C_ACTIONDATETIME'
      ProviderFlags = [pfInUpdate]
    end
    object tArticleC_USER_ID: TIntegerField
      FieldName = 'C_USER_ID'
    end
  end
  object Article: TDataSetProvider
    DataSet = tArticle
    Options = [poAutoRefresh, poPropogateChanges]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = HandleUpdateError
    BeforeUpdateRecord = PR_BeforeUpdateRecord
    Left = 198
    Top = 27
  end
  object tUserName: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    SQL.Strings = (
      'SELECT'
      '  USERNAME.ID,'
      '  USERNAME.NAME,'
      '  USERNAME.PASS,'
      '  USERNAME.RIGHTS,'
      '  USERNAME.USED,'
      '  USERNAME.EMAIL,'
      '  USERNAME.MOBILE,'
      '  USERNAME.PHONE,'
      '  USERNAME.FAX,'
      '  USERNAME.C_ACTIONDATETIME'
      'FROM USERNAME')
    Left = 164
    Top = 75
    object IntegerField1: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object StringField2: TStringField
      FieldName = 'NAME'
      Origin = 'KMSERVICE_DATA.USERNAME.NAME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object tUserNamePASS: TStringField
      FieldName = 'PASS'
      Origin = 'KMSERVICE_DATA.USERNAME.PASS'
      Size = 16
    end
    object tUserNameRIGHTS: TStringField
      FieldName = 'RIGHTS'
      Origin = 'KMSERVICE_DATA.USERNAME.RIGHTS'
      Size = 50
    end
    object tUserNameUSED: TSmallintField
      FieldName = 'USED'
      Origin = 'KMSERVICE_DATA.USERNAME.USED'
    end
    object tUserNameEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'KMSERVICE_DATA.USERNAME.EMAIL'
      Size = 50
    end
    object tUserNameMOBILE: TStringField
      FieldName = 'MOBILE'
      Origin = 'KMSERVICE_DATA.USERNAME.MOBILE'
      Size = 50
    end
    object tUserNamePHONE: TStringField
      FieldName = 'PHONE'
      Origin = 'KMSERVICE_DATA.USERNAME.PHONE'
      Size = 50
    end
    object tUserNameFAX: TStringField
      FieldName = 'FAX'
      Origin = 'KMSERVICE_DATA.USERNAME.FAX'
      Size = 50
    end
    object tUserNameC_ACTIONDATETIME: TDateTimeField
      FieldName = 'C_ACTIONDATETIME'
      Origin = 'KMSERVICE_DATA.USERNAME.C_ACTIONDATETIME'
      ProviderFlags = [pfInUpdate]
    end
  end
  object UserName: TDataSetProvider
    DataSet = tUserName
    Options = [poAutoRefresh, poPropogateChanges]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = HandleUpdateError
    BeforeUpdateRecord = PR_BeforeUpdateRecord
    Left = 198
    Top = 75
  end
  object Mashine: TDataSetProvider
    DataSet = tMashine
    Options = [poAutoRefresh, poPropogateChanges]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = HandleUpdateError
    BeforeUpdateRecord = PR_BeforeUpdateRecord
    Left = 208
    Top = 123
  end
  object tMashine: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    SQL.Strings = (
      'SELECT'
      '  MASHINE.ID,'
      '  MASHINE.MTYPE,'
      '  MASHINE.NAME,'
      '  MASHINE.PRODUCER,'
      '  MASHINE.H250,'
      '  MASHINE.H500,'
      '  MASHINE.H750,'
      '  MASHINE.H1000,'
      '  MASHINE.H1250,'
      '  MASHINE.H1500,'
      '  MASHINE.H1750,'
      '  MASHINE.H2000,'
      '  MASHINE.H2500,'
      '  MASHINE.H3000,'
      '  MASHINE.H4000,'
      '  MASHINE.H4500,'
      '  MASHINE.H5000,'
      '  MASHINE.C_USER_ID,'
      '  MASHINE.C_ACTIONDATETIME,'
      '  0 AS L_CLIENT_ID,'
      
        '  '#39'                                                             ' +
        '   '#39' AS L_CLIENT,'
      
        '  '#39'                                                             ' +
        '   '#39' AS L_SERIALNO,'
      
        '  '#39'                                                             ' +
        '   '#39' AS L_ENGINE'
      'FROM MASHINE')
    Left = 163
    Top = 123
    object tMashineID: TIntegerField
      FieldName = 'ID'
      Origin = 'KMSERVICE_DATA.MASHINE.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tMashineMTYPE: TStringField
      FieldName = 'MTYPE'
      Origin = 'KMSERVICE_DATA.MASHINE.MTYPE'
      Size = 32
    end
    object tMashineNAME: TStringField
      FieldName = 'NAME'
      Origin = 'KMSERVICE_DATA.MASHINE.NAME'
      Size = 64
    end
    object tMashinePRODUCER: TStringField
      FieldName = 'PRODUCER'
      Origin = 'KMSERVICE_DATA.MASHINE.PRODUCER'
      Size = 64
    end
    object tMashineH250: TSmallintField
      FieldName = 'H250'
      Origin = 'KMSERVICE_DATA.MASHINE.H250'
    end
    object tMashineH500: TSmallintField
      FieldName = 'H500'
      Origin = 'KMSERVICE_DATA.MASHINE.H500'
    end
    object tMashineH750: TSmallintField
      FieldName = 'H750'
      Origin = 'KMSERVICE_DATA.MASHINE.H750'
    end
    object tMashineH1000: TSmallintField
      FieldName = 'H1000'
      Origin = 'KMSERVICE_DATA.MASHINE.H1000'
    end
    object tMashineH1250: TSmallintField
      FieldName = 'H1250'
      Origin = 'KMSERVICE_DATA.MASHINE.H1250'
    end
    object tMashineH1500: TSmallintField
      FieldName = 'H1500'
      Origin = 'KMSERVICE_DATA.MASHINE.H1500'
    end
    object tMashineH1750: TSmallintField
      FieldName = 'H1750'
      Origin = 'KMSERVICE_DATA.MASHINE.H1750'
    end
    object tMashineH2000: TSmallintField
      FieldName = 'H2000'
      Origin = 'KMSERVICE_DATA.MASHINE.H2000'
    end
    object tMashineH2500: TSmallintField
      FieldName = 'H2500'
      Origin = 'KMSERVICE_DATA.MASHINE.H2500'
    end
    object tMashineH3000: TSmallintField
      FieldName = 'H3000'
      Origin = 'KMSERVICE_DATA.MASHINE.H3000'
    end
    object tMashineH4000: TSmallintField
      FieldName = 'H4000'
      Origin = 'KMSERVICE_DATA.MASHINE.H4000'
    end
    object tMashineH4500: TSmallintField
      FieldName = 'H4500'
      Origin = 'KMSERVICE_DATA.MASHINE.H4500'
    end
    object tMashineH5000: TSmallintField
      FieldName = 'H5000'
      Origin = 'KMSERVICE_DATA.MASHINE.H5000'
    end
    object tMashineC_USER_ID: TIntegerField
      FieldName = 'C_USER_ID'
      Origin = 'KMSERVICE_DATA.MASHINE.C_USER_ID'
    end
    object tMashineC_ACTIONDATETIME: TDateTimeField
      FieldName = 'C_ACTIONDATETIME'
      Origin = 'KMSERVICE_DATA.MASHINE.C_ACTIONDATETIME'
    end
    object tMashineL_CLIENT_ID: TIntegerField
      FieldName = 'L_CLIENT_ID'
      ProviderFlags = []
    end
    object tMashineL_CLIENT: TStringField
      FieldName = 'L_CLIENT'
      Origin = 'KMSERVICE_DATA.CLIENT.NAME'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object tMashineL_SERIALNO: TStringField
      FieldName = 'L_SERIALNO'
      Origin = 'KMSERVICE_DATA.MASHINESERIAL.SERIALNO'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object tMashineL_ENGINE: TStringField
      FieldName = 'L_ENGINE'
      Origin = 'KMSERVICE_DATA.MASHINESERIAL.ENGINE'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
  end
  object MashineDetail: TDataSetProvider
    DataSet = tMashineDetail
    Options = [poAutoRefresh, poPropogateChanges]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = HandleUpdateError
    BeforeUpdateRecord = PR_BeforeUpdateRecord
    Left = 209
    Top = 175
  end
  object tMashineDetail: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    SQL.Strings = (
      'SELECT'
      '  MASHINEDETAIL.ID,'
      '  MASHINEDETAIL.MASHINE_ID,'
      '  MASHINEDETAIL.ARTICLE_ID,'
      '  MASHINEDETAIL.Q250,'
      '  MASHINEDETAIL.Q500,'
      '  MASHINEDETAIL.Q750,'
      '  MASHINEDETAIL.Q1000,'
      '  MASHINEDETAIL.Q1250,'
      '  MASHINEDETAIL.Q1500,'
      '  MASHINEDETAIL.Q1750,'
      '  MASHINEDETAIL.Q2000,'
      '  MASHINEDETAIL.Q2500,'
      '  MASHINEDETAIL.Q3000,'
      '  MASHINEDETAIL.Q4000,'
      '  MASHINEDETAIL.Q4500,'
      '  MASHINEDETAIL.Q5000,'
      '  MASHINEDETAIL.C_USER_ID,'
      '  MASHINEDETAIL.C_ACTIONDATETIME,'
      '  ARTICLE.CODE L_ARTICLE_CODE,'
      '  ARTICLE.NAME L_ARTICLE_NAME,'
      '  ARTICLE.PRICE L_ARTICLE_PRICE'
      'FROM MASHINEDETAIL'
      '  INNER JOIN ARTICLE ON MASHINEDETAIL.ARTICLE_ID=ARTICLE.ID'
      ''
      'WHERE 1=2')
    Left = 166
    Top = 175
    object tMashineDetailID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tMashineDetailMASHINE_ID: TIntegerField
      FieldName = 'MASHINE_ID'
    end
    object tMashineDetailARTICLE_ID: TIntegerField
      FieldName = 'ARTICLE_ID'
    end
    object tMashineDetailQ250: TFloatField
      FieldName = 'Q250'
    end
    object tMashineDetailQ500: TFloatField
      FieldName = 'Q500'
    end
    object tMashineDetailQ750: TFloatField
      FieldName = 'Q750'
    end
    object tMashineDetailQ1000: TFloatField
      FieldName = 'Q1000'
    end
    object tMashineDetailQ1250: TFloatField
      FieldName = 'Q1250'
    end
    object tMashineDetailQ1500: TFloatField
      FieldName = 'Q1500'
    end
    object tMashineDetailQ1750: TFloatField
      FieldName = 'Q1750'
    end
    object tMashineDetailQ2000: TFloatField
      FieldName = 'Q2000'
    end
    object tMashineDetailQ2500: TFloatField
      FieldName = 'Q2500'
    end
    object tMashineDetailQ3000: TFloatField
      FieldName = 'Q3000'
    end
    object tMashineDetailQ4000: TFloatField
      FieldName = 'Q4000'
    end
    object tMashineDetailQ4500: TFloatField
      FieldName = 'Q4500'
    end
    object tMashineDetailQ5000: TFloatField
      FieldName = 'Q5000'
    end
    object tMashineDetailC_USER_ID: TSmallintField
      FieldName = 'C_USER_ID'
    end
    object tMashineDetailC_ACTIONDATETIME: TDateTimeField
      FieldName = 'C_ACTIONDATETIME'
    end
    object tMashineDetailL_ARTICLE_CODE: TStringField
      FieldName = 'L_ARTICLE_CODE'
      ProviderFlags = []
      Size = 32
    end
    object tMashineDetailL_ARTICLE_NAME: TStringField
      FieldName = 'L_ARTICLE_NAME'
      ProviderFlags = []
      Size = 64
    end
    object tMashineDetailL_ARTICLE_PRICE: TFloatField
      FieldName = 'L_ARTICLE_PRICE'
      ProviderFlags = []
    end
  end
  object qSearch: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    ParamCheck = False
    Left = 414
    Top = 53
  end
  object qrNewID: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    ParamCheck = False
    Left = 414
    Top = 101
  end
  object qIndex: TQuery
    DatabaseName = 'DBIndex'
    SessionName = 'Session_1'
    Left = 411
    Top = 154
  end
  object SumMashine: TDataSetProvider
    DataSet = qSumMashine
    Options = [poAutoRefresh, poPropogateChanges]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = HandleUpdateError
    BeforeUpdateRecord = PR_BeforeUpdateRecord
    Left = 209
    Top = 223
  end
  object qSumMashine: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    SQL.Strings = (
      'SELECT'
      '  SUM(MASHINEDETAIL.Q250 * ARTICLE.PRICE) L_250,'
      '  SUM(MASHINEDETAIL.Q500 * ARTICLE.PRICE) L_500,'
      '  SUM(MASHINEDETAIL.Q750 * ARTICLE.PRICE) L_750,'
      '  SUM(MASHINEDETAIL.Q1000 * ARTICLE.PRICE) L_1000,'
      '  SUM(MASHINEDETAIL.Q1250 * ARTICLE.PRICE) L_1250,'
      '  SUM(MASHINEDETAIL.Q1500 * ARTICLE.PRICE) L_1500,'
      '  SUM(MASHINEDETAIL.Q1750 * ARTICLE.PRICE) L_1750,'
      '  SUM(MASHINEDETAIL.Q2000 * ARTICLE.PRICE) L_2000,'
      '  SUM(MASHINEDETAIL.Q2500 * ARTICLE.PRICE) L_2500,'
      '  SUM(MASHINEDETAIL.Q3000 * ARTICLE.PRICE) L_3000,'
      '  SUM(MASHINEDETAIL.Q4000 * ARTICLE.PRICE) L_4000,'
      '  SUM(MASHINEDETAIL.Q4500 * ARTICLE.PRICE) L_4500,'
      '  SUM(MASHINEDETAIL.Q5000 * ARTICLE.PRICE) L_5000'
      'FROM MASHINEDETAIL'
      '  INNER JOIN ARTICLE ON MASHINEDETAIL.ARTICLE_ID=ARTICLE.ID'
      'WHERE 1=2')
    Left = 166
    Top = 223
    object qSumMashineL_250: TFloatField
      FieldName = 'L_250'
    end
    object qSumMashineL_500: TFloatField
      FieldName = 'L_500'
    end
    object qSumMashineL_750: TFloatField
      FieldName = 'L_750'
    end
    object qSumMashineL_1000: TFloatField
      FieldName = 'L_1000'
    end
    object qSumMashineL_1250: TFloatField
      FieldName = 'L_1250'
    end
    object qSumMashineL_1500: TFloatField
      FieldName = 'L_1500'
    end
    object qSumMashineL_1750: TFloatField
      FieldName = 'L_1750'
    end
    object qSumMashineL_2000: TFloatField
      FieldName = 'L_2000'
    end
    object qSumMashineL_2500: TFloatField
      FieldName = 'L_2500'
    end
    object qSumMashineL_3000: TFloatField
      FieldName = 'L_3000'
    end
    object qSumMashineL_4000: TFloatField
      FieldName = 'L_4000'
    end
    object qSumMashineL_4500: TFloatField
      FieldName = 'L_4500'
    end
    object qSumMashineL_5000: TFloatField
      FieldName = 'L_5000'
    end
  end
  object Offers: TDataSetProvider
    DataSet = tOffers
    Options = [poAutoRefresh, poPropogateChanges]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = HandleUpdateError
    BeforeUpdateRecord = PR_BeforeUpdateRecord
    Left = 72
    Top = 179
  end
  object tOffers: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    SQL.Strings = (
      'SELECT'
      '  OFFERS.ID,'
      '  OFFERS.DOCDATE,'
      '  OFFERS.DOCNO,'
      '  OFFERS.MASHINESERIAL_ID,'
      '  OFFERS.OHOUR,'
      '  OFFERS.TOTAL,'
      '  OFFERS.VAT,'
      '  OFFERS.TOTALVAT,'
      '  OFFERS.DISCOUNT,'
      '  OFFERS.COMMENT,'
      '  OFFERS.PRINTED,'
      '  OFFERS.REV,'
      '  OFFERS.C_USER_ID,'
      '  OFFERS.C_ACTIONDATETIME,'
      '  MASHINE.NAME as L_MASHINE_NAME,'
      '  MASHINE.MTYPE as L_MASHINE_TYPE,'
      '  MASHINE.PRODUCER as L_MASHINE_PRODUCER,'
      '  MASHINESERIAL.MASHINE_ID,'
      '  MASHINESERIAL.SERIALNO as L_MASHINE_SERIALNO,'
      '  USERNAME.NAME as L_USER_NAME,'
      '  USERNAME.EMAIL as L_USER_EMAIL,'
      '  USERNAME.MOBILE as L_USER_MOBILE,'
      '  USERNAME.PHONE as L_USER_PHONE,'
      '  USERNAME.FAX as L_USER_FAX,'
      ''
      '  v_OFFERS.VTOTAL L_TOTAL,'
      '  v_OFFERS.VVAT L_VAT,'
      '  v_OFFERS.VTOTAL + v_OFFERS.VVAT L_TOTALVAT,'
      ''
      '  CLIENT.NAME AS L_CLIENT_NAME,'
      '  CLIENT.REGNO AS L_CLIENT_REGNO,'
      '  CLIENT.CONTACTPERSON AS L_CLIENT_CONTACTPERSON,'
      '  CLIENT.PHONE AS L_CLIENT_PHONE,'
      '  CLIENT.ADDRESS AS L_CLIENT_ADDRESS,'
      '  CLIENT.EMAIL AS L_CLIENT_EMAIL'
      'FROM OFFERS'
      '  INNER JOIN v_OFFERS ON v_OFFERS.ID=OFFERS.ID'
      
        '  INNER JOIN MASHINESERIAL ON MASHINESERIAL.ID=OFFERS.MASHINESER' +
        'IAL_ID'
      '  INNER JOIN MASHINE ON MASHINE.ID=MASHINESERIAL.MASHINE_ID'
      '  INNER JOIN USERNAME ON USERNAME.ID=OFFERS.C_USER_ID'
      '  INNER JOIN CLIENT ON MASHINESERIAL.CLIENT_ID=CLIENT.ID')
    Left = 27
    Top = 179
    object tOffersID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tOffersDOCDATE: TDateTimeField
      FieldName = 'DOCDATE'
      Origin = 'KMSERVICE_DATA.OFFERS.DOCDATE'
    end
    object tOffersDOCNO: TStringField
      FieldName = 'DOCNO'
      Origin = 'KMSERVICE_DATA.OFFERS.DOCNO'
      Size = 10
    end
    object tOffersOHOUR: TSmallintField
      FieldName = 'OHOUR'
      Origin = 'KMSERVICE_DATA.OFFERS.OHOUR'
    end
    object tOffersTOTAL: TFloatField
      FieldName = 'TOTAL'
      Origin = 'KMSERVICE_DATA.OFFERS.TOTAL'
    end
    object tOffersVAT: TFloatField
      FieldName = 'VAT'
      Origin = 'KMSERVICE_DATA.OFFERS.VAT'
    end
    object tOffersTOTALVAT: TFloatField
      FieldName = 'TOTALVAT'
      Origin = 'KMSERVICE_DATA.OFFERS.TOTALVAT'
    end
    object tOffersDISCOUNT: TFloatField
      FieldName = 'DISCOUNT'
      Origin = 'KMSERVICE_DATA.OFFERS.DISCOUNT'
    end
    object tOffersCOMMENT: TStringField
      FieldName = 'COMMENT'
      Origin = 'KMSERVICE_DATA.OFFERS.COMMENT'
      Size = 250
    end
    object tOffersPRINTED: TSmallintField
      FieldName = 'PRINTED'
      Origin = 'KMSERVICE_DATA.OFFERS.PRINTED'
    end
    object tOffersREV: TIntegerField
      FieldName = 'REV'
      Origin = 'KMSERVICE_DATA.OFFERS.REV'
    end
    object tOffersC_USER_ID: TIntegerField
      FieldName = 'C_USER_ID'
    end
    object tOffersC_ACTIONDATETIME: TDateTimeField
      FieldName = 'C_ACTIONDATETIME'
    end
    object tOffersMASHINESERIAL_ID: TIntegerField
      FieldName = 'MASHINESERIAL_ID'
    end
    object tOffersMASHINE_ID: TIntegerField
      FieldName = 'MASHINE_ID'
    end
    object tOffersL_MASHINE_NAME: TStringField
      FieldName = 'L_MASHINE_NAME'
      Origin = 'KMSERVICE_DATA.OFFERS.L_MASHINE_NAME'
      ProviderFlags = []
      Size = 64
    end
    object tOffersL_USER_NAME: TStringField
      FieldName = 'L_USER_NAME'
      Origin = 'KMSERVICE_DATA.OFFERS.L_USER_NAME'
      ProviderFlags = []
      Size = 64
    end
    object tOffersL_USER_EMAIL: TStringField
      FieldName = 'L_USER_EMAIL'
      Origin = 'KMSERVICE_DATA.OFFERS.L_USER_EMAIL'
      ProviderFlags = []
      Size = 50
    end
    object tOffersL_USER_MOBILE: TStringField
      FieldName = 'L_USER_MOBILE'
      Origin = 'KMSERVICE_DATA.OFFERS.L_USER_MOBILE'
      ProviderFlags = []
      Size = 50
    end
    object tOffersL_USER_PHONE: TStringField
      FieldName = 'L_USER_PHONE'
      Origin = 'KMSERVICE_DATA.OFFERS.L_USER_PHONE'
      ProviderFlags = []
      Size = 50
    end
    object tOffersL_USER_FAX: TStringField
      FieldName = 'L_USER_FAX'
      Origin = 'KMSERVICE_DATA.OFFERS.L_USER_FAX'
      ProviderFlags = []
      Size = 50
    end
    object tOffersL_TOTAL: TFloatField
      FieldName = 'L_TOTAL'
      Origin = 'KMSERVICE_DATA.OFFERS.L_TOTAL'
      ProviderFlags = []
    end
    object tOffersL_VAT: TFloatField
      FieldName = 'L_VAT'
      Origin = 'KMSERVICE_DATA.OFFERS.L_VAT'
      ProviderFlags = []
    end
    object tOffersL_TOTALVAT: TFloatField
      FieldName = 'L_TOTALVAT'
      Origin = 'KMSERVICE_DATA.OFFERS.L_TOTALVAT'
      ProviderFlags = []
    end
    object tOffersL_MASHINE_TYPE: TStringField
      FieldName = 'L_MASHINE_TYPE'
      Origin = 'KMSERVICE_DATA.MASHINE.MTYPE'
      ProviderFlags = []
      Size = 32
    end
    object tOffersL_MASHINE_SERIALNO: TStringField
      FieldName = 'L_MASHINE_SERIALNO'
      Origin = 'KMSERVICE_DATA.MASHINE.SERIALNO'
      ProviderFlags = []
      Size = 24
    end
    object tOffersL_MASHINE_PRODUCER: TStringField
      FieldName = 'L_MASHINE_PRODUCER'
      Origin = 'KMSERVICE_DATA.MASHINE.PRODUCER'
      ProviderFlags = []
      Size = 64
    end
    object tOffersL_CLIENT_NAME: TStringField
      FieldName = 'L_CLIENT_NAME'
      Origin = 'KMSERVICE_DATA.CLIENT.NAME'
      ProviderFlags = []
      Size = 64
    end
    object tOffersL_CLIENT_REGNO: TStringField
      FieldName = 'L_CLIENT_REGNO'
      Origin = 'KMSERVICE_DATA.CLIENT.REGNO'
      ProviderFlags = []
    end
    object tOffersL_CLIENT_CONTACTPERSON: TStringField
      FieldName = 'L_CLIENT_CONTACTPERSON'
      Origin = 'KMSERVICE_DATA.CLIENT.CONTACTPERSON'
      ProviderFlags = []
      Size = 64
    end
    object tOffersL_CLIENT_PHONE: TStringField
      FieldName = 'L_CLIENT_PHONE'
      Origin = 'KMSERVICE_DATA.CLIENT.PHONE'
      ProviderFlags = []
      Size = 32
    end
    object tOffersL_CLIENT_ADDRESS: TStringField
      FieldName = 'L_CLIENT_ADDRESS'
      Origin = 'KMSERVICE_DATA.CLIENT.ADDRESS'
      ProviderFlags = []
      Size = 64
    end
    object tOffersL_CLIENT_EMAIL: TStringField
      FieldName = 'L_CLIENT_EMAIL'
      Origin = 'KMSERVICE_DATA.CLIENT.EMAIL'
      ProviderFlags = []
      Size = 32
    end
  end
  object OffersDetail: TDataSetProvider
    DataSet = tOffersDetail
    Options = [poAutoRefresh, poPropogateChanges]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = HandleUpdateError
    BeforeUpdateRecord = PR_BeforeUpdateRecord
    Left = 73
    Top = 231
  end
  object tOffersDetail: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    SQL.Strings = (
      'SELECT'
      '  OFFERSDETAIL.ID,'
      '  OFFERSDETAIL.OFFERS_ID,'
      '  OFFERSDETAIL.ARTICLE_ID,'
      '  OFFERSDETAIL.QTY,'
      '  OFFERSDETAIL.PRICE,'
      '  OFFERSDETAIL.REV,'
      '  OFFERSDETAIL.C_USER_ID,'
      '  OFFERSDETAIL.C_ACTIONDATETIME,'
      ''
      '  ARTICLE.CODE L_ARTICLE_CODE,'
      '  ARTICLE.NAME L_ARTICLE_NAME,'
      ''
      '  USERNAME.NAME L_USER_NAME'
      'FROM OFFERSDETAIL'
      '  INNER JOIN ARTICLE ON ARTICLE.ID=OFFERSDETAIL.ARTICLE_ID'
      '  INNER JOIN USERNAME ON USERNAME.ID=OFFERSDETAIL.C_USER_ID'
      'WHERE 1=2')
    Left = 30
    Top = 231
    object tOffersDetailID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tOffersDetailOFFERS_ID: TIntegerField
      FieldName = 'OFFERS_ID'
    end
    object tOffersDetailARTICLE_ID: TIntegerField
      FieldName = 'ARTICLE_ID'
    end
    object tOffersDetailQTY: TFloatField
      FieldName = 'QTY'
    end
    object tOffersDetailPRICE: TFloatField
      FieldName = 'PRICE'
    end
    object tOffersDetailREV: TStringField
      FieldName = 'REV'
      Size = 100
    end
    object tOffersDetailC_USER_ID: TIntegerField
      FieldName = 'C_USER_ID'
    end
    object tOffersDetailC_ACTIONDATETIME: TDateTimeField
      FieldName = 'C_ACTIONDATETIME'
    end
    object tOffersDetailL_ARTICLE_CODE: TStringField
      FieldName = 'L_ARTICLE_CODE'
      ProviderFlags = []
      Size = 32
    end
    object tOffersDetailL_ARTICLE_NAME: TStringField
      FieldName = 'L_ARTICLE_NAME'
      ProviderFlags = []
      Size = 64
    end
    object tOffersDetailL_USER_NAME: TStringField
      FieldName = 'L_USER_NAME'
      ProviderFlags = []
      Size = 64
    end
  end
  object TempCalc: TDataSetProvider
    DataSet = qTempCalc
    Options = [poAllowCommandText]
    UpdateMode = upWhereChanged
    BeforeUpdateRecord = PR_BeforeUpdateRecord
    Left = 344
    Top = 319
  end
  object qTempCalc: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    ParamCheck = False
    Left = 304
    Top = 319
  end
  object qGetValue: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    ParamCheck = False
    Left = 346
    Top = 191
  end
  object tClient: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    SQL.Strings = (
      'SELECT'
      '  CLIENT.ID,'
      '  CLIENT.NAME,'
      '  CLIENT.REGNO,'
      '  CLIENT.ADDRESS,'
      '  CLIENT.CONTACTPERSON,'
      '  CLIENT.PHONE,'
      '  CLIENT.EMAIL,'
      '  CLIENT.C_USER_ID,'
      '  CLIENT.C_ACTIONDATETIME'
      'FROM CLIENT')
    Left = 172
    Top = 283
    object tClientID: TIntegerField
      FieldName = 'ID'
      Origin = 'KMSERVICE_DATA.CLIENT.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tClientNAME: TStringField
      FieldName = 'NAME'
      Origin = 'KMSERVICE_DATA.CLIENT.NAME'
      Size = 64
    end
    object tClientREGNO: TStringField
      FieldName = 'REGNO'
      Origin = 'KMSERVICE_DATA.CLIENT.REGNO'
    end
    object tClientADDRESS: TStringField
      FieldName = 'ADDRESS'
      Origin = 'KMSERVICE_DATA.CLIENT.ADDRESS'
      Size = 64
    end
    object tClientCONTACTPERSON: TStringField
      FieldName = 'CONTACTPERSON'
      Origin = 'KMSERVICE_DATA.CLIENT.CONTACTPERSON'
      Size = 64
    end
    object tClientPHONE: TStringField
      FieldName = 'PHONE'
      Origin = 'KMSERVICE_DATA.CLIENT.PHONE'
      Size = 32
    end
    object tClientEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'KMSERVICE_DATA.CLIENT.EMAIL'
      Size = 32
    end
    object tClientC_USER_ID: TIntegerField
      FieldName = 'C_USER_ID'
      Origin = 'KMSERVICE_DATA.CLIENT.C_USER_ID'
    end
    object tClientC_ACTIONDATETIME: TDateTimeField
      FieldName = 'C_ACTIONDATETIME'
      Origin = 'KMSERVICE_DATA.CLIENT.C_ACTIONDATETIME'
    end
  end
  object Client: TDataSetProvider
    DataSet = tClient
    Options = [poAutoRefresh, poPropogateChanges]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = HandleUpdateError
    BeforeUpdateRecord = PR_BeforeUpdateRecord
    Left = 206
    Top = 283
  end
  object MashineSerial: TDataSetProvider
    DataSet = tMashineSerial
    Options = [poAutoRefresh, poPropogateChanges]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = HandleUpdateError
    BeforeUpdateRecord = PR_BeforeUpdateRecord
    Left = 210
    Top = 330
  end
  object tMashineSerial: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    SQL.Strings = (
      'SELECT'
      '  MASHINESERIAL.ID,'
      '  MASHINESERIAL.MASHINE_ID,'
      '  MASHINESERIAL.ENGINE,'
      '  MASHINESERIAL.SERIALNO,'
      '  MASHINESERIAL.CLIENT_ID,'
      ''
      '  MASHINE.MTYPE L_MASHINE_MTYPE,'
      '  MASHINE.NAME L_MASHINE_NAME,'
      ''
      '  CLIENT.NAME L_CLIENT_NAME,'
      '  CLIENT.REGNO L_CLIENT_REGNO,'
      '  CLIENT.ADDRESS L_CLIENT_ADDRESS'
      'FROM MASHINESERIAL'
      '  INNER JOIN MASHINE ON MASHINE.ID=MASHINESERIAL.MASHINE_ID'
      '  INNEr JOIN CLIENT ON CLIENT.ID=MASHINESERIAL.CLIENT_ID'
      ''
      'WHERE 1=2')
    Left = 167
    Top = 330
    object tMashineSerialID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tMashineSerialMASHINE_ID: TIntegerField
      FieldName = 'MASHINE_ID'
    end
    object tMashineSerialENGINE: TStringField
      FieldName = 'ENGINE'
      Size = 50
    end
    object tMashineSerialSERIALNO: TStringField
      FieldName = 'SERIALNO'
      Size = 50
    end
    object tMashineSerialCLIENT_ID: TIntegerField
      FieldName = 'CLIENT_ID'
    end
    object tMashineSerialL_MASHINE_MTYPE: TStringField
      FieldName = 'L_MASHINE_MTYPE'
      ProviderFlags = []
      Size = 32
    end
    object tMashineSerialL_MASHINE_NAME: TStringField
      FieldName = 'L_MASHINE_NAME'
      ProviderFlags = []
      Size = 64
    end
    object tMashineSerialL_CLIENT_NAME: TStringField
      FieldName = 'L_CLIENT_NAME'
      ProviderFlags = []
      Size = 64
    end
    object tMashineSerialL_CLIENT_REGNO: TStringField
      FieldName = 'L_CLIENT_REGNO'
      ProviderFlags = []
    end
    object tMashineSerialL_CLIENT_ADDRESS: TStringField
      FieldName = 'L_CLIENT_ADDRESS'
      ProviderFlags = []
      Size = 64
    end
  end
  object tMashineClient: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    SQL.Strings = (
      'SELECT'
      '  MASHINE.ID,'
      '  MASHINE.MTYPE,'
      '  MASHINE.NAME,'
      '  MASHINE.PRODUCER,'
      '  MASHINE.H250,'
      '  MASHINE.H500,'
      '  MASHINE.H750,'
      '  MASHINE.H1000,'
      '  MASHINE.H1250,'
      '  MASHINE.H1500,'
      '  MASHINE.H1750,'
      '  MASHINE.H2000,'
      '  MASHINE.H2500,'
      '  MASHINE.H3000,'
      '  MASHINE.H4000,'
      '  MASHINE.H4500,'
      '  MASHINE.H5000,'
      '  MASHINE.C_USER_ID,'
      '  MASHINE.C_ACTIONDATETIME,'
      '  CLIENT.ID AS L_CLIENT_ID,'
      '  CLIENT.NAME AS L_CLIENT,'
      '  MASHINESERIAL.SERIALNO AS L_SERIALNO,'
      '  MASHINESERIAL.ENGINE AS L_ENGINE '
      'FROM MASHINE'
      
        '  INNER JOIN MASHINESERIAL ON MASHINESERIAL.MASHINE_ID=MASHINE.I' +
        'D'
      '  INNER JOIN CLIENT ON CLIENT.ID=MASHINESERIAL.CLIENT_ID')
    Left = 36
    Top = 315
    object tMashineClientID: TIntegerField
      FieldName = 'ID'
      Origin = 'KMSERVICE_DATA.MASHINE.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tMashineClientMTYPE: TStringField
      FieldName = 'MTYPE'
      Origin = 'KMSERVICE_DATA.MASHINE.MTYPE'
      Size = 32
    end
    object tMashineClientNAME: TStringField
      FieldName = 'NAME'
      Origin = 'KMSERVICE_DATA.MASHINE.NAME'
      Size = 64
    end
    object tMashineClientPRODUCER: TStringField
      FieldName = 'PRODUCER'
      Origin = 'KMSERVICE_DATA.MASHINE.PRODUCER'
      Size = 64
    end
    object tMashineClientH250: TSmallintField
      FieldName = 'H250'
      Origin = 'KMSERVICE_DATA.MASHINE.H250'
    end
    object tMashineClientH500: TSmallintField
      FieldName = 'H500'
      Origin = 'KMSERVICE_DATA.MASHINE.H500'
    end
    object tMashineClientH750: TSmallintField
      FieldName = 'H750'
      Origin = 'KMSERVICE_DATA.MASHINE.H750'
    end
    object tMashineClientH1000: TSmallintField
      FieldName = 'H1000'
      Origin = 'KMSERVICE_DATA.MASHINE.H1000'
    end
    object tMashineClientH1250: TSmallintField
      FieldName = 'H1250'
      Origin = 'KMSERVICE_DATA.MASHINE.H1250'
    end
    object tMashineClientH1500: TSmallintField
      FieldName = 'H1500'
      Origin = 'KMSERVICE_DATA.MASHINE.H1500'
    end
    object tMashineClientH1750: TSmallintField
      FieldName = 'H1750'
      Origin = 'KMSERVICE_DATA.MASHINE.H1750'
    end
    object tMashineClientH2000: TSmallintField
      FieldName = 'H2000'
      Origin = 'KMSERVICE_DATA.MASHINE.H2000'
    end
    object tMashineClientH2500: TSmallintField
      FieldName = 'H2500'
      Origin = 'KMSERVICE_DATA.MASHINE.H2500'
    end
    object tMashineClientH3000: TSmallintField
      FieldName = 'H3000'
      Origin = 'KMSERVICE_DATA.MASHINE.H3000'
    end
    object tMashineClientH4000: TSmallintField
      FieldName = 'H4000'
      Origin = 'KMSERVICE_DATA.MASHINE.H4000'
    end
    object tMashineClientH4500: TSmallintField
      FieldName = 'H4500'
      Origin = 'KMSERVICE_DATA.MASHINE.H4500'
    end
    object tMashineClientH5000: TSmallintField
      FieldName = 'H5000'
      Origin = 'KMSERVICE_DATA.MASHINE.H5000'
    end
    object tMashineClientC_USER_ID: TIntegerField
      FieldName = 'C_USER_ID'
      Origin = 'KMSERVICE_DATA.MASHINE.C_USER_ID'
    end
    object tMashineClientC_ACTIONDATETIME: TDateTimeField
      FieldName = 'C_ACTIONDATETIME'
      Origin = 'KMSERVICE_DATA.MASHINE.C_ACTIONDATETIME'
    end
    object tMashineClientL_CLIENT_ID: TIntegerField
      FieldName = 'L_CLIENT_ID'
      ProviderFlags = []
    end
    object tMashineClientL_CLIENT: TStringField
      FieldName = 'L_CLIENT'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object tMashineClientL_SERIALNO: TStringField
      FieldName = 'L_SERIALNO'
      ProviderFlags = []
      Size = 50
    end
    object tMashineClientL_ENGINE: TStringField
      FieldName = 'L_ENGINE'
      ProviderFlags = []
      Size = 50
    end
  end
  object qrSetValue: TQuery
    DatabaseName = 'kmService_Data'
    SessionName = 'Session_1'
    ParamCheck = False
    Left = 410
    Top = 199
  end
  object qrDocNo: TQuery
    DatabaseName = 'DBIndex'
    SessionName = 'Session_1'
    Left = 411
    Top = 250
  end
end
