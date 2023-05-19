unit Article;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BASEENTITY, Menus, ImgList, Db, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  Grids, DBGrids, DBCtrls, Mask, ActnList, Buttons, AppEvnts, DBClient,
  FormConstants, XPMenu, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.Ribbon, Vcl.ScreenTips,
  Vcl.RibbonLunaStyleActnCtrls, SelectorUtilities;

type
  TfArticle = class(TfBaseEntity)
    eCode: TDBEdit;
    Label7: TLabel;
    eName: TDBEdit;
    dbcbUsed: TDBCheckBox;
    Label1: TLabel;
    ePrice: TDBEdit;
    Label3: TLabel;
    eReplCode: TDBEdit;
    eSupplyPrice: TDBEdit;
    Label4: TLabel;
    eDescription: TDBEdit;
    Label5: TLabel;
    XPMenu: TXPMenu;
    ActionManager: TActionManager;
    ScreenTipsManager: TScreenTipsManager;
    Ribbon: TRibbon;
    rpOperation: TRibbonPage;
    rgFiles: TRibbonGroup;
    rpFilter: TRibbonPage;
    rgOffers: TRibbonGroup;
    procedure FormCreate(Sender: TObject);
    procedure tbPostClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tbApplyFilterClick(Sender: TObject);
    procedure tbResetFilterClick(Sender: TObject);
  private
  public
    procedure SetSelectorMode(ShowOption: TShowOption); override;
  end;

var
  fArticle: TfArticle;

implementation

uses
  DataModule, CommonUtilities,  HistoryLogConst, Utilities, ULogUtils;

{$R *.DFM}

procedure TfArticle.FormCreate(Sender: TObject);
begin
  inherited;

  try
    DM.cdsArticle.Filtered := True;
    //TODO DRAGO DM.AAfterInsert := ea_AI_Article;
    //TODO DRAGO DM.AAfterUpdate := ea_AU_Article;

  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      WriteToLog(E.Message, 'Article.FormCreate', '', '');
    end;
  end;
end;

procedure TfArticle.tbPostClick(Sender: TObject);
begin
  try
    //ako sme pisali neshto e Edit-a da go zapishe v poleto i da preiz4isli.
    SelectNext(ActiveControl, True, True);
    SelectNext(ActiveControl, False, True);

    acPost.Execute;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      WriteToLog(E.Message, 'Article.tbPostClick', '', '');
    end;
  end;
end;

procedure TfArticle.FormDestroy(Sender: TObject);
begin
  inherited;
  DM.cdsArticle.Filtered := False;
end;

procedure TfArticle.SetSelectorMode(ShowOption: TShowOption);
begin
  inherited;

  if acSelect.Enabled then
    eSupplyPrice.PasswordChar := '*';
end;

procedure TfArticle.tbApplyFilterClick(Sender: TObject);
begin
  inherited;
  DM.cdsArticle.Filtered := False;
end;

procedure TfArticle.tbResetFilterClick(Sender: TObject);
begin
  inherited;
  DM.cdsArticle.Filtered := True;
end;

end.
