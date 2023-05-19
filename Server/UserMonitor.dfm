object fUserMonitor: TfUserMonitor
  Left = 229
  Top = 148
  ClientHeight = 292
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 273
    Width = 513
    Height = 19
    Panels = <>
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 513
    Height = 32
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
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 32
    Width = 513
    Height = 206
    Align = alClient
    TabOrder = 2
    object lvUsers: TListView
      Left = 1
      Top = 1
      Width = 511
      Height = 204
      Align = alClient
      Columns = <
        item
          Caption = 'ID'
        end
        item
          Caption = #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083
          Width = 150
        end
        item
          Caption = #1044#1072#1090#1072' / '#1095#1072#1089
          Width = 100
        end>
      HotTrackStyles = [htHandPoint]
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 238
    Width = 513
    Height = 35
    Align = alBottom
    Alignment = taLeftJustify
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
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
      Left = 85
      Top = 5
      Width = 75
      Height = 25
      Action = acClientDisconnect
      Caption = #1055#1088#1077#1082#1098#1089#1074#1072#1085#1077
      TabOrder = 1
    end
  end
  object alUserMonitor: TActionList
    Left = 450
    object acNotifyClient: TAction
      Caption = #1057#1098#1086#1073#1097#1077#1085#1080#1077
      OnExecute = acNotifyClientExecute
      OnUpdate = acNotifyClientUpdate
    end
    object acClientDisconnect: TAction
      Caption = #1055#1088#1077#1082#1098#1089#1074#1072#1085#1077
      OnExecute = acClientDisconnectExecute
      OnUpdate = acNotifyClientUpdate
    end
  end
end
