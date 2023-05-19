object fSelectMsg: TfSelectMsg
  Left = 247
  Top = 208
  HelpContext = 91
  BorderStyle = bsDialog
  ClientHeight = 115
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    327
    115)
  PixelsPerInch = 96
  TextHeight = 13
  object bSelect: TBitBtn
    Left = 5
    Top = 88
    Width = 75
    Height = 24
    Anchors = [akBottom]
    Caption = #1048#1079#1073#1086#1088
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object bCancel: TBitBtn
    Left = 85
    Top = 88
    Width = 75
    Height = 24
    Anchors = [akBottom]
    Caption = #1054#1090#1082#1072#1079
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
  object pnlList: TPanel
    Left = 0
    Top = 34
    Width = 327
    Height = 49
    Align = alTop
    TabOrder = 0
    TabStop = True
    DesignSize = (
      327
      49)
    object lSelect: TLabel
      Left = 5
      Top = 6
      Width = 317
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Color = clBtnFace
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object cbSelect: TComboBox
      Left = 5
      Top = 22
      Width = 317
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 0
    end
  end
  object pnlCaption: TPanel
    Left = 0
    Top = 0
    Width = 327
    Height = 34
    Align = alTop
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Caption = ' '
    Color = clBtnShadow
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
end
