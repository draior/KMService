unit Client;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BASEENTITY, Menus, ImgList, Db, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  Grids, DBGrids, DBCtrls, Mask, ActnList, Buttons, AppEvnts, DBClient,
  FormConstants, XPMenu, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.Ribbon, Vcl.ScreenTips,
  Vcl.RibbonLunaStyleActnCtrls;

type
  TfClient = class(TfBaseEntity)
    Label7: TLabel;
    eName: TDBEdit;
    acAGSelect: TAction;
    acSupplierSelect: TAction;
    acStoreRestrictShow: TAction;
    acSupplier2Select: TAction;
    acSelectVATGroup: TAction;
    acSelectMitaList: TAction;
    acSelectPriceGroup: TAction;
    acIEStart: TAction;
    acSelectProducer: TAction;
    Label3: TLabel;
    eRegNo: TDBEdit;
    eAddress: TDBEdit;
    Label1: TLabel;
    eContact: TDBEdit;
    Label4: TLabel;
    ePhone: TDBEdit;
    eEmail: TDBEdit;
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
  end;

var
  fClient: TfClient;

implementation

uses DataModule, CommonUtilities, SelectorUtilities,
     HistoryLogConst, Utilities, ULogUtils;

{$R *.DFM}

procedure TfClient.FormCreate(Sender: TObject);
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

procedure TfClient.tbPostClick(Sender: TObject);
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

procedure TfClient.FormDestroy(Sender: TObject);
begin
  inherited;
  DM.cdsArticle.Filtered := False;
end;

procedure TfClient.tbApplyFilterClick(Sender: TObject);
begin
  inherited;
  DM.cdsArticle.Filtered := False;
end;

procedure TfClient.tbResetFilterClick(Sender: TObject);
begin
  inherited;
  DM.cdsArticle.Filtered := True;
end;

end.
