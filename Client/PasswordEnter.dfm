object fPasswordEnter: TfPasswordEnter
  Left = 258
  Top = 170
  HelpContext = 47
  ActiveControl = ePassword
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 195
  ClientWidth = 302
  Color = clGradientActiveCaption
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  DesignSize = (
    302
    195)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TBitBtn
    Left = 6
    Top = 162
    Width = 93
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1042#1093#1086#1076
    Default = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    ModalResult = 1
    NumGlyphs = 2
    Style = bsNew
    TabOrder = 1
  end
  object btnCancel: TBitBtn
    Left = 104
    Top = 162
    Width = 93
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1082#1072#1079
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 302
    Height = 32
    Align = alTop
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Caption = ' '#1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1072#1090#1072
    Color = clInactiveCaption
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object btnConnection: TBitBtn
    Left = 202
    Top = 162
    Width = 93
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1057#1098#1088#1074#1098#1088' >>'
    TabOrder = 3
    Visible = False
    OnClick = btnConnectionClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 32
    Width = 302
    Height = 124
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      302
      124)
    object Label1: TLabel
      Left = 6
      Top = 5
      Width = 65
      Height = 13
      Caption = #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083':'
    end
    object Label2: TLabel
      Left = 6
      Top = 45
      Width = 41
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1072':'
    end
    object lblComputer: TLabel
      Left = 6
      Top = 85
      Width = 110
      Height = 13
      Caption = #1050#1086#1084#1087#1102#1090#1098#1088' '#1079#1072' '#1074#1088#1098#1079#1082#1072':'
      Visible = False
    end
    object cbUser: TComboBox
      Left = 6
      Top = 20
      Width = 289
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object ePassword: TEdit
      Left = 6
      Top = 60
      Width = 121
      Height = 21
      Hint = #1055#1072#1088#1086#1083#1072
      ParentShowHint = False
      PasswordChar = '*'
      ShowHint = True
      TabOrder = 1
    end
    object edtComputer: TEdit
      Left = 6
      Top = 100
      Width = 289
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Visible = False
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
    Left = 232
    Top = 72
  end
end
