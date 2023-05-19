object fMsgForm: TfMsgForm
  Left = 330
  Top = 132
  Width = 554
  Height = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object dbg: TDBGrid
    Left = 0
    Top = 0
    Width = 546
    Height = 288
    Align = alClient
    DataSource = ds
    PopupMenu = PopupMenu
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ds: TDataSource
    Left = 48
    Top = 56
  end
  object PopupMenu: TPopupMenu
    Left = 80
    Top = 56
    object pmExport: TMenuItem
      Caption = 'Експорт'
      OnClick = pmExportClick
    end
  end
  object SaveDialog: TSaveDialog
    Filter = 'Text Files|*.txt|Excel Files|*.xls|All Files|*.*'
    FilterIndex = 2
    Left = 61
    Top = 88
  end
end
