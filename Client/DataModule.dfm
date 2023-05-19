object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 340
  Width = 562
  object cdsMiscQuery: TClientDataSet
    Aggregates = <>
    CommandText = 'select ID, NAME from UserName'
    ObjectView = False
    Params = <>
    ProviderName = 'MiscQuery'
    Left = 280
    Top = 16
  end
  object cdsArticle: TClientDataSet
    Aggregates = <>
    Filter = 'USED = 1'
    PacketRecords = 64
    Params = <>
    ProviderName = 'Article'
    BeforeGetRecords = CDS_BeforeGetRecords
    AfterGetRecords = CDS_AfterGetRecords
    Left = 144
    Top = 17
    object cdsArticleID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object cdsArticleCODE: TStringField
      DisplayLabel = #1050#1086#1076
      FieldName = 'CODE'
      Origin = 'MTKAMI2000_DATA_SL.ARTICLE.CODE'
      Size = 32
    end
    object cdsArticleREPLCODE: TStringField
      FieldName = 'REPLCODE'
      Size = 32
    end
    object cdsArticleNAME: TStringField
      DisplayLabel = #1048#1084#1077
      FieldName = 'NAME'
      Origin = 'MTKAMI2000_DATA_SL.ARTICLE.NAME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object cdsArticlePRICE: TFloatField
      DisplayLabel = #1062#1077#1085#1072
      FieldName = 'PRICE'
      DisplayFormat = '0.00'
    end
    object cdsArticleSUPPLYPRICE: TFloatField
      FieldName = 'SUPPLYPRICE'
    end
    object cdsArticleDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 250
    end
    object cdsArticleUSED: TSmallintField
      DisplayLabel = #1040#1082#1090#1080#1074#1077#1085
      FieldName = 'USED'
    end
    object cdsArticleC_ACTIONDATETIME: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1080' '#1095#1072#1089' '#1085#1072' '#1087#1086#1089#1083#1077#1076#1085#1072' '#1088#1077#1076#1072#1082#1094#1080#1103
      FieldName = 'C_ACTIONDATETIME'
      Origin = 'MTKAMI2000_DATA_SL.ARTICLE.C_ACTIONDATETIME'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object cdsArticleC_USER_ID: TIntegerField
      FieldName = 'C_USER_ID'
      Visible = False
    end
  end
  object cdsUserName: TClientDataSet
    Aggregates = <>
    Filter = 'USED = 1'
    PacketRecords = 64
    Params = <>
    ProviderName = 'UserName'
    AfterInsert = cdsUserNameAfterInsert
    BeforeGetRecords = CDS_BeforeGetRecords
    AfterGetRecords = CDS_AfterGetRecords
    Left = 144
    Top = 65
    object IntegerField1: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object StringField2: TStringField
      DisplayLabel = #1048#1084#1077
      FieldName = 'NAME'
      Origin = 'MTKAMI2000_DATA_SL.USERNAME.NAME'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object cdsUserNamePASS: TStringField
      FieldName = 'PASS'
      Size = 16
    end
    object cdsUserNameRIGHTS: TStringField
      FieldName = 'RIGHTS'
      Size = 50
    end
    object SmallintField1: TSmallintField
      DisplayLabel = #1040#1082#1090#1080#1074#1077#1085
      FieldName = 'USED'
    end
    object cdsUserNameEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 50
    end
    object cdsUserNameMOBILE: TStringField
      FieldName = 'MOBILE'
      Size = 50
    end
    object cdsUserNamePHONE: TStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object cdsUserNameFAX: TStringField
      FieldName = 'FAX'
      Size = 50
    end
    object DateTimeField1: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1080' '#1095#1072#1089' '#1085#1072' '#1087#1086#1089#1083#1077#1076#1085#1072' '#1088#1077#1076#1072#1082#1094#1080#1103
      FieldName = 'C_ACTIONDATETIME'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object cdsMashine: TClientDataSet
    Aggregates = <>
    AutoCalcFields = False
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'MTYPE'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'PRODUCER'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'H250'
        DataType = ftSmallint
      end
      item
        Name = 'H500'
        DataType = ftSmallint
      end
      item
        Name = 'H750'
        DataType = ftSmallint
      end
      item
        Name = 'H1000'
        DataType = ftSmallint
      end
      item
        Name = 'H1250'
        DataType = ftSmallint
      end
      item
        Name = 'H1500'
        DataType = ftSmallint
      end
      item
        Name = 'H1750'
        DataType = ftSmallint
      end
      item
        Name = 'H2000'
        DataType = ftSmallint
      end
      item
        Name = 'H2500'
        DataType = ftSmallint
      end
      item
        Name = 'H3000'
        DataType = ftSmallint
      end
      item
        Name = 'H4000'
        DataType = ftSmallint
      end
      item
        Name = 'H4500'
        DataType = ftSmallint
      end
      item
        Name = 'H5000'
        DataType = ftSmallint
      end
      item
        Name = 'C_USER_ID'
        DataType = ftInteger
      end
      item
        Name = 'C_ACTIONDATETIME'
        DataType = ftDateTime
      end
      item
        Name = 'L_CLIENT_ID'
        DataType = ftInteger
      end
      item
        Name = 'L_CLIENT'
        Attributes = [faFixed]
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_SERIALNO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_ENGINE'
        Attributes = [faFixed]
        DataType = ftString
        Size = 64
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'Mashine'
    StoreDefs = True
    AfterInsert = cdsMashineAfterInsert
    AfterScroll = cdsMashineAfterScroll
    BeforeGetRecords = CDS_BeforeGetRecords
    AfterGetRecords = CDS_AfterGetRecords
    Left = 40
    Top = 129
    object cdsMashineID: TIntegerField
      FieldName = 'ID'
      Origin = 'KMSERVICE_DATA.MASHINE.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object cdsMashineMTYPE: TStringField
      DisplayLabel = #1058#1080#1087
      FieldName = 'MTYPE'
      Origin = 'KMSERVICE_DATA.MASHINE.MTYPE'
      Size = 32
    end
    object cdsMashineNAME: TStringField
      DisplayLabel = #1048#1084#1077
      FieldName = 'NAME'
      Origin = 'KMSERVICE_DATA.MASHINE.NAME'
      Size = 64
    end
    object cdsMashinePRODUCER: TStringField
      DisplayLabel = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083
      FieldName = 'PRODUCER'
      Origin = 'KMSERVICE_DATA.MASHINE.PRODUCER'
      Size = 64
    end
    object cdsMashineH250: TSmallintField
      DisplayLabel = '250'
      FieldName = 'H250'
      Origin = 'KMSERVICE_DATA.MASHINE.H250'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH500: TSmallintField
      DisplayLabel = '500'
      FieldName = 'H500'
      Origin = 'KMSERVICE_DATA.MASHINE.H500'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH750: TSmallintField
      DisplayLabel = '750'
      FieldName = 'H750'
      Origin = 'KMSERVICE_DATA.MASHINE.H750'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH1000: TSmallintField
      DisplayLabel = '1000'
      FieldName = 'H1000'
      Origin = 'KMSERVICE_DATA.MASHINE.H1000'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH1250: TSmallintField
      DisplayLabel = '1250'
      FieldName = 'H1250'
      Origin = 'KMSERVICE_DATA.MASHINE.H1250'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH1500: TSmallintField
      DisplayLabel = '1500'
      FieldName = 'H1500'
      Origin = 'KMSERVICE_DATA.MASHINE.H1500'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH1750: TSmallintField
      DisplayLabel = '1750'
      FieldName = 'H1750'
      Origin = 'KMSERVICE_DATA.MASHINE.H1750'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH2000: TSmallintField
      DisplayLabel = '2000'
      FieldName = 'H2000'
      Origin = 'KMSERVICE_DATA.MASHINE.H2000'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH2500: TSmallintField
      DisplayLabel = '2500'
      FieldName = 'H2500'
      Origin = 'KMSERVICE_DATA.MASHINE.H2500'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH3000: TSmallintField
      DisplayLabel = '3000'
      FieldName = 'H3000'
      Origin = 'KMSERVICE_DATA.MASHINE.H3000'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH4000: TSmallintField
      DisplayLabel = '4000'
      FieldName = 'H4000'
      Origin = 'KMSERVICE_DATA.MASHINE.H4000'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH4500: TSmallintField
      DisplayLabel = '4500'
      FieldName = 'H4500'
      Origin = 'KMSERVICE_DATA.MASHINE.H4500'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineH5000: TSmallintField
      DisplayLabel = '5000'
      FieldName = 'H5000'
      Origin = 'KMSERVICE_DATA.MASHINE.H5000'
      OnGetText = cdsMashineGetText
    end
    object cdsMashineC_USER_ID: TIntegerField
      FieldName = 'C_USER_ID'
      Origin = 'KMSERVICE_DATA.MASHINE.C_USER_ID'
      Visible = False
    end
    object cdsMashineC_ACTIONDATETIME: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1080' '#1095#1072#1089' '#1085#1072' '#1087#1086#1089#1083#1077#1076#1085#1072' '#1088#1077#1076#1072#1082#1094#1080#1103
      FieldName = 'C_ACTIONDATETIME'
      Origin = 'KMSERVICE_DATA.MASHINE.C_ACTIONDATETIME'
      Visible = False
    end
    object cdsMashineL_CLIENT: TStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090
      FieldName = 'L_CLIENT'
      Origin = 'kmService_Data.CLIENT.NAME'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object cdsMashineL_SERIALNO: TStringField
      DisplayLabel = #1057#1077#1088#1080#1077#1085' No'
      FieldName = 'L_SERIALNO'
      Origin = 'kmService_Data.MASHINESERIAL.SERIALNO'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object cdsMashineL_ENGINE: TStringField
      DisplayLabel = #1044#1074#1080#1075#1072#1090#1077#1083
      FieldName = 'L_ENGINE'
      Origin = 'kmService_Data.MASHINESERIAL.ENGINE'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object cdsMashineL_CLIENT_ID: TIntegerField
      FieldName = 'L_CLIENT_ID'
      ProviderFlags = []
      Visible = False
    end
  end
  object cdsMashineDetail: TClientDataSet
    Aggregates = <>
    AutoCalcFields = False
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'MASHINE_ID'
        DataType = ftInteger
      end
      item
        Name = 'ARTICLE_ID'
        DataType = ftInteger
      end
      item
        Name = 'REPLARTICLE_ID'
        DataType = ftInteger
      end
      item
        Name = 'Q250'
        DataType = ftFloat
      end
      item
        Name = 'Q500'
        DataType = ftFloat
      end
      item
        Name = 'Q750'
        DataType = ftFloat
      end
      item
        Name = 'Q1000'
        DataType = ftFloat
      end
      item
        Name = 'Q1250'
        DataType = ftFloat
      end
      item
        Name = 'Q1500'
        DataType = ftFloat
      end
      item
        Name = 'Q1750'
        DataType = ftFloat
      end
      item
        Name = 'Q2000'
        DataType = ftFloat
      end
      item
        Name = 'Q2500'
        DataType = ftFloat
      end
      item
        Name = 'Q3000'
        DataType = ftFloat
      end
      item
        Name = 'Q4000'
        DataType = ftFloat
      end
      item
        Name = 'Q4500'
        DataType = ftFloat
      end
      item
        Name = 'Q5000'
        DataType = ftFloat
      end
      item
        Name = 'C_USER_ID'
        DataType = ftSmallint
      end
      item
        Name = 'C_ACTIONDATETIME'
        DataType = ftDateTime
      end
      item
        Name = 'L_ARTICLE_CODE'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'L_ARTICLE_NAME'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_ARTICLE_PRICE'
        DataType = ftFloat
      end
      item
        Name = 'L_REPL_ARTICLE_CODE'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'L_REPL_ARTICLE_NAME'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_REPL_ARTICLE_PRICE'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'MashineDetail'
    StoreDefs = True
    AfterInsert = cdsMashineDetailAfterInsert
    BeforeGetRecords = CDS_BeforeGetRecords
    AfterGetRecords = CDS_AfterGetRecords
    Left = 96
    Top = 129
    object cdsMashineDetailID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object cdsMashineDetailMASHINE_ID: TIntegerField
      FieldName = 'MASHINE_ID'
      Visible = False
    end
    object cdsMashineDetailARTICLE_ID: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1085#1072' '#1072#1088#1090#1091#1082#1091#1083#1072
      FieldName = 'ARTICLE_ID'
      Required = True
      Visible = False
    end
    object cdsMashineDetailQ250: TFloatField
      DisplayLabel = '250'
      FieldName = 'Q250'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ500: TFloatField
      DisplayLabel = '500'
      FieldName = 'Q500'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ750: TFloatField
      DisplayLabel = '750'
      FieldName = 'Q750'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ1000: TFloatField
      DisplayLabel = '1000'
      FieldName = 'Q1000'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ1250: TFloatField
      DisplayLabel = '1250'
      FieldName = 'Q1250'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ1500: TFloatField
      DisplayLabel = '1500'
      FieldName = 'Q1500'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ1750: TFloatField
      DisplayLabel = '1750'
      FieldName = 'Q1750'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ2000: TFloatField
      DisplayLabel = '2000'
      FieldName = 'Q2000'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ2500: TFloatField
      DisplayLabel = '2500'
      FieldName = 'Q2500'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ3000: TFloatField
      DisplayLabel = '3000'
      FieldName = 'Q3000'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ4000: TFloatField
      DisplayLabel = '4000'
      FieldName = 'Q4000'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ4500: TFloatField
      DisplayLabel = '4500'
      FieldName = 'Q4500'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailQ5000: TFloatField
      DisplayLabel = '5000'
      FieldName = 'Q5000'
      DisplayFormat = '0.###'
    end
    object cdsMashineDetailC_USER_ID: TSmallintField
      FieldName = 'C_USER_ID'
      Visible = False
    end
    object cdsMashineDetailC_ACTIONDATETIME: TDateTimeField
      FieldName = 'C_ACTIONDATETIME'
      Visible = False
    end
    object cdsMashineDetailL_ARTICLE_CODE: TStringField
      DisplayLabel = #1050#1086#1076
      FieldName = 'L_ARTICLE_CODE'
      ProviderFlags = []
      Size = 32
    end
    object cdsMashineDetailL_ARTICLE_NAME: TStringField
      DisplayLabel = #1048#1084#1077
      FieldName = 'L_ARTICLE_NAME'
      ProviderFlags = []
      Size = 64
    end
    object cdsMashineDetailL_ARTICLE_PRICE: TFloatField
      FieldName = 'L_ARTICLE_PRICE'
      ProviderFlags = []
    end
  end
  object cdsSumMashine: TClientDataSet
    Aggregates = <>
    ObjectView = False
    Params = <>
    ProviderName = 'SumMashine'
    Left = 64
    Top = 176
    object cdsSumMashineL_250: TFloatField
      DisplayLabel = '250'
      FieldName = 'L_250'
    end
    object cdsSumMashineL_500: TFloatField
      DisplayLabel = '500'
      FieldName = 'L_500'
    end
    object cdsSumMashineL_750: TFloatField
      DisplayLabel = '750'
      FieldName = 'L_750'
    end
    object cdsSumMashineL_1000: TFloatField
      DisplayLabel = '1000'
      FieldName = 'L_1000'
    end
    object cdsSumMashineL_1250: TFloatField
      DisplayLabel = '1250'
      FieldName = 'L_1250'
    end
    object cdsSumMashineL_1500: TFloatField
      DisplayLabel = '1500'
      FieldName = 'L_1500'
    end
    object cdsSumMashineL_1750: TFloatField
      DisplayLabel = '1750'
      FieldName = 'L_1750'
    end
    object cdsSumMashineL_2000: TFloatField
      DisplayLabel = '2000'
      FieldName = 'L_2000'
    end
    object cdsSumMashineL_2500: TFloatField
      DisplayLabel = '2500'
      FieldName = 'L_2500'
    end
    object cdsSumMashineL_3000: TFloatField
      DisplayLabel = '3000'
      FieldName = 'L_3000'
    end
    object cdsSumMashineL_4000: TFloatField
      DisplayLabel = '4000'
      FieldName = 'L_4000'
    end
    object cdsSumMashineL_4500: TFloatField
      DisplayLabel = '4500'
      FieldName = 'L_4500'
    end
    object cdsSumMashineL_5000: TFloatField
      DisplayLabel = '5000'
      FieldName = 'L_5000'
    end
  end
  object cdsOffers: TClientDataSet
    Tag = 1
    Aggregates = <>
    AutoCalcFields = False
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'DOCDATE'
        DataType = ftDateTime
      end
      item
        Name = 'DOCNO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'OHOUR'
        DataType = ftSmallint
      end
      item
        Name = 'TOTAL'
        DataType = ftFloat
      end
      item
        Name = 'VAT'
        DataType = ftFloat
      end
      item
        Name = 'TOTALVAT'
        DataType = ftFloat
      end
      item
        Name = 'DISCOUNT'
        DataType = ftFloat
      end
      item
        Name = 'COMMENT'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'PRINTED'
        DataType = ftSmallint
      end
      item
        Name = 'REV'
        DataType = ftInteger
      end
      item
        Name = 'C_USER_ID'
        DataType = ftInteger
      end
      item
        Name = 'C_ACTIONDATETIME'
        DataType = ftDateTime
      end
      item
        Name = 'MASHINESERIAL_ID'
        DataType = ftInteger
      end
      item
        Name = 'MASHINE_ID'
        DataType = ftInteger
      end
      item
        Name = 'L_MASHINE_NAME'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_USER_NAME'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_USER_EMAIL'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'L_USER_MOBILE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'L_USER_PHONE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'L_USER_FAX'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'L_TOTAL'
        DataType = ftFloat
      end
      item
        Name = 'L_VAT'
        DataType = ftFloat
      end
      item
        Name = 'L_TOTALVAT'
        DataType = ftFloat
      end
      item
        Name = 'L_MASHINE_TYPE'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'L_MASHINE_SERIALNO'
        DataType = ftString
        Size = 24
      end
      item
        Name = 'L_MASHINE_PRODUCER'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_CLIENT_NAME'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_CLIENT_REGNO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'L_CLIENT_CONTACTPERSON'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_CLIENT_PHONE'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'L_CLIENT_ADDRESS'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_CLIENT_EMAIL'
        DataType = ftString
        Size = 32
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'Offers'
    StoreDefs = True
    AfterCancel = cdsOffersAfterCancel
    AfterScroll = cdsOffersAfterScroll
    BeforeGetRecords = CDS_BeforeGetRecords
    AfterGetRecords = CDS_AfterGetRecords
    Left = 216
    Top = 129
    object cdsOffersID: TIntegerField
      FieldName = 'ID'
      Origin = 'KMSERVICE_DATA.OFFERS.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object cdsOffersDOCDATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072
      FieldName = 'DOCDATE'
      Origin = 'KMSERVICE_DATA.OFFERS.DOCDATE'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object cdsOffersDOCNO: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      FieldName = 'DOCNO'
      Origin = 'KMSERVICE_DATA.OFFERS.DOCNO'
      Size = 10
    end
    object cdsOffersOHOUR: TSmallintField
      DisplayLabel = #1063#1072#1089#1086#1074#1077
      FieldName = 'OHOUR'
      Origin = 'KMSERVICE_DATA.OFFERS.OHOUR'
    end
    object cdsOffersTOTAL: TFloatField
      DisplayLabel = #1057#1091#1084#1072
      FieldName = 'TOTAL'
      Origin = 'KMSERVICE_DATA.OFFERS.TOTAL'
      DisplayFormat = '0.00,'
    end
    object cdsOffersVAT: TFloatField
      DisplayLabel = #1044#1044#1057
      FieldName = 'VAT'
      Origin = 'KMSERVICE_DATA.OFFERS.VAT'
      DisplayFormat = '0.00,'
    end
    object cdsOffersTOTALVAT: TFloatField
      DisplayLabel = #1050#1088#1072#1081#1085#1072' '#1094#1077#1085#1072' '#1089' '#1044#1044#1057
      FieldName = 'TOTALVAT'
      Origin = 'KMSERVICE_DATA.OFFERS.TOTALVAT'
      DisplayFormat = '0.00,'
    end
    object cdsOffersDISCOUNT: TFloatField
      DisplayLabel = #1054#1090#1089#1090#1098#1087#1082#1072' %'
      FieldName = 'DISCOUNT'
      Origin = 'KMSERVICE_DATA.OFFERS.DISCOUNT'
      DisplayFormat = '0.00,'
    end
    object cdsOffersCOMMENT: TStringField
      DisplayLabel = #1047#1072#1073#1077#1083#1077#1078#1082#1072
      FieldName = 'COMMENT'
      Origin = 'KMSERVICE_DATA.OFFERS.COMMENT'
      Size = 250
    end
    object cdsOffersMASHINESERIAL_ID: TIntegerField
      FieldName = 'MASHINESERIAL_ID'
    end
    object cdsOffersMASHINE_ID: TIntegerField
      FieldName = 'MASHINE_ID'
    end
    object cdsOffersPRINTED: TSmallintField
      FieldName = 'PRINTED'
      Origin = 'KMSERVICE_DATA.OFFERS.PRINTED'
    end
    object cdsOffersREV: TIntegerField
      FieldName = 'REV'
      Origin = 'KMSERVICE_DATA.OFFERS.REV'
    end
    object cdsOffersC_USER_ID: TIntegerField
      FieldName = 'C_USER_ID'
      Visible = False
    end
    object cdsOffersC_ACTIONDATETIME: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1080' '#1095#1072#1089' '#1085#1072' '#1087#1086#1089#1083#1077#1076#1085#1072' '#1088#1077#1076#1072#1082#1094#1080#1103
      FieldName = 'C_ACTIONDATETIME'
      Visible = False
    end
    object cdsOffersL_MASHINE_NAME: TStringField
      DisplayLabel = #1052#1072#1096#1080#1085#1072
      FieldName = 'L_MASHINE_NAME'
      Origin = 'KMSERVICE_DATA.OFFERS.L_MASHINE_NAME'
      ProviderFlags = []
      Size = 64
    end
    object cdsOffersL_USER_NAME: TStringField
      DisplayLabel = #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083
      FieldName = 'L_USER_NAME'
      Origin = 'KMSERVICE_DATA.OFFERS.L_UsER_NAME'
      ProviderFlags = []
      Size = 64
    end
    object cdsOffersL_USER_EMAIL: TStringField
      FieldName = 'L_USER_EMAIL'
      Origin = 'KMSERVICE_DATA.OFFERS.L_USER_EMAIL'
      ProviderFlags = []
      Size = 50
    end
    object cdsOffersL_USER_MOBILE: TStringField
      FieldName = 'L_USER_MOBILE'
      Origin = 'KMSERVICE_DATA.OFFERS.L_UsER_MOBILE'
      ProviderFlags = []
      Size = 50
    end
    object cdsOffersL_USER_PHONE: TStringField
      FieldName = 'L_USER_PHONE'
      Origin = 'KMSERVICE_DATA.OFFERS.L_UsER_PHONE'
      ProviderFlags = []
      Size = 50
    end
    object cdsOffersL_USER_FAX: TStringField
      FieldName = 'L_USER_FAX'
      Origin = 'KMSERVICE_DATA.OFFERS.L_USER_FAX'
      ProviderFlags = []
      Size = 50
    end
    object cdsOffersL_TOTAL: TFloatField
      DisplayLabel = #1057#1091#1084#1072' '#1089' '#1086#1090#1089#1090'.'
      FieldName = 'L_TOTAL'
      Origin = 'KMSERVICE_DATA.OFFERS.L_TOTAL'
      ProviderFlags = []
      DisplayFormat = '0.00,'
    end
    object cdsOffersL_VAT: TFloatField
      DisplayLabel = #1044#1044#1057
      FieldName = 'L_VAT'
      Origin = 'KMSERVICE_DATA.OFFERS.L_VAT'
      ProviderFlags = []
    end
    object cdsOffersL_TOTALVAT: TFloatField
      DisplayLabel = #1054#1073#1097#1072' '#1089#1091#1084#1072' '#1089' '#1086#1090#1089#1090
      FieldName = 'L_TOTALVAT'
      Origin = 'KMSERVICE_DATA.OFFERS.L_TOTALVAT'
      ProviderFlags = []
    end
    object cdsOffersL_MASHINE_TYPE: TStringField
      DisplayLabel = #1058#1080#1087' '#1084#1072#1096#1080#1085#1072
      FieldName = 'L_MASHINE_TYPE'
      Origin = 'KMSERVICE_DATA.MASHINE.MTYPE'
      ProviderFlags = []
      Size = 32
    end
    object cdsOffersL_MASHINE_SERIALNO: TStringField
      DisplayLabel = #1057#1077#1088#1080#1077#1085' No'
      FieldName = 'L_MASHINE_SERIALNO'
      Origin = 'KMSERVICE_DATA.MASHINESERIAL.SERIALNO'
      ProviderFlags = []
      Size = 24
    end
    object cdsOffersL_MASHINE_PRODUCER: TStringField
      DisplayLabel = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083
      FieldName = 'L_MASHINE_PRODUCER'
      Origin = 'KMSERVICE_DATA.MASHINE.PRODUCER'
      ProviderFlags = []
      Size = 64
    end
    object cdsOffersL_CLIENT_NAME: TStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090
      FieldName = 'L_CLIENT_NAME'
      Origin = 'KMSERVICE_DATA.CLIENT.NAME'
      ProviderFlags = []
      Size = 64
    end
    object cdsOffersL_CLIENT_REGNO: TStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090' ['#1073#1091#1083#1089#1090#1072#1090']'
      FieldName = 'L_CLIENT_REGNO'
      Origin = 'KMSERVICE_DATA.CLIENT.REGNO'
      ProviderFlags = []
    end
    object cdsOffersL_CLIENT_CONTACTPERSON: TStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090' ['#1083#1080#1094#1077' '#1079#1072' '#1082#1086#1085#1090#1072#1082#1090']'
      FieldName = 'L_CLIENT_CONTACTPERSON'
      Origin = 'KMSERVICE_DATA.CLIENT.CONTACTPERSON'
      ProviderFlags = []
      Size = 64
    end
    object cdsOffersL_CLIENT_PHONE: TStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090' ['#1090#1077#1083#1077#1092#1086#1085']'
      FieldName = 'L_CLIENT_PHONE'
      Origin = 'KMSERVICE_DATA.CLIENT.PHONE'
      ProviderFlags = []
      Size = 32
    end
    object cdsOffersL_CLIENT_ADDRESS: TStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090' ['#1072#1076#1088#1077#1089']'
      FieldName = 'L_CLIENT_ADDRESS'
      Origin = 'KMSERVICE_DATA.CLIENT.ADDRESS'
      ProviderFlags = []
      Size = 64
    end
    object cdsOffersL_CLIENT_EMAIL: TStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090' [e-mail]'
      FieldName = 'L_CLIENT_EMAIL'
      Origin = 'KMSERVICE_DATA.CLIENT.EMAIL'
      ProviderFlags = []
      Size = 32
    end
  end
  object cdsOffersDetail: TClientDataSet
    Tag = 1
    Aggregates = <>
    AutoCalcFields = False
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'OFFERS_ID'
        DataType = ftInteger
      end
      item
        Name = 'ARTICLE_ID'
        DataType = ftInteger
      end
      item
        Name = 'QTY'
        DataType = ftFloat
      end
      item
        Name = 'PRICE'
        DataType = ftFloat
      end
      item
        Name = 'REV'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'C_USER_ID'
        DataType = ftInteger
      end
      item
        Name = 'C_ACTIONDATETIME'
        DataType = ftDateTime
      end
      item
        Name = 'L_ARTICLE_CODE'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'L_ARTICLE_NAME'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_USER_NAME'
        DataType = ftString
        Size = 64
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'OffersDetail'
    StoreDefs = True
    AfterInsert = cdsOffersDetailAfterInsert
    BeforeDelete = cdsOffersDetailBeforeDelete
    BeforeGetRecords = CDS_BeforeGetRecords
    AfterGetRecords = CDS_AfterGetRecords
    Left = 256
    Top = 129
    object cdsOffersDetailID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object cdsOffersDetailOFFERS_ID: TIntegerField
      FieldName = 'OFFERS_ID'
      Visible = False
    end
    object cdsOffersDetailARTICLE_ID: TIntegerField
      FieldName = 'ARTICLE_ID'
      Visible = False
    end
    object cdsOffersDetailQTY: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      FieldName = 'QTY'
      DisplayFormat = '0.000,'
    end
    object cdsOffersDetailPRICE: TFloatField
      DisplayLabel = #1062#1077#1085#1072
      FieldName = 'PRICE'
      ReadOnly = True
      DisplayFormat = '0.00,'
    end
    object cdsOffersDetailREV: TStringField
      FieldName = 'REV'
      Size = 100
    end
    object cdsOffersDetailC_USER_ID: TIntegerField
      FieldName = 'C_USER_ID'
      Visible = False
    end
    object cdsOffersDetailC_ACTIONDATETIME: TDateTimeField
      FieldName = 'C_ACTIONDATETIME'
      Visible = False
    end
    object cdsOffersDetailL_ARTICLE_CODE: TStringField
      DisplayLabel = #1040#1088#1090' ['#1082#1086#1076']'
      FieldName = 'L_ARTICLE_CODE'
      ProviderFlags = []
      ReadOnly = True
      Size = 32
    end
    object cdsOffersDetailL_ARTICLE_NAME: TStringField
      DisplayLabel = #1040#1088#1090' ['#1080#1084#1077']'
      FieldName = 'L_ARTICLE_NAME'
      ProviderFlags = []
      ReadOnly = True
      Size = 64
    end
    object cdsOffersDetailL_USER_NAME: TStringField
      DisplayLabel = #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083
      FieldName = 'L_USER_NAME'
      ProviderFlags = []
      ReadOnly = True
      Size = 64
    end
  end
  object cdsTempCalc: TClientDataSet
    Tag = 1
    Aggregates = <>
    AutoCalcFields = False
    Params = <>
    ProviderName = 'TempCalc'
    Left = 352
    Top = 16
  end
  object cdsClient: TClientDataSet
    Aggregates = <>
    PacketRecords = 64
    Params = <>
    ProviderName = 'Client'
    BeforeGetRecords = CDS_BeforeGetRecords
    AfterGetRecords = CDS_AfterGetRecords
    Left = 200
    Top = 49
    object cdsClientID: TIntegerField
      FieldName = 'ID'
    end
    object cdsClientNAME: TStringField
      DisplayLabel = #1048#1084#1077
      FieldName = 'NAME'
      Size = 64
    end
    object cdsClientREGNO: TStringField
      DisplayLabel = #1041#1091#1083#1089#1090#1072#1090
      FieldName = 'REGNO'
    end
    object cdsClientADDRESS: TStringField
      DisplayLabel = #1040#1076#1088#1077#1089
      FieldName = 'ADDRESS'
      Size = 64
    end
    object cdsClientCONTACTPERSON: TStringField
      DisplayLabel = #1051#1080#1094#1077' '#1079#1072' '#1082#1086#1085#1090#1072#1082#1090
      FieldName = 'CONTACTPERSON'
      Size = 64
    end
    object cdsClientPHONE: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE'
      Size = 32
    end
    object cdsClientEMAIL: TStringField
      DisplayLabel = 'E-MAIL'
      FieldName = 'EMAIL'
      Size = 32
    end
    object cdsClientC_USER_ID: TIntegerField
      FieldName = 'C_USER_ID'
    end
    object cdsClientC_ACTIONDATETIME: TDateTimeField
      FieldName = 'C_ACTIONDATETIME'
    end
  end
  object cdsMashineSerial: TClientDataSet
    Aggregates = <>
    AutoCalcFields = False
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'MASHINE_ID'
        DataType = ftInteger
      end
      item
        Name = 'ENGINE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'SERIALNO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CLIENT_ID'
        DataType = ftInteger
      end
      item
        Name = 'L_MASHINE_MTYPE'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'L_MASHINE_NAME'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_CLIENT_NAME'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'L_CLIENT_REGNO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'L_CLIENT_ADDRESS'
        DataType = ftString
        Size = 64
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'MashineSerial'
    StoreDefs = True
    AfterInsert = cdsMashineSerialAfterInsert
    BeforeGetRecords = CDS_BeforeGetRecords
    AfterGetRecords = CDS_AfterGetRecords
    Left = 144
    Top = 185
    object cdsMashineSerialID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsMashineSerialMASHINE_ID: TIntegerField
      FieldName = 'MASHINE_ID'
    end
    object cdsMashineSerialENGINE: TStringField
      DisplayLabel = #1044#1074#1080#1075#1072#1090#1077#1083
      FieldName = 'ENGINE'
      Origin = 'kmService_Data.MASHINESERIAL.ENGINE'
      Size = 50
    end
    object cdsMashineSerialSERIALNO: TStringField
      DisplayLabel = #1057#1077#1088'. No'
      FieldName = 'SERIALNO'
      Origin = 'kmService_Data.MASHINESERIAL.SERIALNO'
      Size = 50
    end
    object cdsMashineSerialCLIENT_ID: TIntegerField
      FieldName = 'CLIENT_ID'
    end
    object cdsMashineSerialL_MASHINE_MTYPE: TStringField
      DisplayLabel = #1052#1072#1096#1080#1085#1072' ['#1090#1080#1087']'
      FieldName = 'L_MASHINE_MTYPE'
      Origin = 'kmService_Data.MASHINE.MTYPE'
      ProviderFlags = []
      Size = 32
    end
    object cdsMashineSerialL_MASHINE_NAME: TStringField
      DisplayLabel = #1052#1072#1096#1080#1085#1072' ['#1080#1084#1077']'
      FieldName = 'L_MASHINE_NAME'
      Origin = 'kmService_Data.MASHINE.NAME'
      ProviderFlags = []
      Size = 64
    end
    object cdsMashineSerialL_CLIENT_NAME: TStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090
      FieldName = 'L_CLIENT_NAME'
      Origin = 'kmService_Data.CLIENT.NAME'
      ProviderFlags = []
      Size = 64
    end
    object cdsMashineSerialL_CLIENT_REGNO: TStringField
      DisplayLabel = #1041#1091#1083#1089#1090#1072#1090
      FieldName = 'L_CLIENT_REGNO'
      Origin = '.REGNO'
      ProviderFlags = []
    end
    object cdsMashineSerialL_CLIENT_ADDRESS: TStringField
      DisplayLabel = #1040#1076#1088#1077#1089
      FieldName = 'L_CLIENT_ADDRESS'
      Origin = 'kmService_Data.CLIENT.ADDRESS'
      ProviderFlags = []
      Size = 64
    end
  end
end
