object fPasswordChange: TfPasswordChange
  Left = 304
  Top = 131
  HelpContext = 46
  BorderStyle = bsDialog
  ClientHeight = 241
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  DesignSize = (
    282
    241)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 34
    Width = 282
    Height = 169
    TabOrder = 3
    DesignSize = (
      282
      169)
    object Label4: TLabel
      Left = 7
      Top = 5
      Width = 65
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083':'
    end
    object Label2: TLabel
      Left = 7
      Top = 45
      Width = 74
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1057#1090#1072#1088#1072' '#1087#1072#1088#1086#1083#1072':'
    end
    object Label1: TLabel
      Left = 7
      Top = 85
      Width = 68
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1053#1086#1074#1072' '#1087#1072#1088#1086#1083#1072':'
    end
    object Label3: TLabel
      Left = 7
      Top = 125
      Width = 127
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1053#1086#1074#1072' '#1087#1072#1088#1086#1083#1072' ('#1087#1088#1086#1074#1077#1088#1082#1072'):'
    end
    object edtUser: TEdit
      Left = 7
      Top = 20
      Width = 267
      Height = 21
      TabStop = False
      Anchors = [akLeft, akBottom]
      CharCase = ecUpperCase
      Color = clInfoBk
      TabOrder = 0
    end
    object eOldPassword: TEdit
      Left = 7
      Top = 60
      Width = 267
      Height = 21
      Anchors = [akLeft, akBottom]
      PasswordChar = '*'
      TabOrder = 1
    end
    object eNewPassword: TEdit
      Left = 7
      Top = 100
      Width = 267
      Height = 21
      Anchors = [akLeft, akBottom]
      PasswordChar = '*'
      TabOrder = 2
    end
    object eNewPasswordCheck: TEdit
      Left = 7
      Top = 140
      Width = 267
      Height = 21
      Anchors = [akLeft, akBottom]
      PasswordChar = '*'
      TabOrder = 3
    end
  end
  object btnOk: TBitBtn
    Left = 5
    Top = 210
    Width = 90
    Height = 26
    Anchors = [akLeft, akBottom]
    Caption = #1055#1088#1086#1084#1103#1085#1072
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
    NumGlyphs = 2
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Left = 100
    Top = 210
    Width = 90
    Height = 26
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1082#1072#1079
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object pList: TPanel
    Left = 0
    Top = 0
    Width = 282
    Height = 34
    Align = alTop
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Caption = ' '#1055#1088#1086#1084#1103#1085#1072' '#1085#1072' '#1087#1072#1088#1086#1083#1072
    Color = clInactiveCaption
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end
