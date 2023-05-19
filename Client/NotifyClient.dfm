object fNotifyClient: TfNotifyClient
  Left = 260
  Top = 223
  HelpContext = 43
  BorderStyle = bsDialog
  ClientHeight = 177
  ClientWidth = 429
  Color = clGradientActiveCaption
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 30
    Width = 429
    Height = 109
    Align = alClient
    TabOrder = 0
    object mMessage: TMemo
      Left = 1
      Top = 1
      Width = 427
      Height = 107
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 139
    Width = 429
    Height = 38
    Align = alBottom
    ParentColor = True
    TabOrder = 1
    object btnOk: TBitBtn
      Left = 7
      Top = 7
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnClear: TBitBtn
      Left = 345
      Top = 7
      Width = 75
      Height = 25
      Caption = '&'#1048#1079#1095#1080#1089#1090#1080
      TabOrder = 1
      OnClick = btnClearClick
    end
    object btnSave: TBitBtn
      Left = 265
      Top = 7
      Width = 75
      Height = 25
      Caption = '&'#1047#1072#1087#1080#1089
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C00000000000000000000000000000000000000000000
        000000001F7C1F7C0000104210420000000000000000000000001F7C1F7C0000
        104200001F7C1F7C0000104210420000000000000000000000001F7C1F7C0000
        104200001F7C1F7C0000104210420000000000000000000000001F7C1F7C0000
        104200001F7C1F7C000010421042000000000000000000000000000000000000
        104200001F7C1F7C000010421042104210421042104210421042104210421042
        104200001F7C1F7C000010421042000000000000000000000000000000001042
        104200001F7C1F7C0000104200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        104200001F7C1F7C0000104200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        104200001F7C1F7C0000104200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        104200001F7C1F7C0000104200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        104200001F7C1F7C0000104200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        000000001F7C1F7C0000104200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        1F7C00001F7C1F7C000000000000000000000000000000000000000000000000
        000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      TabOrder = 2
      OnClick = btnSaveClick
    end
  end
  object pDocumentName: TPanel
    Left = 0
    Top = 0
    Width = 429
    Height = 30
    Align = alTop
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Caption = ' '
    Color = clInactiveCaption
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object SaveDlg: TSaveDialog
    DefaultExt = 'txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074' '#1092#1072#1081#1083' (*.txt)|*.txt'
    Title = #1047#1072#1087#1080#1089' '#1085#1072' '#1089#1098#1086#1073#1097#1077#1085#1080#1077' '#1074#1098#1074' '#1092#1072#1081#1083
    Left = 170
    Top = 123
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
    Left = 128
    Top = 122
  end
end
