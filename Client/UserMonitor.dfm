object fUserMonitor: TfUserMonitor
  Left = 293
  Top = 150
  HelpContext = 101
  ClientHeight = 236
  ClientWidth = 471
  Color = clGradientActiveCaption
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 471
    Height = 34
    Align = alTop
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Caption = ' '#1040#1082#1090#1080#1074#1085#1080' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1080
    Color = clGray
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Panel3: TPanel
    Left = 0
    Top = 182
    Width = 471
    Height = 35
    Align = alBottom
    Alignment = taLeftJustify
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 5
      Top = 5
      Width = 75
      Height = 25
      Action = acNotifyClient
      Caption = #1057#1098#1086#1073#1097#1077#1085#1080#1077
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 390
      Top = 5
      Width = 75
      Height = 25
      Caption = #1048#1079#1093#1086#1076
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 85
      Top = 5
      Width = 75
      Height = 25
      Action = acRefreshList
      Caption = #1054#1073#1085#1086#1074#1103#1074#1072#1085#1077
      TabOrder = 2
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 217
    Width = 471
    Height = 19
    Panels = <>
    ParentColor = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 34
    Width = 471
    Height = 148
    Align = alClient
    TabOrder = 3
    object lvUsers: TListView
      Left = 1
      Top = 1
      Width = 469
      Height = 146
      Align = alClient
      Columns = <
        item
          Caption = 'ID'
        end
        item
          Caption = #1054#1073#1077#1082#1090
          Width = 200
        end
        item
          Caption = #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083
          Width = 150
        end>
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object alUserMonitor: TActionList
    Left = 340
    Top = 5
    object acNotifyClient: TAction
      Caption = #1057#1098#1086#1073#1097#1077#1085#1080#1077
      OnExecute = acNotifyClientExecute
      OnUpdate = acNotifyClientUpdate
    end
    object acRefreshList: TAction
      Caption = #1054#1073#1085#1086#1074#1103#1074#1072#1085#1077
      OnExecute = acRefreshListExecute
    end
  end
  object XPMenu: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Color = clBtnFace
    IconBackColor = clBtnFace
    MenuBarColor = clBtnFace
    SelectColor = clHighlight
    SelectBorderColor = clHighlight
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = True
    OverrideOwnerDraw = False
    Gradient = False
    FlatMenu = False
    AutoDetect = False
    Active = True
    Left = 387
    Top = 4
  end
end
