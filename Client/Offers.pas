unit Offers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BASEENTITY, Menus, ImgList, Db, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  Grids, DBGrids, DBCtrls, Mask, ActnList, dbClient, Variants, DBGridShadow,
  XPMenu, Vcl.RibbonLunaStyleActnCtrls, Vcl.ActnMan, Vcl.ScreenTips,
  Vcl.ActnCtrls, Vcl.Ribbon, System.UITypes;

type
  TfOffers = class(TfBaseEntity)
    dsDetail: TDataSource;
    dbgDetail: TDBGrid;
    Label1: TLabel;
    acSelectArticles: TAction;
    lValuesDoc: TLabel;
    lGeneralTO: TLabel;
    dbeDiscount: TDBEdit;
    lTot2: TLabel;
    dbeTotalPrice: TDBEdit;
    lVat2: TLabel;
    dbeVAT: TDBEdit;
    dbeTotalVAT: TDBEdit;
    lTotal2: TLabel;
    dbeDate: TDBEdit;
    lDate: TLabel;
    lHour: TLabel;
    dbeHour: TDBEdit;
    dbeMashine: TDBEdit;
    Label3: TLabel;
    dbeUser: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    dbeComment: TDBMemo;
    lType: TLabel;
    dbeType: TDBEdit;
    lSerNo: TLabel;
    dbeSerNo: TDBEdit;
    Label6: TLabel;
    dbeClient: TDBEdit;
    XPMenu: TXPMenu;
    ScreenTipsManager: TScreenTipsManager;
    ActionManager: TActionManager;
    Ribbon: TRibbon;
    rpFilter: TRibbonPage;
    rgOffers: TRibbonGroup;
    rpOperation: TRibbonPage;
    rgFiles: TRibbonGroup;
    eNomer: TDBEdit;
    lNo: TLabel;
    pmRevision: TPopupMenu;
    dbeRev: TDBEdit;
    lRev: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acDeleteExecute(Sender: TObject);
    procedure dbgDetailMouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    procedure acPrintExecute(Sender: TObject);
    procedure acAddExecute(Sender: TObject);
    procedure dbgDetailDblClick(Sender: TObject);
    procedure acSelectArticlesExecute(Sender: TObject);
  private
    { Private declarations }
    procedure BuildRev;
    procedure RevOnClick(Sender: TObject);
    function CalcTotal: Boolean;
  public
  end;

var
  fOffers: TfOffers;

implementation

uses
  DataModule, Utilities, SelectorUtilities, FormConstants,
  ULogUtils, Mess, SelectMsg;

{$R *.DFM}

procedure TfOffers.acAddExecute(Sender: TObject);
begin
  if TAction(Sender).Tag = 13 then begin //Edit
    if dsList.DataSet.FieldByName('REV').AsInteger >= MaxEditOffers then begin
      MessageDlg('Офертaта не може да бъде редактирана повече от '+IntToStr(MaxEditOffers)+' пъти!', mtError, [mbOK], 0);
      Exit;
    end;
  end
  else if TAction(Sender).Tag = 16 then begin //Post
    if not CalcTotal then
      Exit;
  end;

  inherited;
end;

procedure TfOffers.acDeleteExecute(Sender: TObject);
begin
  inherited;
  //ДА НЕ ГО ТРИЯ
end;

var
  LastID: Integer;

procedure TfOffers.acPrintExecute(Sender: TObject);
var
  CurrRev: Integer;
begin
  CurrRev := dsList.DataSet.FieldByName('REV').AsInteger;
  DM.cdsOffersDetail.Filter := 'QTY > 0';
  DM.cdsOffersDetail.Filtered := True;
  if Print('Default.rtm') and (CurrRev < MaxEditOffers) then begin
    DM.ServerData.AppServer.BeginTrans;
    try
      if DM.ServerData.AppServer.SetFieldValue('OFFERS', dsList.DataSet.FieldByName('ID').AsInteger, 'REV', IntToStr(CurrRev+1), False) <> 0 then
        SysUtils.Abort;

      DM.SetCommandText(DM.cdsMiscQuery, 'UPDATE OFFERSDETAIL SET REV=REV||";' + IntToStr(CurrRev+1)+';" WHERE OFFERS_ID=' + dsList.DataSet.FieldByName('ID').AsString, False);

      DM.ServerData.AppServer.CommitTrans;
      LastID := 0;
    except
      on E: Exception do begin
        DM.ServerData.AppServer.RollbackTrans;
        MessageDlg(E.Message, mtError, [mbOk], 0);
        WritetoLog(E.Message, 'TfOffers.acPrintExecute');
      end;
    end;
  end;
  DM.cdsOffersDetail.Filtered := False;
  DM.cdsOffersDetail.Filter := '';
end;

procedure TfOffers.acSelectArticlesExecute(Sender: TObject);
var
  lcLinkField, lcLinkValue: String;
  lcSQL_ID: Integer;
  lcOption: TFilterOption;
begin
  try
    if Assigned(dbgDetail.SelectedField) then begin
      if not (dsDetail.DataSet.State = dsInsert) then Exit; // dsDetail.DataSet.Edit;

      if GetLinkField( dbgDetail, 'ARTICLE', lcLinkField, lcLinkValue ) <> 0 then
        MessageDlg('Грешка при избор на артикули!', mtError, [mbOk], 0)
      else begin
        AllowChange := false;
        DM.cdsOffersDetail.FieldByName('PRICE').ReadOnly := False;
        DM.cdsOffersDetail.FieldByName('L_ARTICLE_CODE').ReadOnly := False;
        DM.cdsOffersDetail.FieldByName('L_ARTICLE_NAME').ReadOnly := False;
        DM.cdsOffersDetail.FieldByName('L_USER_NAME').ReadOnly := False;

        lcSQL_ID := fc_Article; //TODO DRAGO
        lcOption := [];

        InsertItemEx(
          lcSQL_ID,
          'ID;CODE;NAME;PRICE',

          lcLinkField,
          VarArrayOf([lcLinkValue]),
          dsDetail.DataSet,

          'ARTICLE_ID;L_ARTICLE_CODE;L_ARTICLE_NAME;PRICE',
          lcOption,
          ShowSelector,
          so_SelectMulty);

        if not (DM.cdsOffersDetail.State in [dsEdit, dsInsert]) then
          DM.cdsOffersDetail.Edit;
        DM.cdsOffersDetail.FieldByName('L_USER_NAME').AsString := DM.CurrentUserName;
        DM.cdsOffersDetail.FieldByName('QTY').AsFloat := 1;
        DM.cdsOffersDetail.Post;

        AllowChange := True;
      end;
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WritetoLog(E.Message, 'TfMashine.acSelectArticlesExecute');
    end;
  end;
  DM.cdsOffersDetail.FieldByName('PRICE').ReadOnly := True;
  DM.cdsOffersDetail.FieldByName('L_ARTICLE_CODE').ReadOnly := True;
  DM.cdsOffersDetail.FieldByName('L_ARTICLE_NAME').ReadOnly := True;
  DM.cdsOffersDetail.FieldByName('L_USER_NAME').ReadOnly := True;
end;

procedure TfOffers.BuildRev;
var
  i: Integer;
  mi: TMenuItem;
begin
  if LastID = dsList.DataSet.FieldByName('ID').AsInteger then
    Exit;

  LastID := dsList.DataSet.FieldByName('ID').AsInteger;
  while pmRevision.Items.Count > 0 do pmRevision.Items[0].Free;
  for i := 1 to DM.cdsOffers.FieldByName('REV').AsInteger do begin
    mi := TMenuItem.Create(pmRevision);
    mi.Caption := 'Версия [' + IntToStr(i)+']';
    mi.Tag := i;
    mi.OnClick := RevOnClick;
    pmRevision.Items.Add(mi);
  end;
end;

function TfOffers.CalcTotal: Boolean;
var
  T: Currency;
begin
  Result := False;
  try
    T := 0;
    DM.cdsOffersDetail.DisableControls;
    DM.cdsOffersDetail.First;
    while not DM.cdsOffersDetail.Eof do begin
      T := T + DM.cdsOffersDetail.FieldByName('QTY').AsFloat * DM.cdsOffersDetail.FieldByName('PRICE').AsFloat;

      DM.cdsOffersDetail.Next;
    end;
    DM.cdsOffers.FieldByName('TOTALVAT').AsFloat := T * 1.2;
    DM.cdsOffers.FieldByName('TOTAL').AsFloat := T;
    DM.cdsOffers.FieldByName('VAT').AsFloat := DM.cdsOffers.FieldByName('TOTALVAT').AsFloat - DM.cdsOffers.FieldByName('TOTAL').AsFloat;

    Result := True;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WritetoLog(E.Message, 'TfOffers.CalcTotal');
    end;
  end;
  DM.cdsOffersDetail.First;
  DM.cdsOffersDetail.EnableControls;
end;

procedure TfOffers.dbgDetailDblClick(Sender: TObject);
begin
  try
    if DM.AllowDBLClick then acSelectArticles.Execute;
  except
    on E: Exception do WritetoLog(E.Message, 'TfOffers.dbgDetailDblClick');
  end;
end;

procedure TfOffers.dbgDetailMouseActivate(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
  if Button = mbRight then
    BuildRev;
end;

procedure TfOffers.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;

  DM.MAfterScroll := nil;
end;

procedure TfOffers.FormCreate(Sender: TObject);
begin
  try
    inherited;

    SetLength(CDS, 2);
    CDS[1] := DM.cdsOffersDetail;
  except
    on E: Exception do WritetoLog(E.Message, 'TfOffers.FormCreate', '', '');
  end;
end;

procedure TfOffers.RevOnClick(Sender: TObject);
begin
  DM.ServerData.AppServer.RequestDoc('OffersDetail', 'OFFERSDETAIL.OFFERS_ID = ' + IntToStr(DM.cdsOffers.FieldByName('ID').AsInteger) +
        'AND OFFERSDETAIL.REV LIKE "%;' + IntToStr(TMenuItem(Sender).Tag) + ';%"', '', 0);
    DM.ReOpen(DM.cdsOffersDetail);
end;

end.
