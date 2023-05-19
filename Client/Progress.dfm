object fProgress: TfProgress
  Left = 313
  Top = 167
  BorderStyle = bsDialog
  ClientHeight = 111
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 5
    Top = 30
    Width = 41
    Height = 13
    Caption = #1055#1072#1082#1077#1090#1080':'
  end
  object Label2: TLabel
    Left = 5
    Top = 65
    Width = 46
    Height = 13
    Caption = #1058#1072#1073#1083#1080#1094#1080':'
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 25
    Align = alTop
    Alignment = taLeftJustify
    Caption = ' '#1054#1073#1088#1072#1073#1086#1090#1082#1072'. '#1052#1086#1083#1103' '#1087#1086#1095#1072#1082#1072#1081#1090#1077'...'
    Color = clInactiveCaption
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object pbBGSend: TProgressBar
    Left = 5
    Top = 45
    Width = 381
    Height = 16
    TabOrder = 1
  end
  object pbTables: TProgressBar
    Left = 5
    Top = 80
    Width = 381
    Height = 16
    TabOrder = 2
  end
  object mReport: TMemo
    Left = 5
    Top = 140
    Width = 381
    Height = 131
    Color = clBtnFace
    ScrollBars = ssVertical
    TabOrder = 3
  end
end
