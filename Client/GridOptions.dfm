object fGridOptions: TfGridOptions
  Left = 351
  Top = 243
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  ClientHeight = 224
  ClientWidth = 611
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    611
    224)
  PixelsPerInch = 96
  TextHeight = 13
  object pMain: TPanel
    Left = 0
    Top = 0
    Width = 611
    Height = 34
    Align = alTop
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1080
    Color = clInactiveCaption
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 34
    Width = 611
    Height = 157
    Anchors = [akLeft, akTop, akRight]
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 1
    DesignSize = (
      611
      157)
    object Label1: TLabel
      Left = 353
      Top = 10
      Width = 90
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
    end
    object Label2: TLabel
      Left = 353
      Top = 35
      Width = 46
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1056#1072#1079#1084#1077#1088':'
    end
    object Label3: TLabel
      Left = 353
      Top = 60
      Width = 47
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1060#1086#1088#1084#1072#1090':'
    end
    object Label4: TLabel
      Left = 353
      Top = 85
      Width = 33
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1062#1074#1103#1090':'
    end
    object Label5: TLabel
      Left = 353
      Top = 135
      Width = 49
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1042#1080#1076#1080#1084#1086':'
    end
    object Label6: TLabel
      Left = 353
      Top = 110
      Width = 91
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1055#1086#1076#1088#1072#1074#1085#1103#1074#1072#1085#1077':'
    end
    object edtCaption: TEdit
      Left = 444
      Top = 5
      Width = 156
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
      OnChange = edtCaptionChange
    end
    object edtSize: TEdit
      Left = 444
      Top = 30
      Width = 156
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnChange = edtSizeChange
    end
    object edtFormat: TEdit
      Left = 444
      Top = 55
      Width = 156
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnChange = edtFormatChange
    end
    object cbVisible: TComboBox
      Left = 444
      Top = 130
      Width = 156
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 3
      OnChange = cbVisibleChange
      Items.Strings = (
        #1044#1072
        #1053#1077)
    end
    object cbAlignment: TComboBox
      Left = 444
      Top = 105
      Width = 156
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 5
      OnChange = cbAlignmentChange
      Items.Strings = (
        #1051#1103#1074#1086' '#1087#1086#1076#1088#1072#1074#1085#1077#1085#1086
        #1062#1077#1085#1090#1088#1080#1088#1072#1085#1086
        #1044#1103#1089#1085#1086' '#1087#1086#1076#1088#1072#1074#1085#1077#1085#1086)
    end
    object sgFields: TStringGrid
      Left = 5
      Top = 5
      Width = 340
      Height = 146
      Anchors = [akLeft, akTop, akRight]
      ColCount = 6
      Ctl3D = True
      DefaultRowHeight = 19
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goColMoving]
      ParentCtl3D = False
      TabOrder = 4
      OnDrawCell = sgFieldsDrawCell
      OnSelectCell = sgFieldsSelectCell
      ColWidths = (
        170
        52
        55
        38
        90
        52)
    end
  end
  object BitBtn1: TBitBtn
    Left = 5
    Top = 196
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1047#1072#1087#1080#1089
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 85
    Top = 196
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1082#1072#1079
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
end
