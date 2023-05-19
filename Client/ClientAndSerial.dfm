inherited fClientSerial: TfClientSerial
  Tag = 3
  Left = 209
  Top = 104
  HelpContext = 8
  ClientHeight = 559
  OldCreateOrder = True
  ExplicitHeight = 586
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter2: TSplitter
    Left = 405
    Top = 175
    Height = 365
    ExplicitLeft = 405
    ExplicitTop = 207
    ExplicitHeight = 476
  end
  inherited dbgList: TDBGrid
    Top = 175
    Width = 405
    Height = 365
    Columns = <
      item
        Expanded = False
        FieldName = 'SERIALNO'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'L_MASHINE_NAME'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENGINE'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'L_MASHINE_MTYPE'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'L_CLIENT_NAME'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'L_CLIENT_REGNO'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'L_CLIENT_ADDRESS'
        Width = 120
        Visible = True
      end>
  end
  inherited pcList: TPageControl
    Tag = 10
    Left = 408
    Top = 175
    Width = 392
    Height = 365
    ExplicitLeft = 408
    ExplicitTop = 175
    ExplicitWidth = 392
    ExplicitHeight = 365
    inherited tsInfo: TTabSheet
      ExplicitWidth = 384
      ExplicitHeight = 339
      inherited Label2: TLabel
        Left = 5
        Top = 27
        Width = 69
        Caption = #1052#1072#1096#1080#1085#1072' ['#1080#1084#1077']'
        ParentFont = True
        ExplicitLeft = 5
        ExplicitTop = 27
        ExplicitWidth = 69
      end
      inherited lbPositionDescription: TLabel
        Width = 384
        Caption = ' '#1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
        Color = clGray
        ExplicitWidth = 376
      end
      object lSerialNo: TLabel
        Tag = 1
        Left = 5
        Top = 67
        Width = 70
        Height = 13
        Caption = #1057#1077#1088#1080#1077#1085' '#1085#1086#1084#1077#1088
      end
      object sbMashine: TSpeedButton
        Tag = 10
        Left = 353
        Top = 42
        Width = 21
        Height = 21
        Action = acMashine
        Anchors = [akTop, akRight]
        Flat = True
        ParentShowHint = False
        ShowHint = True
        Visible = False
        ExplicitLeft = 345
      end
      object lEngine: TLabel
        Tag = 1
        Left = 5
        Top = 107
        Width = 49
        Height = 13
        Caption = #1044#1074#1080#1075#1072#1090#1077#1083
      end
      object lClient: TLabel
        Tag = 1
        Left = 5
        Top = 147
        Width = 37
        Height = 13
        Caption = #1050#1083#1080#1077#1085#1090
      end
      object sbClient: TSpeedButton
        Tag = 10
        Left = 353
        Top = 162
        Width = 21
        Height = 21
        Action = acClient
        Anchors = [akTop, akRight]
        Flat = True
        ParentShowHint = False
        ShowHint = True
        ExplicitLeft = 345
      end
      object eMashineName: TDBEdit
        Tag = 1
        Left = 5
        Top = 42
        Width = 341
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        Color = 12703726
        DataField = 'L_MASHINE_NAME'
        DataSource = dsList
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 0
      end
      object eSerial: TDBEdit
        Tag = 1
        Left = 5
        Top = 82
        Width = 172
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'SERIALNO'
        DataSource = dsList
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object eEngine: TDBEdit
        Tag = 1
        Left = 5
        Top = 122
        Width = 172
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'ENGINE'
        DataSource = dsList
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object eClient: TDBEdit
        Tag = 1
        Left = 5
        Top = 162
        Width = 341
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'L_CLIENT_NAME'
        DataSource = dsList
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
    end
  end
  inherited pMainCaptionHolder: TPanel
    Top = 143
    ExplicitTop = 143
    inherited pList: TPanel
      Caption = ' '#1050#1083#1080#1077#1085#1090#1080' '#1080' '#1089#1077#1088#1080#1081#1085#1080' '#1085#1086#1084#1077#1088#1072
    end
  end
  inherited sb: TStatusBar
    Top = 540
    ExplicitTop = 540
  end
  object Ribbon: TRibbon [5]
    Left = 0
    Top = 0
    Width = 800
    Height = 143
    ActionManager = ActionManager
    ScreenTips = ScreenTipsManager
    Caption = #1050#1048#1056#1054#1042' '#1052#1040#1064#1048#1053#1048' '#1057#1045#1056#1042#1048#1047
    Tabs = <
      item
        Caption = '  '#1054#1087#1077#1088#1072#1094#1080#1080' '
        Page = rpOperation
      end
      item
        Caption = #1060#1080#1083#1090#1088#1080' '#1080' '#1087#1077#1095#1072#1090
        Page = rpFilter
      end>
    DesignSize = (
      800
      143)
    StyleName = 'Ribbon - Luna'
    object rpFilter: TRibbonPage
      Left = 0
      Top = 50
      Width = 799
      Height = 93
      Caption = #1060#1080#1083#1090#1088#1080' '#1080' '#1087#1077#1095#1072#1090
      Index = 1
      object rgOffers: TRibbonGroup
        Left = 4
        Top = 3
        Width = 385
        Height = 86
        ActionManager = ActionManager
        GroupIndex = 0
      end
    end
    object rpOperation: TRibbonPage
      Left = 0
      Top = 50
      Width = 799
      Height = 93
      Caption = '  '#1054#1087#1077#1088#1072#1094#1080#1080' '
      Index = 0
      object rgFiles: TRibbonGroup
        Left = 4
        Top = 3
        Width = 693
        Height = 86
        ActionManager = ActionManager
        Caption = ' '
        GroupIndex = 0
      end
    end
  end
  inherited dsList: TDataSource
    DataSet = DM.cdsMashineSerial
    Left = 275
  end
  inherited pmList: TPopupMenu
    OwnerDraw = True
  end
  inherited acList: TActionList
    object acMashine: TAction
      Caption = '...'
      OnExecute = acMashineExecute
    end
    object acClient: TAction
      Caption = '...'
      OnExecute = acClientExecute
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
    Left = 752
    Top = 36
  end
  object ScreenTipsManager: TScreenTipsManager
    FooterImage.Data = {
      07544269746D61709E020000424D9E0200000000000036000000280000000E00
      00000E000000010018000000000068020000C40E0000C40E0000000000000000
      0000FF0099FF0099FF0099B8B8B8DADADABDAFAAC7ACA2C9AEA3C1B3ADE7E7E7
      CFCFCFFF0099FF0099FF00990000FF0099FF0099C7C7C7BDA49BA65336B85029
      BC532AC1572BC55A2CB86039CBB0A4D9D9D9FF0099FF00990000FF0099C7C7C7
      9D6B5CAE4927B24C28BC6241DCBCAFDDAF9CC2582BC5592CC4592BB37E68D9D9
      D9FF00990000C7C7C7B9A099A84426AC4727B14B28C18E7CCFCFCFE3E3E3BF55
      2AC0562BC0562BBE552AC8AEA4CFCFCF0000DCDCDCA4543AA84627AA4626AE49
      27B25231B5826FC4836BBA522ABB532ABB532ABA5229AA5636E7E7E70000BEB1
      ADB0502FB65631A84426AB4727AD5B3FA8A8A8AB9188B64F29B75029B64F29B5
      4E29B34D28BFB1AC0000C2ABA3B35633BD6138B85932A84426AB4727A2A2A2A7
      A7A7AE5C3FB24C28B24C28B14B28AF4A27C4ABA20000C8B2AAB55B37BD643BC2
      693CBE6338AF4E2CA66855A8A8A8A9A3A1B3684EAD4827AC4827AB4726C2A9A1
      0000CFC6C2B96744BC673EC06A3EC26B3EC46C3DBF6538BF907CC7C7C7CFC2BE
      AA4727AE4B29AC4929BCAFAB0000EBEBEBC89780BB6A42BE6C41C98B6ADCC1B2
      CF9474DBBAA9E8E8E8EEEEEEC06137BA5932A6553BDBDBDB0000B8B8B8EBE3E0
      C2805DBB6F45CA8F6FF4F4F4F5F5F5F5F5F5F6F6F6E5C9BCBB5E37B25230C0A7
      A0C7C7C70000FF0099CECECEDBCAC1C2835FBE7952D8AE96E9D1C4EEDACFD9AA
      93BF6C47B45936A37465C7C7C7FF00990000FF0099FF0099DCDCDCEBE4E1C9A0
      87BC7751B96F46BA6C44B96740B06B4DC1AAA2C7C7C7FF0099FF00990000FF00
      99FF0099FF0099D6D6D6ECECECD3CCC8D1BFB5CEBBB2C9BFBADEDEDEB8B8B8FF
      0099FF0099FF00990000}
    GradientEndColor = clScrollBar
    LinkedActionLists = <
      item
        Caption = 'ActionManager1'
      end
      item
        Caption = 'alBulletNumberGallery'
      end>
    ScreenTips = <
      item
        Description.Strings = (
          'Opens an existing file')
        Header = 'Open...'
      end
      item
        Description.Strings = (
          'Saves the active file with a new name')
        Header = 'Save As...'
      end
      item
        Description.Strings = (
          'Print Setup')
        Header = 'Print Setup...'
      end
      item
        Description.Strings = (
          'Show the Page Setup dialog')
        Header = 'Page Setup...'
      end
      item
        Description.Strings = (
          'Quits the application')
        Header = 'Exit Ribbon Demo'
      end
      item
        Description.Strings = (
          'Cuts the selection and puts it on the Clipboard')
        Header = 'Cut'
      end
      item
        Description.Strings = (
          'Copies the selection and puts it on the Clipboard')
        Header = 'Copy'
      end
      item
        Description.Strings = (
          'Inserts Clipboard contents')
        Header = 'Paste'
      end
      item
        Description.Strings = (
          'Selects the entire document')
        Header = 'Select All'
      end
      item
        Description.Strings = (
          'Reverts the last action')
        Header = 'Undo'
      end
      item
        Description.Strings = (
          'Erases the selection')
        Header = 'Delete'
      end
      item
        Description.Strings = (
          'Save the current document')
        Header = 'Save'
      end
      item
        Description.Strings = (
          'Create a new document')
        Header = 'New'
      end
      item
        Description.Strings = (
          'Make the selected text bold')
        Header = 'Bold'
      end
      item
        Description.Strings = (
          'Italicize the selected text')
        Header = 'Italic'
      end
      item
        Description.Strings = (
          'Underline the selected text')
        Header = 'Underline'
      end
      item
        Description.Strings = (
          'Strike out the selected text')
        Header = 'Strikeout'
      end
      item
        Description.Strings = (
          'Inserts a bullet on the current line')
        Header = 'Bullets'
      end
      item
        Description.Strings = (
          'Aligns text at the left indent')
        Header = 'Align Left'
      end
      item
        Description.Strings = (
          'Aligns text at the right indent')
        Header = 'Align Right'
      end
      item
        Description.Strings = (
          'Centers text between margins')
        Header = 'Center'
      end
      item
        Description.Strings = (
          'Finds the specified text')
        Header = 'Find...'
      end
      item
        Description.Strings = (
          'Replaces specific text with different text')
        Header = 'Replace'
      end
      item
        Description.Strings = (
          'Change the ribbon style to Luna')
        Header = 'Luna'
      end
      item
        Description.Strings = (
          'Change the ribbon style to Obsidian')
        Header = 'Obsidian'
      end
      item
        Description.Strings = (
          'Change the ribbon style to Silver')
        Header = 'Silver'
      end
      item
        Description.Strings = (
          'Close the current document')
        Header = 'Close'
      end
      item
        Description.Strings = (
          'Save the current document as text')
        Header = 'Save As Text'
      end
      item
        Description.Strings = (
          'Save the current document as RTF')
        Header = 'Save As RTF'
      end
      item
        Description.Strings = (
          'Print the current document to the default printer')
        Header = 'Quick Print'
      end
      item
        Description.Strings = (
          'Preview the current document')
        Header = 'Print Preview'
      end
      item
        Description.Strings = (
          'Increase the current font size by 1 pt')
        Header = 'Grow Font'
      end
      item
        Description.Strings = (
          'Decrease the current font size by 1 pt')
        Header = 'Shrink Font'
      end
      item
        Description.Strings = (
          'Create small letters below the text baseline')
        Header = 'Subscript'
      end
      item
        Description.Strings = (
          'Create small letters above the line of text')
        Header = 'Superscript'
      end
      item
        Header = 'Sentence case.'
      end
      item
        Header = 'lowercase'
      end
      item
        Header = 'UPPERCASE'
      end
      item
        Header = 'Capitalize Each Word'
      end
      item
        Header = 'tOGGLE cASE'
      end
      item
        Description.Strings = (
          'Make text look like it was marked with a highlighter pen')
        Header = 'Highlight Color'
      end
      item
        Description.Strings = (
          'Change the text color')
        Header = 'Font Color'
      end
      item
        Description.Strings = (
          'Change the case of the selected text')
        Header = 'Change Case'
      end
      item
        Description.Strings = (
          'Paste formatted text into the current document')
        Header = 'Paste as Special...'
      end
      item
        Description.Strings = (
          'Paste the clipboard contents as a hyperlink')
        Header = 'Paste as Hyperlink'
      end
      item
        Description.Strings = (
          'Runs an application')
        Header = 'Run...'
      end
      item
        Description.Strings = (
          'Show the Font Selection dialog')
        Header = 'Font'
      end
      item
        Description.Strings = (
          'Show the printer options dialog')
        Header = 'Print...'
      end
      item
        Description.Strings = (
          'Sample Radio Button item 1')
        Header = 'RadioAction1'
      end
      item
        Description.Strings = (
          'Sample Radio Button item 2')
        Header = 'RadioAction2'
      end
      item
        Description.Strings = (
          'Sample Radio Button item 3')
        Header = 'RadioAction3'
      end
      item
        Description.Strings = (
          'Sample Check Box item 1')
        Header = 'CheckboxAction1'
      end
      item
        Description.Strings = (
          'Sample Check Box item 2')
        Header = 'CheckboxAction2'
      end
      item
        Description.Strings = (
          'Sample Check Box item 3')
        Header = 'CheckboxAction3'
      end
      item
        Header = 'Calibri'
      end
      item
        Header = 'Cambria'
      end
      item
        Header = 'Courier New'
      end
      item
        Header = 'Arial Rounded MT Bold'
      end
      item
        Header = 'Arial'
      end
      item
        Header = 'Arial Narrow'
      end
      item
        Header = 'Tahoma'
      end
      item
        Header = 'Segoe UI'
      end
      item
        Header = 'Segoe Script'
      end
      item
        Description.Strings = (
          'Inserts numbering on the current line')
        Header = 'Numbering'
      end
      item
        Header = 'Action2'
      end
      item
        Header = 'Action3'
      end
      item
        Header = 'Action4'
      end
      item
        Header = 'Action5'
      end
      item
        Header = 'Action6'
      end
      item
        Header = 'Action7'
      end
      item
        Header = 'Action8'
      end
      item
        Header = 'Action9'
      end>
    Left = 120
    Top = 272
  end
  object ActionManager: TActionManager
    ActionBars = <
      item
      end
      item
      end
      item
        Items = <
          item
            Action = acSelect
            ImageIndex = 0
            ShortCut = 16449
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = acAdd
            ImageIndex = 1
            ShortCut = 16462
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = acEdit
            ImageIndex = 2
            ShortCut = 113
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = acPost
            ImageIndex = 5
            ShortCut = 16467
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = acDelete
            ImageIndex = 3
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = acCancel
            ImageIndex = 4
            ShortCut = 16474
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = acRefresh
            ImageIndex = 6
            ShortCut = 116
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = acClose
            ImageIndex = 7
            ShortCut = 16499
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = rgFiles
      end
      item
        Items = <
          item
            Action = acFilter
            ImageIndex = 8
            ShortCut = 16454
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = acResetFilter
            ImageIndex = 9
            ShortCut = 16466
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = acPrint
            ImageIndex = 10
            ShortCut = 16464
            CommandProperties.ButtonSize = bsLarge
          end
          item
            Action = acHelp
            ImageIndex = 11
            ShortCut = 112
            CommandProperties.ButtonSize = bsLarge
          end>
        ActionBar = rgOffers
      end>
    LinkedActionLists = <
      item
        ActionList = acList
        Caption = 'acList'
      end>
    Images = ImageList
    Left = 64
    Top = 280
    StyleName = 'Ribbon - Luna'
  end
end
