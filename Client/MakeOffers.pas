unit MakeOffers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BASEENTITY, Menus, ImgList, Db, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  Grids, DBGrids, DBCtrls, Mask, ActnList, dbClient, Variants, DBGridShadow,
  Vcl.Buttons, XPMenu, Vcl.RibbonLunaStyleActnCtrls, Vcl.ActnMan, Vcl.ScreenTips,
  Vcl.ActnCtrls, Vcl.Ribbon;

type
  TfMakeOffers = class(TfBaseEntity)
    dsDetail: TDataSource;
    dbgDetail: TDBGrid;
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
    pFilter: TPanel;
    Label3: TLabel;
    eMashineName: TEdit;
    sbMashine: TSpeedButton;
    lSerialNo: TLabel;
    eSerial: TEdit;
    lClient: TLabel;
    eClient: TEdit;
    sbClient: TSpeedButton;
    cbHour: TComboBox;
    lSelect: TLabel;
    acSelectMashine: TAction;
    acSelectClient: TAction;
    acMakeOffer: TAction;
    lDate: TLabel;
    dbeDate: TDBEdit;
    lHour: TLabel;
    dbeHour: TDBEdit;
    lSerNo: TLabel;
    dbeSerNo: TDBEdit;
    Label5: TLabel;
    dbeComment: TDBMemo;
    Label1: TLabel;
    Label4: TLabel;
    XPMenu: TXPMenu;
    ScreenTipsManager: TScreenTipsManager;
    ActionManager: TActionManager;
    Ribbon: TRibbon;
    rpFilter: TRibbonPage;
    rgOffers: TRibbonGroup;
    rpOperation: TRibbonPage;
    rgFiles: TRibbonGroup;
    acUnsortDetail: TAction;
    pmRevision: TPopupMenu;
    dbeRev: TDBEdit;
    lVersion: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acDeleteExecute(Sender: TObject);
    procedure acSelectMashineExecute(Sender: TObject);
    procedure acSelectClientExecute(Sender: TObject);
    procedure eClientKeyPress(Sender: TObject; var Key: Char);
    procedure eMashineNameKeyPress(Sender: TObject; var Key: Char);
    procedure tbApplyFilterClick(Sender: TObject);
    procedure acMakeOfferExecute(Sender: TObject);
    procedure dbgDetailDblClick(Sender: TObject);
    procedure acSelectArticlesExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tbButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure acUnsortDetailExecute(Sender: TObject);
    procedure dbgDetailMouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    procedure acPrintExecute(Sender: TObject);
    procedure acAddExecute(Sender: TObject);
  private
    { Private declarations }
    ClientID: Integer;
    MashineID: Integer;
    AI: TDataSetNotifyEvent;
    DID: Integer;

    procedure CalcPrice();
    procedure BuildRev;
    procedure RevOnClick(Sender: TObject);
  public
    procedure ApplyFilter;
    procedure SetChangeFields; override;
    procedure AfterInsert(DataSet: TDataSet);
  end;

var
  fMakeOffers: TfMakeOffers;

implementation

uses
  DataModule, Utilities, SelectorUtilities, FormConstants,
  ULogUtils, Mess, SelectMsg;

{$R *.DFM}

procedure TfMakeOffers.acAddExecute(Sender: TObject);
begin
  if TAction(Sender).Tag = 13 then begin
    if dsList.DataSet.FieldByName('REV').AsInteger >= MaxEditOffers then begin
      MessageDlg('Офертaта не може да бъде редактирана повече от '+IntToStr(MaxEditOffers)+' пъти!', mtError, [mbOK], 0);
      Exit;
    end;
  end;

  inherited;
end;

procedure TfMakeOffers.acDeleteExecute(Sender: TObject);
begin
  inherited;
  //ДА НЕ ГО ТРИЯ
end;

procedure TfMakeOffers.acMakeOfferExecute(Sender: TObject);
var
  H, ID, MSID: Integer;
  lcResult, SerNo, ClientCond, Range: String;
  lcItems: TStringList;
label Ex;
begin
  if MashineID = 0 then begin
    MessageDlg('Не е избрана машина за която да се съдаде оферта!', mtError, [mbOK], 0);
    Exit;
  end;

  lcItems := TStringList.Create;
  try
    if Trim(cbHour.Text) = '' then begin
      lcResult := SelectForm(cbHour.Items, 'Изберете период', 'За кой период иската да изготвите оферта?');
      if lcResult = '' then
        goto Ex;
      H := StrToInt(Trim(Copy(lcResult, 1, 4)));
    end
    else
      H := StrToInt(cbHour.Text);

    DM.ServerData.AppServer.BeginTrans;
    ClientCond := '';
    if ClientID <> 0 then
      ClientCond := ' AND CLIENT_ID='+IntToStr(ClientID);
    SerNo := eSerial.Text;
    if SerNo = '' then begin
      DM.SetCommandText(DM.cdsMiscQuery, 'select ID from MASHINESERIAL WHERE Mashine_ID='+IntToStr(MashineID)+ClientCond);
      SerNo := ' ';
    end
    else begin
      if DM.ServerData.AppServer.CheckMashineSerial(MashineID, SerNo, Range) <> 0 then
        raise Exception.Create('Зададен е невалиден сериен номер. Диапазона за номера е: '+Range);

      DM.SetCommandText(DM.cdsMiscQuery, 'select ID from MASHINESERIAL WHERE Mashine_ID='+IntToStr(MashineID)+' AND SERIALNO="'+SerNo+'"'+ClientCond);
    end;
    MSID := DM.cdsMiscQuery.Fields[0].AsInteger;
    if MSID = 0 then begin
      DM.SetCommandText(DM.cdsMiscQuery, 'select MAX(ID)+1 from MASHINESERIAL');
      MSID := DM.cdsMiscQuery.Fields[0].AsInteger;
      DM.SetCommandText(DM.cdsMiscQuery, 'insert into MASHINESERIAL(ID, MASHINE_ID, SERIALNO, CLIENT_ID) '+
           ' VALUES('+IntToStr(MSID)+', '+IntToStr(MashineID)+', '''+SerNo+''', '+IntToStr(ClientID)+')', False);
    end;

    if DM.ServerData.AppServer.MakeOffer(MSID, H, ID) = 0 then begin
      DM.ServerData.AppServer.CommitTrans;

      DM.ServerData.AppServer.RequestDoc('OFFERS', 'OFFERS.ID = ' + IntToStr(ID), '', 1);
      DM.ReOpen(CDS[0]);
      MessageDlg('Офертата е създадена успешно!', mtInformation, [mbOk], 0);
    end
    else begin
      DM.ServerData.AppServer.RollbackTrans;
      MessageDlg('Грешка при създаване на оферта!', mtError, [mbOk], 0);
    end;

    Ex:;
  except
    on E: Exception do begin
      DM.ServerData.AppServer.RollbackTrans;
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WritetoLog(E.Message, 'TfMashine.acOfferExecute');
    end;
  end;
  FreeAndNil(lcItems);
end;

procedure TfMakeOffers.acSelectArticlesExecute(Sender: TObject);
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

procedure TfMakeOffers.acSelectClientExecute(Sender: TObject);
var
  lcCDS: TClientDataSet;
  L: TStringList;
  lcResult: String;
  Idx: Integer;
label One;
begin
  inherited;

  lcCDS := TClientDataSet.Create(Self);
  try
    lcCDS.RemoteServer := DM.ServerData;
    lcCDS.ProviderName := 'MiscQuery';
    DM.SetCommandText(lcCDS, 'SELECT CLIENT.ID, CLIENT.NAME FROM CLIENT WHERE 1 = 2' );

    lcCDS.Insert;

    if InsertItemEx(
         fc_Client,
         'ID;NAME',
         'CLIENT.ID',
         VarArrayOf( [eClient.Text] ),
         lcCDS,
         'ID;NAME',
         [],
         ShowSelector,
         so_SelectSingle ) = mrOK then
    begin
      ClientID := lcCDS.FieldByName('ID').AsInteger;
      eClient.Text := lcCDS.FieldByName('NAME').AsString;
    end
    else begin
      ClientID := 0;
      eClient.Text := '';
    end;

    lcCDS.Cancel;

    if (ClientID <> 0) and (Trim(eMashineName.Text) = '') then begin
      DM.SetCommandText(DM.cdsMiscQuery, 'SELECT MS.ID, M.ID MASHINE_ID, M.NAME, MS.SERIALNO, MS.ENGINE FROM MASHINESERIAL MS, MASHINE M '+
                                         '  WHERE MS.MASHINE_ID=M.ID AND MS.CLIENT_ID='+ IntToStr(ClientID));

      if DM.cdsMiscQuery.RecordCount > 0 then begin
        if DM.cdsMiscQuery.RecordCount = 1 then
          goto One;

        L := TStringList.Create;
        while not DM.cdsMiscQuery.Eof do begin
          L.AddObject(DM.cdsMiscQuery.FieldByName('NAME').AsString + ' / ' + DM.cdsMiscQuery.FieldByName('SERIALNO').AsString + ' / ' +
                      DM.cdsMiscQuery.FieldByName('ENGINE').AsString, Pointer(DM.cdsMiscQuery.Fields[0].AsInteger));
          DM.cdsMiscQuery.Next;
        end;
        lcResult := SelectForm(L, 'Изберете машина', 'Машина / сериен номер / двигател');
        if lcResult <> '' then begin
          Idx := L.IndexOf(lcResult);
          if Idx <> -1 then begin
            if DM.cdsMiscQuery.Locate('ID', Integer(L.Objects[Idx]), []) then begin
              One:
              MashineID := DM.cdsMiscQuery.FieldByName('MASHINE_ID').AsInteger;
              eMashineName.Text := DM.cdsMiscQuery.FieldByName('NAME').AsString;
              eSerial.Text := DM.cdsMiscQuery.FieldByName('SERIALNO').AsString;
            end;
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      WriteToLog(E.Message, 'TfMakeOffers.acSelectClientExecute');
    end;
  end;
  FreeAndNil(L);
  FreeAndNil(lcCDS);
end;

procedure TfMakeOffers.acSelectMashineExecute(Sender: TObject);
var
  lcCDS: TClientDataSet;
begin
  inherited;

  lcCDS := TClientDataSet.Create(Self);
  try
    lcCDS.RemoteServer := DM.ServerData;
    lcCDS.ProviderName := 'MiscQuery';
    DM.SetCommandText(lcCDS, 'SELECT MASHINE.ID, MASHINE.NAME, '+
                             '''                                                  '' CLIENT, 0 AS L_CLIENT_ID, '+
                             '''                                                  '' AS SERIALNO FROM MASHINE WHERE 1 = 2' );

    lcCDS.Insert;

    if InsertItemEx(
         fc_Mashine,
         'ID;NAME;L_CLIENT;L_SERIALNO;L_CLIENT_ID',
         'MASHINE.ID',
         VarArrayOf( [eMashineName.Text] ),
         lcCDS,
         'ID;NAME;CLIENT;SERIALNO;L_CLIENT_ID',
         [],
         ShowSelector,
         so_SelectSingle ) = mrOK then
    begin
      MashineID := lcCDS.FieldByName('ID').AsInteger;
      eMashineName.Text := lcCDS.FieldByName('NAME').AsString;
      eSerial.Text := lcCDS.FieldByName('SERIALNO').AsString;
      eClient.Text := lcCDS.FieldByName('CLIENT').AsString;
      ClientID := lcCDS.FieldByName('L_CLIENT_ID').AsInteger;
    end
    else begin
      MashineID := 0;
      ClientID := 0;
      eMashineName.Text := '';
      eSerial.Text := '';
      eClient.Text := '';
    end;

    lcCDS.Cancel;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      WriteToLog(E.Message, 'TfMakeOffers.acSelectMashineExecute');
    end;
  end;
  FreeAndNil(lcCDS);
end;

procedure TfMakeOffers.acUnsortDetailExecute(Sender: TObject);
begin
  try
    inherited;
    CDS[1].IndexFieldNames := 'ID';
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog( E.Message, 'TfOffers.tbUnsortDetailClick');
    end;
  end;
end;

procedure TfMakeOffers.AfterInsert(DataSet: TDataSet);
begin
  try
    if DID = 0 then begin
      DM.SetCommandText(DM.cdsMiscQuery, 'SELECT MAX(ID)+1 FROM OFFERSDETAIL');
      DID := DM.cdsMiscQuery.Fields[0].AsInteger;
    end
    else
      DID := DID + 1;
    DataSet.FieldByName('ID').AsInteger := DID;
    DataSet.FieldByName('OFFERS_ID').AsInteger := dsList.DataSet.FieldByName('ID').AsInteger;
    DataSet.FieldByName('C_USER_ID').AsString := DM.CurrentUserID;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      WriteToLog(E.Message, 'TfMakeOffers.AfterInsert');
    end;
  end;
end;

procedure TfMakeOffers.ApplyFilter;
var
  sWhere: String;
begin
  if (ClientID = 0) and (MashineID = 0) and (Trim(eSerial.Text) = '') then begin
    MessageDlg('Не е избран критерий за търсене. Филтърът няма да се изпълни!', mtError, [mbOK], 0);
    Exit;
  end;
  if MashineID = 0 then begin
    MessageDlg('Не е избрана машина за която да се прегледат оферти!', mtError, [mbOK], 0);
    Exit;
  end;

  Screen.Cursor := crSQLWait;
  try
    if ClientID <> 0 then
      sWhere := sWhere + ' AND (CLIENT.ID = '+IntToStr(ClientID)+') ';
    if MashineID <> 0 then
      sWhere := sWhere + ' AND (MASHINE.ID = '+IntToStr(MashineID)+') ';
    if Trim(eSerial.Text) <> '' then
      sWhere := sWhere + ' AND (MASHINESERIAL.SERIALNO = '''+eSerial.Text+''') ';
    if Trim(cbHour.Text) <> '' then
      sWhere := sWhere + ' AND (OFFERS.OHOUR = '''+cbHour.Text+''') ';
    Delete(sWhere, 1, 4);

    DM.cdsOffersDetail.Close;
    DM.ServerData.AppServer.RequestDoc('Offers', sWhere, '', 0);
    DM.ReOpen(DM.cdsOffers);
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      WriteToLog(E.Message, 'TfMakeOffers.ApplyFilter');
    end;
  end;
  Screen.Cursor := crDefault;
end;

var
  LastID: Integer = 0;

procedure TfMakeOffers.BuildRev;
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

procedure TfMakeOffers.CalcPrice;
var
  DDID: Integer;
  T: Double;
begin
  DM.cdsOffersDetail.DisableControls;
  DDID := DM.cdsOffersDetail.FieldByName('ID').AsInteger;
  try
    T := 0;
    DM.cdsOffersDetail.First;
    while not DM.cdsOffersDetail.Eof do begin
      T := T + DM.cdsOffersDetail.FieldByName('Qty').AsFloat * DM.cdsOffersDetail.FieldByName('Price').AsFloat;
      DM.cdsOffersDetail.Next;
    end;

    if DM.cdsOffers.State <> dsEdit then
      DM.cdsOffers.Edit;
    DM.cdsOffers.FieldByName('TOTALVAT').AsFloat := T;
    DM.cdsOffers.FieldByName('TOTAL').AsFloat := T / 1.2;
    DM.cdsOffers.FieldByName('VAT').AsFloat := DM.cdsOffers.FieldByName('TOTALVAT').AsFloat - DM.cdsOffers.FieldByName('TOTAL').AsFloat;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOk], 0)
  end;
  DM.cdsOffersDetail.Locate('ID', DDID, []);
  DM.cdsOffersDetail.EnableControls;
end;

procedure TfMakeOffers.dbgDetailDblClick(Sender: TObject);
begin
  try
    if DM.AllowDBLClick then acSelectArticles.Execute;
  except
    on E: Exception do WritetoLog(E.Message, 'TfMakeOffers.dbgDetailDblClick');
  end;
end;

procedure TfMakeOffers.dbgDetailMouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
  if Button = mbRight then
    BuildRev;
end;

procedure TfMakeOffers.eClientKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #8 then begin
    ClientID := 0;
    eClient.Text := '';
  end;
end;

procedure TfMakeOffers.eMashineNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #8 then begin
    MashineID := 0;
    eMashineName.Text := '';
  end;
end;

procedure TfMakeOffers.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;

  DM.MAfterScroll := nil;
end;

procedure TfMakeOffers.FormCreate(Sender: TObject);
begin
  try
    inherited;

    SetLength(CDS, 2);
    CDS[1] := DM.cdsOffersDetail;
    AI := DM.cdsOffersDetail.AfterInsert;
    DM.cdsOffersDetail.AfterInsert := AfterInsert;
  except
    on E: Exception do WritetoLog(E.Message, 'TfOffers.FormCreate', '', '');
  end;
end;

procedure TfMakeOffers.FormDestroy(Sender: TObject);
begin
  inherited;

  DM.cdsOffersDetail.AfterInsert := AI;
end;

procedure TfMakeOffers.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (ActiveControl = dbeComment) then
    Exit;

  inherited;
end;

procedure TfMakeOffers.RevOnClick(Sender: TObject);
begin
  DM.ServerData.AppServer.RequestDoc('OffersDetail', 'OFFERSDETAIL.OFFERS_ID = ' + IntToStr(DM.cdsOffers.FieldByName('ID').AsInteger) +
        'AND OFFERSDETAIL.REV LIKE "%;' + IntToStr(TMenuItem(Sender).Tag) + ';%"', '', 0);
    DM.ReOpen(DM.cdsOffersDetail);
end;

procedure TfMakeOffers.SetChangeFields;
begin
  try
    SetLength(ChangeFieldsArray, 2);

    ChangeFieldsArray[0].Field := dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_CODE');
    ChangeFieldsArray[0].OldProc := dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_CODE').OnChange;
    ChangeFieldsArray[0].ExecAction := acSelectArticles;
    dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_CODE').OnChange := FieldOnChange;

    ChangeFieldsArray[1].Field := dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_NAME');
    ChangeFieldsArray[1].OldProc := dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_NAME').OnChange;
    ChangeFieldsArray[1].ExecAction := acSelectArticles;
    dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_NAME').OnChange := FieldOnChange;

  except
    on E: Exception do WritetoLog(E.Message, 'TfMakeOffers.SetChangeFields');
  end;
end;

procedure TfMakeOffers.tbApplyFilterClick(Sender: TObject);
begin
  ApplyFilter;
end;

procedure TfMakeOffers.tbButtonClick(Sender: TObject);
begin
  if Sender = acPost then
    CalcPrice;

  if Sender = acAdd then
    acMakeOffer.Execute
  else
    inherited;
end;

procedure TfMakeOffers.acPrintExecute(Sender: TObject);
var
  CurrRev: Integer;
begin
  CurrRev := dsList.DataSet.FieldByName('REV').AsInteger;
  if Print('Default.rtm') and (CurrRev < MaxEditOffers) then begin
    DM.ServerData.AppServer.BeginTrans;
    try
      if DM.ServerData.AppServer.SetFieldValue('OFFERS', dsList.DataSet.FieldByName('ID').AsInteger, 'REV', IntToStr(CurrRev+1), False) <> 0 then
        SysUtils.Abort;

      DM.SetCommandText(DM.cdsMiscQuery, 'UPDATE OFFERSDETAIL SET REV=F_NULLDFT(REV, '''')||";' + IntToStr(CurrRev+1)+
            ';" WHERE ID>0 AND OFFERS_ID=' + dsList.DataSet.FieldByName('ID').AsString, False);
      DM.SetCommandText(DM.cdsMiscQuery, 'UPDATE OFFERSDETAIL SET ID=-ID WHERE ID<0 AND OFFERS_ID=' + dsList.DataSet.FieldByName('ID').AsString, False);

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
end;

end.
